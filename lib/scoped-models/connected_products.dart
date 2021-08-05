






import 'package:scoped_model/scoped_model.dart';

import '../nike_shoes.dart';

mixin ConnectedProductsModel on Model {
  List<NikeShoes> _products = [];
  int _selProductIndex;
  // User _authenticatedUser;

  void addProduct(
      String id, String model, double oldPrice,double currentPrice , List<String> images, int color , int modelNumber) {
    final NikeShoes newProduct = NikeShoes(

      id: id,
      model: model,
      oldPrice: oldPrice,
      currentPrice: currentPrice,
      images: images,
      color: color,
      modelNumber: modelNumber,

  );
    _products.add(newProduct);
    notifyListeners();
  }
}

mixin ProductsModel on ConnectedProductsModel {
  bool _showFavorites = false;



  List<NikeShoes> get allProducts {
    return List.from(_products);
  }

  List<NikeShoes> get displayedProducts {
    if (_showFavorites) {
      return _products.where((NikeShoes product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  int get selectedProductIndex {
    return _selProductIndex;
  }

  NikeShoes get selectedProduct {
    if (selectedProductIndex == null) {
      return null;
    }
    return _products[selectedProductIndex];
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }


  void toggleProductFavoriteStatus() {
    final bool isCurrentlyFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final NikeShoes updatedProduct = NikeShoes(
        id: selectedProduct.id,
        model: selectedProduct.model,
        oldPrice: selectedProduct.oldPrice,
        currentPrice: selectedProduct.currentPrice,
        images: selectedProduct.images,
        color: selectedProduct.color,
        modelNumber: selectedProduct.modelNumber,
        isFavorite: newFavoriteStatus);
    _products[selectedProductIndex] = updatedProduct;
    notifyListeners();
  }


  void selectProduct(int index) {
    _selProductIndex = index;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }




}