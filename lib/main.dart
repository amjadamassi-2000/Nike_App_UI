import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_app/drawer_screen/favorite_screen.dart';
import 'package:nike_app/nike_shoes_details.dart';
import 'package:nike_app/scoped-models/main.dart';
import 'package:nike_app/splash_screen.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login_screen.dart';
import 'nike_shoes.dart';

void main() => runApp(MainNikeShoseStore());


class MainNikeShoseStore extends StatefulWidget {
  @override
  _MainNikeShoseStoreState createState() => _MainNikeShoseStoreState();
}

class _MainNikeShoseStoreState extends State<MainNikeShoseStore> {



  List<NikeShoes> _favoriteMeals = [];

  void _toggleFavorite(String mealId) {
    final existingIndex =
    _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    setState(() {
      if (existingIndex >= 0) {
        _favoriteMeals.removeAt(existingIndex);
      } else {
        _favoriteMeals.add(shoes.firstWhere((meal) => meal.id == mealId));
      }
    });
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
     model : MainModel(),
      child: MaterialApp(
       debugShowCheckedModeBanner: false,
      // theme: ThemeData.light(),
        home: MySplashScreen(),
        routes: {

          "/login" : (context) => LoginScreen(),
          "/Home" : (context) => NikeShoseStoreHome(),
          "/details" : (context) => NikeShoesDetails(),
         // "/detailss" : (context) => NikeShoesDetails.favorite(_toggleFavorite, _isMealFavorite),

           "/favorite" : (context) => FavoritesScreen(_favoriteMeals),
        },
      ),
    );
  }
}











class NikeShoseStoreHome extends StatefulWidget {





  @override
  _NikeShoseStoreHomeState createState() => _NikeShoseStoreHomeState();
}

class _NikeShoseStoreHomeState extends State<NikeShoseStoreHome> {
  final ValueNotifier<bool> notifierBottomBarVisible = ValueNotifier(true);

  void _onShoesPressed(NikeShoes shoes, BuildContext context) async {
    notifierBottomBarVisible.value = false;
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) {
          return FadeTransition(
            opacity: animation1,
            child: NikeShoesDetails(shoes: shoes),
          );
        },
      ),



    );
    notifierBottomBarVisible.value = true;
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black,
        title:Text("Products", style: TextStyle(color: Colors.white),),
       // leading: Icon(Icons.menu),
      ),

      drawer: Drawer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 120 , top:50 ),
              child: CircleAvatar(
                child: Image.asset("images/profile.PNG" , fit: BoxFit.cover,),
                radius: 90,
                backgroundColor: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 120 , ),
              child: Text("amjadabed@gmail.com"),
            ),
            Divider(color: Colors.grey, height: 50, indent: 20,endIndent: 20, ),
            SizedBox(height:10 ,),

            ListTile(
              leading: Icon(Icons.person , color: Colors.black,),
              title: Text("Profile"),

            ),


            ListTile(
              leading: Icon(Icons.favorite , color: Colors.red,),
              title: Text("Favorite"),
            ),


            ListTile(

              leading: Icon(Icons.shopping_cart , color: Colors.black,),
              title: Text("My Cart"),

            ),

          ],
        ),
      ),
      backgroundColor: Colors.white,


      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/nike_logo.png",
                  height: 70,
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 20),
                      itemCount: shoes.length,
                      itemBuilder: (context, index) {
                        final shoesItem = shoes[index];
                        return NikeShoesItem(
                            shoesItem: shoesItem,
                            onTap: () {
                              _onShoesPressed(shoesItem, context);
                            }, productIndex: index, );
                      }),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}






class NikeShoesItem extends StatefulWidget {
  final NikeShoes shoesItem;
  final VoidCallback onTap;
  final int productIndex;
  NikeShoesItem({this.shoesItem, this.onTap , this.productIndex});

  @override
  _NikeShoesItemState createState() => _NikeShoesItemState();
}

class _NikeShoesItemState extends State<NikeShoesItem> {
  @override
  Widget build(BuildContext context) {

    const itemHeight = 290.0;

    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: SizedBox(
          height: itemHeight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: Hero(
                  tag: "background_${widget.shoesItem.model}",
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(widget.shoesItem.color),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Hero(
                  tag: "number_${widget.shoesItem.model}",
                  child: SizedBox(
                    height: itemHeight * 0.7,
                    child: Material(
                      color: Colors.transparent,
                      child: FittedBox(
                        child: Text(
                          widget.shoesItem.modelNumber.toString(),
                          style: TextStyle(
                              color: Colors.black12.withOpacity(0.02), fontSize: 180),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: 100,
                height: itemHeight * 0.7,
                child: Hero(
                  tag: "image_${widget.shoesItem.model}",
                  child: Image.asset(
                    widget.shoesItem.images.first,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 30,
                child:Icon(Icons.favorite_border),


              ),

              Positioned(
                bottom: 20,
                right: 30,
                child: Icon(
                  Icons.shopping_basket_outlined,
                  color: Colors.grey,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.shoesItem.model,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "\$${widget.shoesItem.oldPrice.toString()}",
                      style: TextStyle(
                          color: Colors.red,
                          decoration: TextDecoration.lineThrough),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "\$${widget.shoesItem.currentPrice.toString()}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}










/*
 ValueListenableBuilder<bool>(
              valueListenable: notifierBottomBarVisible,
              child: Container(
               decoration: BoxDecoration(
                 color: Colors.red.withOpacity(1),
                borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),

               ),
                child: Row(
                  children: [
                    Expanded(child: Icon(Icons.home)),
                    Expanded(child: Icon(Icons.search)),
                    Expanded(child: Icon(Icons.favorite_border)),
                    Expanded(child: Icon(Icons.shopping_cart)),
                  ],
                ),
              ),
              builder: (context, value, child) {
                return AnimatedPositioned(
                  duration: Duration(milliseconds: 200),
                  left: 0,
                  right: 0,
                  bottom: value ? 0.0 : -kToolbarHeight,
                  height: kToolbarHeight,
                  child: child,
                );
              }
              ),
 */