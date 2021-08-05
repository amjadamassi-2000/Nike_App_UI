import 'package:flutter/material.dart';

class NikeShoes {
  final String id;
  final String model;
  final double oldPrice;
  final double currentPrice;
  final List<String> images;
  final int modelNumber;
  final int color ;
  final bool isFavorite;

  NikeShoes(
      {this.id,
        this.model,
      this.oldPrice,
      this.currentPrice,
      this.images,
      this.modelNumber,
        this.color,
        this.isFavorite,
      });
}

List shoes = <NikeShoes>[
  NikeShoes(
    id: "1",
    model: "AIR MAX 90 EZ BLACK",
    currentPrice: 194,
    oldPrice: 299,
    images: [
      "images/shoes1_1.png",
      "images/shoes1_2.png",
      "images/shoes1_3.png",
    ],
    modelNumber: 90,
    color: 0xFFF6F6F6,
  ),

  NikeShoes(
    id: "2",
    model: "AIR MAX 90 EZ GOLD",
    currentPrice: 299,
    oldPrice: 399,
    images: [
      "images/shoes2_1.png",
      "images/shoes2_2.png",
      "images/shoes2_3.png",
    ],
    modelNumber: 95,
    color: 0xFFFCF5EB,

  ),
  NikeShoes(
    id: "3",
    model: "AIR MAX 90 EZ RED",
    currentPrice: 199,
    oldPrice: 349,
    images: [
      "images/shoes3_1.png",
      "images/shoes3_2.png",
      "images/shoes3_3.png",
    ],
    modelNumber: 270,
    color: 0xFFFEEFEF,

  ),

  NikeShoes(
    id: "4",
    model: "AIR MAX 90 EZ FREE",
    currentPrice: 194,
    oldPrice: 299,
    images: [
      "images/shoes4_1.png",
      "images/shoes4_2.png",
      "images/shoes4_3.png",
    ],
    modelNumber: 98,
    color: 0xFFEDF3FE,

  ),
];
