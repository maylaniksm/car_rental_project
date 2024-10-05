import 'package:car_rental/app/modules/detail_payment/widget/widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:expansion_widget/expansion_widget.dart';
 import 'dart:math' as math;

class DetailPaymentScreen extends StatefulWidget {
  const DetailPaymentScreen({super.key});

  @override
  State<DetailPaymentScreen> createState() => _DetailPaymentScreenState();
}

class _DetailPaymentScreenState extends State<DetailPaymentScreen> {
  String _selectedPackage = 'Premium';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40,left: 20,right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.grey.shade400)
                        ),
                        child: Icon(Icons.arrow_back,color: Colors.black,),
                      ),
                    ),
                    Expanded(
                      child: Center(child: Text("Coverage Plan",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Flexible(child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text("Choose a package fot the best value protection",style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),),
                    SizedBox(height: 10,),
                    tileWidget(price: "Free", title: "Basic"),
                    SizedBox(height: 10,),
                    tileWidget(title: "Medium", price: '85\$'),
                    SizedBox(height: 10,),
                    tileWidget(title: "Premium", price: "98\$"),
                    SizedBox(height: 10,),
                    Text("Extras",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    ExtrasWidget(title: 'Child seat',price: '85\$',),
                    SizedBox(height: 6,),
                    ExtrasWidget(title: 'Additional driver',price: '20\$',),
                    SizedBox(height: 6,),
                    ExtrasWidget(title: 'Satellite system',price: '52\$',),
                    SizedBox(height: 150,),
                  ],
                ))
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("Total", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                          SizedBox(width: 5),
                          Text("(3 days)", style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
                        ],
                      ),
                      Text("\$183", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Color(0xFF353392)),)
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Proceed to Payment",style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Color(0xFF353392),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ExpansionWidget tileWidget({required String title,required String price}) {
    return ExpansionWidget(
    initiallyExpanded: true,
    titleBuilder: (double animationValue, _, bool isExpaned, toogleFunction) {
      return InkWell(
          onTap: () => toogleFunction(animated: true),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(255, 221, 221, 221)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Color(0xFF2CB67D),
                        value: _selectedPackage == 'Premium',
                        onChanged: (bool? value) {
                          setState(() {
                            _selectedPackage = value! ? 'Premium' : '';
                          });
                        },
                      ),
                      Text(title),
                    ],
                  ),
                  Spacer(),
                  Text(price),
                  SizedBox(width: 5,),
                  Transform.rotate(
                    angle: math.pi * animationValue / 2,
                    child: Icon(Icons.arrow_forward_ios_rounded, size: 20),
                    alignment: Alignment.center,
                  )
                ],
              ),
            ),
          ));
    },
    content: Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          ContentTile(title: "Personal Accident Coverage",),
          ContentTile(title: "Theft waiver",),
          ContentTile(title: "Value Cover, Glass, lights and tyre protection",),
          ContentTile(title: "Collision damage waiver",),
        ],
      ),
    ));
  }
}

class ExtrasWidget extends StatelessWidget {
  const ExtrasWidget({
    super.key,
    required this.title,
    required this.price,
  });
  final String title;
  final String price;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.grey.shade400)
      ),
      child: Row(
        children: [
          Checkbox(
            value: true,
            activeColor: Color(0xFF2CB67D),
            onChanged: (bool? value) {
              
            },
          ),
          Text(title),
          Spacer(),
          Text(price,style: TextStyle(fontWeight: FontWeight.bold),),
          Spacer(),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                color: Colors.blue,
                onPressed: null,
              ),
              Text('20', style: TextStyle(fontSize: 16)),
              IconButton(
                icon: Icon(Icons.add),
                color: Colors.blue,
                onPressed: () {
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}



