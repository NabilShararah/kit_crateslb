import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'page3.dart';
import 'dart:convert' as convert;

import 'page2.dart';

// domain of your server
const String _baseURL = 'https://nabiltestunimobile.000webhostapp.com';
// used to retrieve the key later
EncryptedSharedPreferences _encryptedData = EncryptedSharedPreferences();

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pidController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _cidController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _pidController.dispose();
    _nameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void update(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Add New Products ',
          style: TextStyle(
              fontSize:28,
              color :Colors.amberAccent),),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[Text(
                'Categories Available are (1 for Club)/(2 for Nation)/(3 for Retro)/(4,for Special)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
                SizedBox(height: 16),TextFormField(
                  controller: _pidController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Product ID',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Product ID';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Product Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Quantity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Price';
                    }
                    return null;
                  },
                ), const SizedBox(height: 16.0),
                TextFormField(
                  controller: _cidController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Category ID',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Category ID';
                    }
                    return null;
                  },
                ),const SizedBox(height: 16.0),
                // Text form fields for PID, Name, Quantity, and Price
                // Similar to the AddCategory widget
                // ... Your TextFormField code goes here ...
                ElevatedButton(
                  onPressed: _loading
                      ? null
                      : () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _loading = true;
                      });

                      try {
                        // Retrieve the key here
                        String myKey = await _encryptedData.getString('myKey');

                        // Get values from text controllers
                        int pid = int.parse(_pidController.text);
                        String name = _nameController.text;
                        int quantity = int.parse(_quantityController.text);
                        double price = double.parse(_priceController.text);
                        int cid = int.parse(_cidController.text);

                        // Call saveProduct function
                        saveProduct(update, pid, name, quantity, price,cid);
                      } catch (e) {
                        update('Connection error');
                      }
                    }
                  }, style: ElevatedButton.styleFrom(
                  primary: Colors.black,),
                  child: const Text('Save Product',style: TextStyle(color: Colors.white)),
                ),const SizedBox(height:10),
                ElevatedButton(onPressed:(){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder:(context)=>const Page3())
                  );
                }, style: ElevatedButton.styleFrom(
                  primary: Colors.black,),
                    child: const Text('Updated Products',style: TextStyle(color: Colors.white))//Icon(Icons.navigate_next,size:50)
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: _loading,
                  child: const CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void saveProduct(
    Function(String text) update,
    int pid,
    String name,
    int quantity,
    double price,
    int cid, // Include cid here
    ) async {
  try {
    String myKey = await _encryptedData.getString('myKey');
    final response = await http.post(
      Uri.parse('$_baseURL/saveproducts.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(<String, dynamic>{
        'pid': pid.toString(),
        'name': name,
        'quantity': quantity.toString(),
        'price': price.toString(),
        'key': myKey,
        'cid': cid.toString(), // Include cid in the request
      }),
    ).timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      update(response.body);
    }
  } catch (e) {
    update("connection error");
  }
}

