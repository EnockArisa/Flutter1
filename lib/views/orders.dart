import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter1/configs/colors.dart';
import 'dart:convert';
import '../controllers/logincontroller.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final LoginController loginController = Get.find();

  List orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  /// FETCH USER ORDERS
  fetchOrders() async {
    try {
      var response = await http.get(
        Uri.parse(
          "http://localhost/get_orders.php?user_id=${loginController.userId.value}",
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          orders = json.decode(response.body);
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  /// DELETE ORDER
  Future deleteOrder(String orderId, int index) async {
    var response = await http.post(
      Uri.parse("http://localhost/delete_order.php"),
      body: {"order_id": orderId},
    );

    if (response.body == "success") {
      setState(() {
        orders.removeAt(index); //  remove instantly
      });

      Get.snackbar("Removed", "Order deleted successfully");
    } else {
      Get.snackbar("Error", "Failed to delete order");
    }
  }

  /// CONFIRM DELETE
  void confirmDelete(String orderId, int index) {
    Get.defaultDialog(
      title: "Remove Order",
      middleText: "Are you sure you want to remove this order?",
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: lightColor,
      buttonColor: primaryColor,
      onConfirm: () {
        Get.back();
        deleteOrder(orderId, index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,

      appBar: AppBar(
        title: const Text("My Orders"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : orders.isEmpty
          ? const Center(child: Text("No orders yet"))
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                var item = orders[index];

                return TweenAnimationBuilder(
                  duration: Duration(milliseconds: 400 + (index * 100)),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 50 * (1 - value)),
                        child: child,
                      ),
                    );
                  },

                  ///  CARD STYLE
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 6,
                    margin: const EdgeInsets.symmetric(vertical: 10),

                    child: Container(
                      padding: const EdgeInsets.all(12),

                      child: Row(
                        children: [
                          /// IMAGE
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              "http://localhost/charger/charger_images/${item['image']}",
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.image, size: 80);
                              },
                            ),
                          ),

                          const SizedBox(width: 15),

                          /// DETAILS
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['brand'] ?? "Unknown Jersey",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  "Quantity: ${item['quantity']}",
                                  style: const TextStyle(color: greyColor),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  "Ksh ${item['total_price']}",
                                  style: const TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          ///  ACTIONS COLUMN
                          Column(
                            children: [
                              /// STATUS
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  "Paid",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10),

                              /// DELETE BUTTON
                              GestureDetector(
                                onTap: () =>
                                    confirmDelete(item['id'].toString(), index),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      255,
                                      59,
                                      222,
                                      116,
                                    ).withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Color.fromARGB(255, 80, 236, 127),
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
