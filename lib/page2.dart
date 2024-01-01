import 'package:flutter/material.dart';
import 'Kits.dart';
import 'order.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  bool _load = false;

  void update(bool success) {
    setState(() {
      _load = true; // show product list
      if (!success) { // API request failed
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('failed to load data')));
      }
    });
  }

  @override
  void initState() {
    // update data when the widget is added to the tree the first tome.
    updateProducts(update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.amberAccent,
        appBar: AppBar(actions: [
          IconButton(onPressed: !_load ? null : () {
            setState(() {
              _load = false; // show progress bar
              updateProducts(update); // update data asynchronously
            });
          }, icon: const Icon(Icons.refresh)),
          IconButton(onPressed: () {
            setState(() { // open the search product page
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Order())
              );
            });
          }, icon: const Icon(Icons.search))
        ],backgroundColor: Colors.black,
          title: const Text('Available Kits',style: TextStyle(fontSize: 25.0,color :Colors.amber)),
          centerTitle: true,
        ),
        // load products or progress bar
        body: _load ? const ShowProducts() : const Center(
          child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator())
          , )
    );
  }
}