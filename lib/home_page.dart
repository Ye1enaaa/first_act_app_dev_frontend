import 'dart:convert';

import 'package:first_app_dev/add_page.dart';
import 'package:first_app_dev/details_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'constants/constants.dart';
class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List receiver = <dynamic>[];

  Future<void> getData() async {
    final uri = Uri.parse(getContactURL);
    final response = await http.get(uri);
    
    if (response.statusCode == 200) {
      final decode = jsonDecode(response.body) as Map;
      final result = decode['post'] as List;
      setState(() {
        receiver = result;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CONTACT INFORMATION'),
      ),
      body: RefreshIndicator(
        onRefresh: getData,
        child: ListView.builder(
          itemCount: receiver.length,
          itemBuilder: (context,index){
            final item = receiver[index] as Map;
            final id = item['id'].toString();
            var nameValue = item['contactname'];
            var addressValue = item['address'];
            var numValue = item['contactnumber'];
            var imageValue = item['image'];
            return Dismissible(
              key: UniqueKey(),
                background: slideDelete(),
                onDismissed: (direction) async {
                  setState ((){
                    receiver.removeAt(index);
                    deleteData(id);
                  });
                },

              child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10),
                  decoration: const BoxDecoration(color: Color.fromARGB(30, 50, 40, 60)),
                  child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                              radius: 25.0,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                              NetworkImage('$getImageURL$imageValue')),

                          title: Text( nameValue,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),

                          trailing: const Icon(Icons.arrow_forward_ios_outlined),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsPage(
                                name: nameValue,
                                address: addressValue,
                                number: numValue,
                                image: imageValue)));
                            },
                        ),
                      ]
                  )
              )
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context)=> const AddPage()));
          },
          label: const Text('Add contact')),
    );
  }

  Future<void> deleteData(String id) async {
    final uri = Uri.parse('$deleteContactURL$id');
    final response = await http.delete(uri);

    if (response.statusCode == 200) {
      final filtered = receiver.where((element) => element['id'] != id).toList();
      setState(() {
        receiver = filtered;

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Successfully deleted!'),
                backgroundColor: Colors.green));
      });
    }
  }

  Widget slideDelete() {
    return Container(
      color: Colors.red,
      child: Align(alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            Text(
              " Delete Contact List",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}