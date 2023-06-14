import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graduation/models/user_information_model.dart';
import '../helper/api_helper.dart';
import 'data_product_model.dart';
import 'package:http/http.dart' as http;

class ModelProvider with ChangeNotifier {
  List selectedProduct = [];
  List selectedProductOrders = [];

  //List productsList = [];
  dynamic productPrice = 0;

  add(DataProductModel product) {
    selectedProduct.add(product);

    productPrice += product.productPrice.round();

    notifyListeners();
  }

  remove(DataProductModel product) {
    selectedProduct.remove(product);

    productPrice -= product.productPrice.round();

    notifyListeners();
  }

  get itemModelLength {
    return selectedProduct.length;
  }

  addOrder(DataProductModel productOrder) {
    selectedProductOrders.add(productOrder);

    notifyListeners();
  }

// moveToOrderScreen it is temporary
  void moveToOrderScreen() {
    for (var product in selectedProduct) {
      addOrder(product);
    }
    notifyListeners();
  }

  removeItemOfList() {
    selectedProduct.clear();
    productPrice = 0;
    notifyListeners();
  }

  int _randomNumber = 0;

  int get ProductOrderId => _randomNumber;

  int generateRandomNumber() {
    final random = Random();
    _randomNumber = random.nextInt(12587800);
    return _randomNumber;
    notifyListeners();
  }

  //////////////////////////////////////////////////////////////////////////
  // method show data in information screen:

  UserInformationModel? _userInformationModel;

  Future<void> fetchUser() async {
    final response =
        await http.get(Uri.parse('http://185.132.55.54:8000/register/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _userInformationModel = UserInformationModel.fromJson(data);
      notifyListeners();
    } else {
      throw Exception('Failed to load user');
    }
  }

  UserInformationModel? get user => _userInformationModel;

/////////////////////////////////////////////////////////////////////////
// method register:

/////////////////////////////////////////////////////////////////////////
//method register:

///////////////////////////////////////////////////////////////////////////
}

/*
  Future<List<DataProductModel>> getAllProducts() async {
    List<dynamic> data =
        await ApiHelper().get(url: 'https://fakestoreapi.com/products');
    List<DataProductModel> productsList = [];
    for (var i = 0; i < data.length; i++) {
      productsList.add(DataProductModel.fromJson(data[i]));
    }
    return productsList;
  }
  */

/*

import 'package:flutter/foundation.dart';
import '../helper/api_helper.dart';
import 'data_product_model.dart';

class ModelProvider with ChangeNotifier {
  List selectedProduct = [];
  List selectedProductOrders = [];
  int productPrice = 0;

  add(DataProductModel product) {
    selectedProduct.add(product);

    //productPrice += product.productPrice.round();

    notifyListeners();
  }

  remove(DataProductModel product) {
    selectedProduct.remove(product);

    //productPrice -= product.productPrice.round();

    notifyListeners();
  }

  get itemModelLength {
    return selectedProduct.length;
  }

  addOrder(DataProductModel productOrder) {
    selectedProductOrders.add(productOrder);

    notifyListeners();
  }
// moveToOrderScreen it is temporary
  void moveToOrderScreen() {
    for (var product in selectedProduct) {
      addOrder(product);
    }
    notifyListeners();
  }

  removeItemOfList() {
    selectedProduct.clear();
    productPrice = 0;
    notifyListeners();
  }

  Future<List<DataProductModel>> getAllProducts() async {
    List<dynamic> data = await ApiHelper()
        .get(url: 'https://fakestoreapi.com/products');
    List<DataProductModel> productsList = [];
    for (var i = 0; i < data.length; i++) {
      productsList.add(DataProductModel.fromJson(data[i]));
    }
    return productsList;
  }
}

*/
