import 'package:flutter/material.dart';

class Kit {
  String model;
  int price;
  int Style = 1;
  bool KitType = false;

  Kit(this.model, this.price);

  @override
  String toString() {
    return '$model Price: \$$price';
  }
  String getTotalPrice() {

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
        initialSelection: kits[0],
        onSelected: (kit) {
          setState(() {
            widget.updateKit(kit as Kit);
          });
        },
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
      Radio( value: 1, groupValue: _Style,
        onChanged: (val) {
          setState(() {
            _Style = val as int;
            widget.updateStyle(_Style);
          });
        }, activeColor: Colors.amber,
        focusColor: Colors.amber,
      ), const Text('Short Sleeves', style: TextStyle(fontSize: 18.0,color :Colors.amber)),
      Radio( value: 5, groupValue: _Style,
        onChanged: (val) {
          setState(() {
            _Style = val as int;
            widget.updateStyle(_Style);
          });
        },activeColor: Colors.amber,
        focusColor: Colors.amber,
      ), const Text('Long Sleeves', style: TextStyle(fontSize: 18.0,color :Colors.amber),)
    ]);


  }
}




