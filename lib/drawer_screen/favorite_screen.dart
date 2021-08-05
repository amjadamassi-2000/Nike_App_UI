import 'package:flutter/material.dart';

import '../nike_shoes.dart';


class FavoritesScreen extends StatefulWidget {

  final List<NikeShoes> favoriteMeals;
  FavoritesScreen(this.favoriteMeals);


  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorites"),),
    );
  }
}
