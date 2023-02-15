import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/register';
  HomeScreen({super.key});
  String? imageUrl;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final descriptionController = TextEditingController();
    final categoryController = TextEditingController();
    //lo upload krdni rsm lanaw mobile y u lonaw firebase Storage

    return Scaffold(
      body: Form(
        key: _key,
        child: ListView(
          children: [
            SizedBox(
              height: screenHeight * 0.3,
              width: screenWidth,
              child: Center(
                child: Text(
                  'Upload Item',
                  style: GoogleFonts.montserrat(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Enter Your itemName',
                contentPadding: EdgeInsets.all(8),
              ),
              keyboardType: TextInputType.text,
              keyboardAppearance: Brightness.dark,
              validator: (value) {
                if (value == null) {
                  return 'Please Enter Your item name';
                }
                return '';
              },
            ),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'enter item description',
                contentPadding: EdgeInsets.all(8),
              ),
              keyboardType: TextInputType.text,
              keyboardAppearance: Brightness.dark,
              validator: (value) {
                if (value == null) {
                  return 'item description';
                }
                return '';
              },
            ),
            TextFormField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: 'enter item category',
                contentPadding: EdgeInsets.all(8),
              ),
              keyboardType: TextInputType.text,
              keyboardAppearance: Brightness.dark,
              validator: (value) {
                if (value == null) {
                  return 'Please enter item category';
                }
                return '';
              },
            ),
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: 'enter item price',
                contentPadding: EdgeInsets.all(8),
              ),
              keyboardType: TextInputType.number,
              keyboardAppearance: Brightness.dark,
              validator: (value) {
                if (value == null) {
                  return 'Please enter item price';
                }
                return '';
              },
            ),
            ElevatedButton(
              onPressed: () async {
                final image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  final pickedImage = File(image.path);

                  await FirebaseStorage.instance
                      .ref()
                      .child(image.path)
                      .putFile(pickedImage)
                      .then((imageData) async {
                    widget.imageUrl = await imageData.storage
                        .ref()
                        .child(image.path)
                        .getDownloadURL();
                    setState(() {
                      widget.imageUrl;
                    });
                  });
                } else {
                  print('error $image');
                }
              },
              child: Text(
                'pick an image',
                style: GoogleFonts.montserrat(color: Colors.black),
              ),
            ),
            SizedBox(
              width: screenWidth,
              height: screenHeight * 0.2,
              child: Image.network(
                widget.imageUrl ??
                    "https://media.istockphoto.com/id/178414064/photo/blue-spot-lights.jpg?b=1&s=170667a&w=0&k=20&c=5aDLTDPiXeocPrNZzafEblW18gvx9rrSVnKKtB9aHRM=",
                fit: BoxFit.fitHeight,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text;
                final images = widget.imageUrl;
                final description = descriptionController.text;
                final price = int.parse(priceController.text);
                final category = categoryController.text;

                FirebaseFirestore.instance.collection('items').doc().set({
                  'name': name,
                  'category': category,
                  'image': images,
                  'description': description,
                  'price': price,
                }).then((_) {
                  setState(() {
                    nameController.text = '';
                    priceController.text = '';
                    categoryController.text = '';

                    nameController.text = '';
                  });
                });
              },
              child: Text(
                'Upload',
                style: GoogleFonts.montserrat(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
