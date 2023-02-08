import 'dart:convert';
import 'dart:io';
import 'package:first_app_dev/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'constants/constants.dart';

class AddPage extends StatefulWidget {
  const AddPage({ Key? key }) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Future <void> postData() async{
    final contactname = nameController.text;
    final address = addressController.text;
    final contactnumber = numberController.text;
    
   var request = http.MultipartRequest('POST', Uri.parse(postContactURL))
    ..fields.addAll(
         {
            'contactname': contactname,
           'address' : address,
            'contactnumber' : contactnumber
          })
      ..headers.addAll({'Content-Type': 'multipart/form-data'})
     ..files.add(await http.MultipartFile.fromPath('image', image!.path));
   await request.send();
   
  }
  
  var image;
  final imgpicker = ImagePicker();

  Future imagePicker(ImageSource imageType)async{
    final pick = await imgpicker.pickImage(source: imageType);
    setState(() {
      if(pick != null){
        image = File(pick.path);
      }
    }
    );
  }

  Future backtoPrevious()async{
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Contact added, please go back to homepage!'),
      backgroundColor: Colors.green));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Contacts'),
      ),
      body: Form( 
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    imagePicker(ImageSource.gallery);
                  },
                  child: Ink(
                    child: Container(
                    height: 300,
                    width: 350,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                        Expanded(child: image == null ?
                       const Center(child: Text('Tap to upload image'))
                        :Image.file(image,
                        width: 350,
                        height: 300,
                        fit: BoxFit.cover,
                        )
                        )],
                      ), 
                    ),
                            ),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Please enter name';
                      }
                    },
                    style: const TextStyle(color: Colors.white),
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      labelText: 'Name'
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Please enter address';
                      }
                    },
                    style: const TextStyle(color: Colors.white),
                    controller: addressController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      labelText: 'Address'
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Please enter contact number';
                      }
                    },
                    style: const TextStyle(color: Colors.white),
                    controller: numberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      labelText: 'Contact Number'
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      onPressed: ()async{
                        if(formKey.currentState!.validate()){
                          setState((){
                            postData();
                            backtoPrevious();
                          });
                        }
                      },
                      child: const Text('SUBMIT')),
                ),
              ],
            ),
          ),
          ),
      )
    );
  }
}
  
