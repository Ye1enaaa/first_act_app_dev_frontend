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
            const SizedBox(height: 200),
          ],
        ),
        const SizedBox(height: 50),

        Center(
          child: ListTile(
            leading: const Icon(Icons.person, color: Colors.white70),
            minVerticalPadding: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: const Color(0xFF303030),
            textColor: Colors.white,

            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  flex: 4,
                  child: Text('Name'),
                ),
                Expanded(
                  flex: 9,
                  child: Text(': $name'),
                ),
              ],
            ),
          ),

        ),
        const SizedBox(height: 50),

        ListTile(
          leading: const Icon(Icons.place_rounded, color: Colors.white70),
          minVerticalPadding: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: const Color(0xFF303030),
          textColor: Colors.white,

          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 4,
                child: Text('Address'),
              ),
              Expanded(
                flex: 9,
                child: Text(': $address'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 50),

        ListTile(
          leading: const Icon(Icons.contact_phone_rounded, color: Colors.white70),
          minVerticalPadding: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: const Color(0xFF303030),
          textColor: Colors.white,

          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 4,
                child: Text('Contact number'),
              ),
              Expanded(
                flex: 9,
                child: Text(': $number'),
              ),
            ],
          ),
        ),
      ]),

    );
  }
  
