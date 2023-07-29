import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interview_rajkot/controller/item_list_controller.dart';
import 'package:interview_rajkot/models/item_model.dart';
import 'package:interview_rajkot/resources/colors.dart';
import 'package:interview_rajkot/screens/cart.dart';
import 'package:interview_rajkot/screens/recipe_details.dart';
import 'package:interview_rajkot/screens/login.dart';
import 'package:interview_rajkot/widget/text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({Key? key}) : super(key: key);

  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  void initState() {
    final itemListController = Provider.of<ItemListController>(context, listen: false);
    itemListController.getItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final itemListController = Provider.of<ItemListController>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        automaticallyImplyLeading: false,
        title: const CommonText.bold("Items List", size: 36, color: AppColor.black),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Cart()));
              },
              icon: const Icon(Icons.shopping_cart, color: AppColor.black)),
          IconButton(onPressed: () async {
            SharedPreferences preferences = await SharedPreferences.getInstance();
            await preferences.clear();
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Login()), (Route<dynamic> route) => false);

          }, icon: const Icon(Icons.logout,color: AppColor.black,))
        ],
      ),
      body: itemListController.itemModelList.isNotEmpty ? GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: itemListController.itemModelList.length,
        itemBuilder: (context, index) {
          return buildRecipeCard(itemListController.itemModelList,index);
        },
      )
    : const Center(child: CupertinoActivityIndicator()),
    );
  }
  Widget buildRecipeCard(List<ItemModel> itemModelList,int index) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetails(index: index)));
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: CommonText.semiBold(itemModelList[index].title.toString(), color: AppColor.black, size: 14),
        ),
      ),
    );
  }
}
