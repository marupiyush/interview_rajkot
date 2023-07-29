import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:interview_rajkot/models/item_model.dart';
import 'package:interview_rajkot/resources/colors.dart';
import 'package:interview_rajkot/widget/text.dart';

import 'package:provider/provider.dart';

import '../controller/item_list_controller.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final itemListController = Provider.of<ItemListController>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: const CommonText.bold("Cart", size: 36, color: AppColor.black),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: itemListController.cartList.isEmpty
            ? const Center(child: CommonText.semiBold("Cart is Empty"))
            : Column(
                children: [
                  Expanded(
                    child: cartList(itemListController.cartList),
                  ),
                  const Divider(height: 4, color: Colors.black),
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Center(
                        child: FittedBox(
                      child: CommonText.extraBold(
                        "\$ ${itemListController.cartTotalValue.toString()}",
                        size: 36,
                        color: AppColor.black,
                      ),
                    )),
                  )
                ],
              ),
      ),
    );
  }

  Widget cartList(List<ItemModel> cartList) {
    final itemListController = Provider.of<ItemListController>(context, listen: false);
    return ListView.separated(
      itemCount: cartList.length,
      itemBuilder: (context, index) {
        var data = cartList[index];
        return ListTile(
          leading: CachedNetworkImage(
            height: 100,
            width: 50,
            imageUrl: data.image.toString(),
            placeholder: (context, url) => const CupertinoActivityIndicator(),
          ),
          title: CommonText.semiBold(data.title.toString(), color: AppColor.black, size: 14),
          subtitle: CommonText.semiBold("\$ ${data.price.toString()}"),
          trailing: Container(
            width: 64,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.grey),
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      itemListController.quantityRemove(index: index, id: data.id);
                      itemListController.cartTotal(addToCartItem: true);
                    },
                    child: const Icon(
                      Icons.remove,
                      color: AppColor.white,
                      size: 21,
                    )),
                Container(
                  //margin: const EdgeInsets.symmetric(horizontal: 3),
                  padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: AppColor.white),
                  child: Text(
                    '${data.quantity}',
                    style: const TextStyle(color: AppColor.black, fontSize: 16),
                  ),
                ),
                InkWell(
                    onTap: () {
                      itemListController.quantityAdd(index: index,context: context);
                      itemListController.cartTotal(addToCartItem: true);
                    },
                    child: const Icon(
                      Icons.add,
                      color: AppColor.white,
                      size: 21,
                    )),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
