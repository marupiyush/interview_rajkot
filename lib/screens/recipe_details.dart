import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interview_rajkot/controller/item_list_controller.dart';
import 'package:interview_rajkot/resources/colors.dart';
import 'package:interview_rajkot/widget/text.dart';

import 'package:provider/provider.dart';

class RecipeDetails extends StatefulWidget {
  final int index;
  const RecipeDetails({Key? key, required this.index}) : super(key: key);

  @override
  _RecipeDetailsState createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  @override
  Widget build(BuildContext context) {
    final itemListController = Provider.of<ItemListController>(context, listen: false);
    final data=itemListController.itemModelList[widget.index];
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: const CommonText.bold("Item Detail", size: 36, color: AppColor.black),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              height: 250,
              width: double.infinity,
              imageUrl: data.image.toString(),
              placeholder: (context, url) => const CupertinoActivityIndicator(),
            ),
            const SizedBox(height: 30),
            Center(child: CommonText.extraBold("\$ ${data.price}", color: AppColor.black, size: 28)),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText.semiBold(data.title.toString(), color: AppColor.black, size: 18),
                  const SizedBox(height: 30),
                  const CommonText.semiBold("Category  :", size: 18,color: AppColor.black),
                  const SizedBox(height: 10),
                  CommonText.semiBold(data.category.toString(), size: 18),
                  const SizedBox(height: 30),
                  const CommonText.semiBold("Description  :", size: 18,color: AppColor.black),
                  const SizedBox(height: 10),
                  CommonText.semiBold(data.description.toString(), size: 18),
                  const SizedBox(height: 30),
                  const CommonText.semiBold("Rating  :", size: 18,color: AppColor.black),
                  const SizedBox(height: 10),
                  CommonText.semiBold(data.rating!.rate.toString(), size: 18),
                  const SizedBox(height: 50),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
