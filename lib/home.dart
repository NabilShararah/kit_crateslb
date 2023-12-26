import 'package:flutter/material.dart';
import 'kit.dart';
import 'page2.dart';
import 'login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  String totalPrice = kits.first.getTotalPrice(); // holds total car price
  Kit kit = kits.first; // set the first car to be displayed
  bool KitStyle = false; // holds insurance value and the default, is no insurance

  void updateKit(Kit kit) {
    // updates car price when the user selects a car form the dropdown
    setState(() {
      this.kit = kit;
      totalPrice = kit.getTotalPrice();
    });
  }

  void updateStyle(int Style) {
    // updates warranty years when the user clicks on a radio buttons
    setState(() {
      kit.Style = Style;
      totalPrice = kit.getTotalPrice();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.black54,
        body: Center(
            child: Column(children: [
              const SizedBox(height: 20.0),
              const Text('Select Mystery Box', style: TextStyle(fontSize: 25.0,color :Colors.amber)), const SizedBox(height: 10.0),
              MyDropdownMenuWidget(updateKit: updateKit), const SizedBox(height: 10.0),
              StyleWidget(updateStyle: updateStyle), const SizedBox(height: 10.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Retro', style: TextStyle(fontSize: 18.0,color :Colors.amber)),
                    Checkbox(value: KitStyle, onChanged: (bool? value) {
                      setState(() { // updates the total price when the checkbox state chanes
                        KitStyle = value as bool;
                        kit.KitType = KitStyle;
                        totalPrice = kit.getTotalPrice();
                      });
                    },
                      activeColor: Colors.amber,
                    )]),
              const SizedBox(height: 10.0),
              Text('Total Price: $totalPrice', style: const TextStyle(color :Colors.amber,fontSize: 25.0, fontWeight: FontWeight.bold),),
              const SizedBox(height:10),
              ElevatedButton(onPressed:(){
                Navigator.of(context).push(
                    MaterialPageRoute(builder:(context)=>const Page2())
                );
              }, style: ElevatedButton.styleFrom(
                primary: Colors.black,),
                  child: const Text('Available Kits',style: TextStyle(color: Colors.white))//Icon(Icons.navigate_next,size:50)
              ),
              const SizedBox(height:10),
              ElevatedButton(onPressed:(){
                Navigator.of(context).push(
                    MaterialPageRoute(builder:(context)=>const Login())
                );
              }, style: ElevatedButton.styleFrom(
                primary: Colors.black,),
                  child: const Text(' Main Login',style: TextStyle(color: Colors.white))//Icon(Icons.navigate_next,size:50)
              )])));
  }
}

