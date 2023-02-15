import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userCredential = FirebaseAuth.instance.currentUser!.uid;

    Size size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(userCredential)
            .snapshots(),
        builder: (context, snapshot) {
          final snapStatus = snapshot.connectionState;
          switch (snapStatus) {
            case ConnectionState.none:

            case ConnectionState.waiting:

            case ConnectionState.done:
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            case ConnectionState.active:
              if (!snapshot.hasData) {
                return const Text('Check your connection');
              }
              final snap = snapshot.data!.data()! as Map<String, dynamic>;
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                primary: true,
                children: [
                  SizedBox(
                    height: screenHeight * 0.2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.3),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          snap['image'],
                        ),
                        backgroundColor: Colors.blueGrey,
                        radius: 50.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Text(
                    'Account Details',
                    style: GoogleFonts.montserrat(
                        color: Colors.black, fontSize: 20),
                  ),
                  Divider(
                    color: Colors.black.withAlpha(150),
                  ),
                  Text(
                    "Email: ${snap['email']} ",
                    style: GoogleFonts.montserrat(
                        color: Colors.black, fontSize: 18),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Text(
                    "Password: ${snap['password']} ",
                    style: GoogleFonts.montserrat(
                        color: Colors.black, fontSize: 18),
                  ),
                ],
              );
          }
        });
  }
}
