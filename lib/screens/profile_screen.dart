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
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
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
              final snap = snapshot.data!.docs;
              return ListView.builder(
                itemCount: snap.length,
                itemBuilder: (context, index) {
                  final itemsData = snap[index];

                  return Dismissible(
                    key: UniqueKey(),
                    background: Material(
                        color: Colors.red.shade400,
                        child: const Icon(Icons.delete)),
                    onDismissed: (dismissed) async {
                      await itemsData.reference.delete().then((value) {
                        return ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Thanks For Your Order Wait We Will Call You As Soon As Possible '),
                          ),
                        );
                      });
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(itemsData['image']),
                      ),
                      title: Text(itemsData['name']),
                      subtitle: Text(
                        "${itemsData['price'].toString()} \$",
                        style: GoogleFonts.montserrat(
                            color: Colors.blueAccent.shade700),
                      ),
                      trailing: Text(
                        "x2",
                        style: GoogleFonts.montserrat(color: Colors.black),
                      ),
                    ),
                  );
                },
              );
          }
        });
  }
}
