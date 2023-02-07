import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contacts'),
      ),
      body: Form( 
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
         Container(
            height: 300,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Expanded(child: image == null ?
                   const Center(child: Text('no image'))
                    :Image.file(image)
                    )]
                    )
                  )
          ),
          ElevatedButton(
              style: OutlinedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 15),
                backgroundColor: Colors.green,
              ),
              onPressed: (){
                imagePicker(ImageSource.gallery);
              }, child:
          const Text('Select Image', )),
          ElevatedButton(
              style: OutlinedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 15),
                backgroundColor: Colors.green,
              ),
              onPressed: (){
                imagePicker(ImageSource.camera);
              }, child:
          const Text('Camera', )),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name'
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address'
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: numberController,
                  decoration: const InputDecoration(
                    labelText: 'Contact Number'
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(height: 50,
                child: ElevatedButton(
                  onPressed: postData,
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