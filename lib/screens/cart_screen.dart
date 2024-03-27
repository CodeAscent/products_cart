import 'package:fake_products/controllers/cart_controller.dart';
import 'package:fake_products/models/products_model.dart';
import 'package:fake_products/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CartController(),
        builder: (controller) {
          controller.updateTotal();
          return Scaffold(
            appBar: AppBar(
              title: Text("Cart"),
            ),
            body: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.cart.length,
              itemBuilder: (BuildContext context, int index) {
                ProductsModel product = controller.cart[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => ProductScreen(product: product));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.green.shade600)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(160),
                                    border: Border.all(
                                        color: Colors.green.shade600)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(160),
                                  child: Image.network(
                                    product.image,
                                    height: 90,
                                    width: 90,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            SizedBox(
                              width: 240,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    maxLines: 1,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    product.description,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text("Category: " + product.category),
                        SizedBox(width: 10),
                        Text(
                          "Rating " + product.rating["rate"].toString() + " ⭐",
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Row(
                          children: [
                            Text(
                              "Only at -/₹" + product.price.toString(),
                              style: TextStyle(
                                  fontSize: 15, color: Colors.green.shade600),
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    product.quantity == 1
                                        ? IconButton(
                                            onPressed: () {
                                              controller.removeItems(
                                                  product.id, product);
                                            },
                                            icon: Icon(Icons.delete))
                                        : IconButton(
                                            onPressed: () {
                                              product.quantity--;
                                              controller.updateTotal();
                                            },
                                            icon: Icon(Icons.remove)),
                                    Text(product.quantity.toString()),
                                    IconButton(
                                        onPressed: () {
                                          product.quantity++;
                                          controller.updateTotal();
                                        },
                                        icon: Icon(Icons.add))
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            bottomNavigationBar: SafeArea(
              child: Container(
                color: Colors.green.shade600,
                height: 60,
                padding: EdgeInsets.all(15),
                child: Center(
                    child: Row(
                  children: [
                    Text(
                      "Total: ",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                    Spacer(),
                    Text(
                      controller.total.value.toString(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800),
                    )
                  ],
                )),
              ),
            ),
          );
        });
  }
}
