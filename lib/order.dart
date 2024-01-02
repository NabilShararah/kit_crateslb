//Nabil Shararah 12232685


import 'package:flutter/material.dart';
import 'Kits.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}




class _OrderState extends State<Order> {
  final TextEditingController _controllerID = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  String _text = ''; // Displays the product info and address
  String _address = ''; // Stores the entered address

  @override
  void dispose() {
    _controllerID.dispose();
    _controllerAddress.dispose();
    super.dispose();
  }

  void update(String text) {
    setState(() {
      _text = '$text\n\nThank you for your order.\nAddress: $_address';
    });
  }

  void getProduct() {
    try {
      int pid = int.parse(_controllerID.text);
      searchProduct(update, pid); // Search asynchronously for product record
      _address = _controllerAddress.text; // Store the entered address
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Wrong arguments')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(' Order Now', style: TextStyle(fontSize: 25.0, color: Colors.amber)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              width: 500,
              child: TextField(
                controller: _controllerID,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Enter ID'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 500,
              child: TextField(
                controller: _controllerAddress,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Enter your address and phone number'),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: getProduct,
              child: const Text('Order', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: 200,
                child: Flexible(
                  child: Text(
                    _text,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



