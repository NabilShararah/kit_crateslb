//Nabil Shararah 12232685


import 'package:flutter/material.dart';
import 'Kits.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  // controller to store product pid
  final TextEditingController _controllerID = TextEditingController();
  String _text = ''; // displays product info or error message

  @override
  void dispose() {
    _controllerID.dispose();
    super.dispose();
  }

  // update product info or display error message
  void update(String text) {
    setState(() {
      _text = '$text\n\nThank you for your order';
    });
  }

  // called when user clicks on the find button
  void getProduct() {
    try {
      int pid = int.parse(_controllerID.text);
      searchProduct(update, pid); // search asynchronously for product record
    }
    catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('wrong arguments')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.amberAccent,
      appBar: AppBar( backgroundColor: Colors.black,
        title: const Text(' Order Now', style: TextStyle(fontSize: 25.0,color :Colors.amber)),
        centerTitle: true,
      ),
      body: Center(child: Column(children: [
        const SizedBox(height: 10),
        SizedBox(width: 200, child: TextField(controller: _controllerID, keyboardType: TextInputType.number,
            decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Enter ID'))),
        const SizedBox(height: 10),
        ElevatedButton(onPressed: getProduct,
            child: const Text('Order', style: TextStyle(fontSize: 18))),
        const SizedBox(height: 10),
        Center(child: SizedBox(width: 200, child: Flexible(child: Text(_text,
            style: const TextStyle(fontSize: 18))))),
      ],

      ),

      ),
    );
  }
}
