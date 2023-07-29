import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interview_rajkot/models/item_model.dart';
import 'package:interview_rajkot/resources/colors.dart';

import '../widget/text.dart';

class ItemListController extends ChangeNotifier {
  List<ItemModel> itemModelList = [];
  List<ItemModel> cartList = [];
  double cartTotalValue = 0.0;


  Future<void> getItems() async {
    var response = await http.get(Uri.parse("https://fakestoreapi.com/products"), headers: {'q': '{http}'});
    if (response.statusCode == 200) {
      List responseList = jsonDecode(response.body);
      for (var v in responseList) {
        itemModelList.add(ItemModel.fromJson(v));
      }
      notifyListeners();
    } else {
      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
  }

  void addToCart({int? index}) {
    cartList.add(itemModelList[index!]);
    notifyListeners();
  }

  void removeFromCart({int? id,int? index}) {

    cartList.remove(cartList.where((element) => element.id == id).toList()[0]);
    itemModelList[index!].quantity=1;
    itemModelList[index].quantityWithPrice=itemModelList[index].price;
    cartTotal(addToCartItem: true);
    notifyListeners();
  }

  bool checkInCart({int? index}) {
    return cartList.contains(itemModelList[index!]);
  }

  void cartTotal({bool? addToCartItem, int? id}) {
      cartTotalValue = 0.0;
      for (var element in cartList) {
        cartTotalValue = cartTotalValue + element.quantityWithPrice;
      }
    notifyListeners();
  }

  void quantityAdd({int? index,required BuildContext context}){
    if (cartList[index!].quantity!<9) {
      cartList[index].quantity=cartList[index].quantity! +1;
      cartList[index].quantityWithPrice=cartList[index].price * cartList[index].quantity;
      notifyListeners();
    }
    else{
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
           const SnackBar(backgroundColor: AppColor.greyLight,
              content: CommonText.semiBold("Maximum 9 quantity add.",color: AppColor.black,)
          ),
        );
    }
  }
  void quantityRemove({int? index,int? id}){
    if (cartList[index!].quantity!>1) {
      cartList[index].quantity=cartList[index].quantity! -1;
      cartList[index].quantityWithPrice=cartList[index].price * cartList[index].quantity;
      notifyListeners();
    }
    else{
      removeFromCart(index: index,id: id);
    }
  }
}
