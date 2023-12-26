import 'package:flutter/material.dart';

class Kit {
  String model;
  int price;
  int Style = 1; // warranty years, default 1 year
  bool KitType = false; // determines if car is insured, default is false
  // constructor only takes model and price. warranty and insurance are set later
  Kit(this.model, this.price);
  // toString method used to display an item in a dropdown widget
  @override
  String toString() {
    return '$model Price: \$$price';
  }
  String getTotalPrice() {
    /*
    calculate price as follows: if warranty is 1 then 5% else 10%
    if insurance is added, then add 1000 to total price
     */
    int KitTypeamount = KitType ? 5 : 0;
    if (Style == 1) {
      return (price + KitTypeamount).toStringAsFixed(0);
    }
    return (price * 1.1 + KitTypeamount).toStringAsFixed(0);
  }

}
List<Kit> kits = [
  Kit('Trio Kit', 65),
  Kit('Single Kit',25)
];
class MyDropdownMenuWidget extends StatefulWidget {
  const MyDropdownMenuWidget({required this.updateKit, super.key});
// below is a callback function to return the selected car to the home page
// we will call it from the widget’s state class
  final Function(Kit) updateKit;

  @override
  State<MyDropdownMenuWidget> createState() => _MyDropdownMenuWidgetState();
}
class _MyDropdownMenuWidgetState extends State<MyDropdownMenuWidget> {


  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
        textStyle: TextStyle(
          color: Colors.amber, // Set the color to amber
        ),
        width: 210.0,
        initialSelection: kits[0], // first car to be displayed
        onSelected: (kit) {
          setState(() {
            widget.updateKit(kit as Kit); // use widget to access widget fields from state class
          });
        }, // the list map function converts the list of cars to a list of DropdownMenuEntries
        dropdownMenuEntries: kits.map<DropdownMenuEntry<Kit>>((Kit kit) {
          return DropdownMenuEntry(value: kit, label: kit.toString());
        }).toList());
  }
}
class StyleWidget extends StatefulWidget {
  const StyleWidget({required this.updateStyle, super.key});
  final Function(int) updateStyle;
  @override
  State<StyleWidget> createState() => _StyleWidgetState();
}

class _StyleWidgetState extends State<StyleWidget> {
  int _Style = 1;
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('Type', style: TextStyle(fontSize: 18.0,color :Colors.amber),),
      Radio( value: 1, groupValue: _Style, // all radio buttons in the same group should share a common variable
        onChanged: (val) {
          setState(() {
            _Style = val as int;
            widget.updateStyle(_Style); // use widget to access widget fields from state class
          });
        }, activeColor: Colors.amber,
        focusColor: Colors.amber,
      ), const Text('Short Sleeves', style: TextStyle(fontSize: 18.0,color :Colors.amber)),
      Radio( value: 5, groupValue: _Style, // all radio buttons in the same group should share a common variable
        onChanged: (val) {
          setState(() {
            _Style = val as int;
            widget.updateStyle(_Style); // use widget to access widget fields from state class
          });
        },activeColor: Colors.amber,
        focusColor: Colors.amber,
      ), const Text('Long Sleeves', style: TextStyle(fontSize: 18.0,color :Colors.amber),)
    ]);


  }
}




