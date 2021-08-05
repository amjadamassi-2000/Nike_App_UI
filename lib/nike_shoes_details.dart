import 'package:flutter/material.dart';
import 'package:nike_app/nike_shoes.dart';
import 'package:nike_app/nike_shopping_cart.dart';
import 'package:nike_app/shake_transition.dart';

class NikeShoesDetails extends StatelessWidget {
  final NikeShoes shoes;
   final Function toggleFavorite ;
   final Function isMealFavorite ;

  final ValueNotifier<bool> notifierButtonsVisible = ValueNotifier(false);

  NikeShoesDetails({ this.shoes, this.toggleFavorite, this.isMealFavorite });

  //NikeShoesDetails.favorite(  this.toggleFavorite ,  this.isMealFavorite,{ this.shoes});

  void _openShoppingCart(BuildContext context)async{
    notifierButtonsVisible.value = false;
       await Navigator.of(context).push(PageRouteBuilder( opaque: false ,pageBuilder: (_ , animation1,__){
          return FadeTransition(
            opacity: animation1,
              child: NikeShoppingCart(shoes: shoes,),


          );
       }));
    notifierButtonsVisible.value = true;
  }

  @override
  Widget build(BuildContext context) {




    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifierButtonsVisible.value = true;
    });
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Image.asset(
            "images/nike_logo.png",
            height: 60,
          ),
          centerTitle: true,
          leading: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          )),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: size.height * 0.6,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Hero(
                          tag: "background_${shoes.model}",
                          child: Container(
                            color: Color(shoes.color),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: "number_${shoes.model}",
              child: ShakeTransition(
                axis: Axis.vertical,
                duration: const Duration(milliseconds: 3000),
                offset: 20,
                child: Material(
                  color: Colors.transparent,
                  child: FittedBox(
                    child: Text(
                      shoes.modelNumber.toString(),
                      style: TextStyle(
                          color: Colors.black12.withOpacity(0.02), fontSize: 180),
                    ),
                  ),
                ),
              ),
            ),
          ),

          PageView.builder(
              itemCount: shoes.images.length,
              itemBuilder: (context, index) {
                final tag = index == 0 ?  "image_${shoes.model}" : "image_${shoes.model}_$index";

                return Container(
                  alignment: Alignment.center,
                  child: ShakeTransition(
                    axis: Axis.horizontal,
                    duration: const Duration(milliseconds: 4000),


                    child: Hero(
                      tag:tag,

                      child: Image.asset(
                        (shoes.images[index]),
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                );
              }),
          Positioned(
            left: 15,
            bottom: 150,
            child: ShakeTransition(
              duration: const Duration(milliseconds: 2000),

              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        shoes.model,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 120,
                      ),
                      Text(
                        "\$${shoes.oldPrice.toString()}",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.red,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Text(
                          "Available Sizes",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 170,

                      ),
                      Text(

                        "\$${shoes.currentPrice.toString()}",

                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ShoesSizeItem(text: "6", ),
                      SizedBox(width:40,),
                      ShoesSizeItem(text: "7",),
                      SizedBox(width:40,),

                      ShoesSizeItem(text: "9",),
                      SizedBox(width: 40,),

                      ShoesSizeItem(text: "10",),

                    ],
                  )


                  


                ],
              ),
            ),
          ),

          

          ValueListenableBuilder<bool>(
              valueListenable: notifierButtonsVisible,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    FloatingActionButton(

                      heroTag: "fav_1",
                      backgroundColor: Colors.white,
                      onPressed: () {},
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.grey,
                      ),
                    ),
                    Spacer(),
                    FloatingActionButton(
                      heroTag: "fav_2",
                      backgroundColor: Colors.black,
                      onPressed: () {
                        _openShoppingCart(context);
                      },
                      child: Icon(Icons.shopping_cart),
                    ),
                  ],
                ),
              ),
              builder: (context, value, child) {
                return AnimatedPositioned(
                  duration: Duration(milliseconds: 200),
                  left: 0,
                  right: 0,
                  bottom: value ? 0.0 : -kToolbarHeight * 1.5,
                  child: child,
                );
              }),
        ],
      ),
    );
  }
}

class ShoesSizeItem extends StatelessWidget {

  final String text;
   Padding spas;

   ShoesSizeItem({ this.text , this.spas });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Text(
        "US $text",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }
}

