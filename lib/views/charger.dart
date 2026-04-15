import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter1/configs/colors.dart';
import 'package:flutter1/views/fullimageview.dart';
import '../controllers/logincontroller.dart';

LoginController loginController = Get.find();

class Charger extends StatefulWidget {
  const Charger({super.key});

  @override
  State<Charger> createState() => _ChargerState();
}

class _ChargerState extends State<Charger> {
  List chargers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchChargers();
  }

  /// FETCH CHARGERS
  fetchChargers() async {
    try {
      var response = await http.get(
        Uri.parse("http://127.0.0.1/charger/get_chargers.php"),
      );

      if (response.statusCode == 200) {
        setState(() {
          chargers = json.decode(response.body);
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  /// PLACE ORDER
  Future placeOrder(item) async {
    var response = await http.post(
      Uri.parse("http://127.0.0.1/order.php"),
      body: {
        "user_id": loginController.userId.value.toString(),
        "charger_id": item['id'].toString(),
        "quantity": "1",
        "total_price": item['price'].toString(),
      },
    );

    if (response.body == "success") {
      Get.snackbar("Success", "Order placed successfully");
    } else {
      Get.snackbar("Error", "Order failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chargers"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: chargers.length,
              itemBuilder: (context, index) {
                var item = chargers[index];

                ///  ANIMATED ENTRY
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

                  /// CARD UI
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
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                () => FullImageView(
                                  imageUrl:
                                      "http://127.0.0.1/charger/charger_images/${item['image']}",
                                ),
                              );
                            },
                            child: Hero(
                              tag: item['image'],
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  "http://127.0.0.1/charger/charger_images/${item['image']}",
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.image, size: 80);
                                  },
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 15),

                          /// DETAILS
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['brand'] ?? "No name",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  "Ksh ${item['price']}",
                                  style: const TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// BUY BUTTON
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: lightColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text("Buy"),
                            onPressed: () {
                              placeOrder(item);
                            },
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
