import 'package:flutter/material.dart';
import 'constants/constants.dart';

class DetailsPage extends StatelessWidget {
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
        title: const Text('Details Page'),
      ),
      body: ListTile(
        leading: CircleAvatar(child: Image.network(getImageURL + image)),
      ),
    );
  }
}