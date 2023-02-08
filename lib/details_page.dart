import 'package:flutter/material.dart';
import 'constants/constants.dart';

class DetailsPage extends StatelessWidget {

  final double coverHeight = 280;

final String name;
final String address;
final String number;
final String image;
const DetailsPage({ 
  Key? key ,
  required this.name,
  required this.address,
  required this.number,
  required this.image
}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        title: const Text('Details Page'),
      ),
      body: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Stack(
          //clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Column(
                children: [
                  Image.network(getImageURL + image,
                      width: double.infinity,
                      height: coverHeight,
                      fit: BoxFit.cover),
                ],

            ),
            const SizedBox(height: 30),

            Column(

            )
          ],
        ),

            ],),




      // body: ListTile(
      //   leading: CircleAvatar(child: Image.network(getImageURL + image)),
      //   //title:
      // ),
    );
  }
}