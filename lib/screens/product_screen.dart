import 'package:fake_products/controllers/cart_controller.dart';
import 'package:fake_products/models/products_model.dart';
import 'package:fake_products/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends StatefulWidget {
  final ProductsModel product;
  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  CartController cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => CartScreen());
              },
              icon: Icon(Icons.shopping_bag))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(160),
                        border: Border.all(color: Colors.green.shade600)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(160),
                      child: Image.network(
                        widget.product.image,
                        height: 150,
                        width: 150,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.title,
                    maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                  ),
                  Text(
                    widget.product.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text("Category: " + widget.product.category),
              SizedBox(width: 10),
              Text(
                "Rating " + widget.product.rating["rate"].toString() + " ⭐",
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              Row(
                children: [
                  Text(
                    "Only at -/₹" + widget.product.price.toString(),
                    style:
                        TextStyle(fontSize: 15, color: Colors.green.shade600),
                  ),
                ],
              ),
              Obx(() => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          cartController.cartItems.contains(widget.product.id)
                              ? Colors.green.shade600
                              : null),
                  onPressed: () {
                    cartController.cartItems.contains(widget.product.id)
                        ? cartController.removeItems(
                            widget.product.id, widget.product)
                        : cartController.addItems(
                            widget.product.id, widget.product);
                  },
                  child: Text(
                    cartController.cartItems.contains(widget.product.id)
                        ? "REMOVE"
                        : "ADD TO CART",
                    style: TextStyle(
                        color:
                            cartController.cartItems.contains(widget.product.id)
                                ? Colors.white
                                : null),
                  )))
            ],
          ),
        ),
      ),
    );
  }
}
