import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shopx_api/controllers/product_controller.dart';
import 'package:shopx_api/views/product_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3efe0),
      appBar: AppBar(
        backgroundColor: Color(0xffefe3ba),
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'ShopX',
                    style: TextStyle(
                        fontFamily: 'avenir',
                        fontSize: 32,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.view_list_rounded), onPressed: () {}),
                IconButton(icon: const Icon(Icons.grid_view), onPressed: () {}),
              ],
            ),
          ),

          Expanded(
            child: Obx(() {
              if (productController.isLoading.value) {
                return const Center(child: CircularProgressIndicator(color: Colors.black,));
              } else {
                return MasonryGridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  itemCount: productController.productList.length,
                  itemBuilder: (context, index) {
                    return ProductTile(productController.productList[index]);
                  },
                );
              }
            }),
          )
        ],
      ),
    );
  }
}
