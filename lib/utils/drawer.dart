import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_shop_admin/bloc/app_bloc_bloc.dart';
import 'package:online_shop_admin/dialogs/logout_dialog.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance.currentUser!;
    //hinani email y user
    final userEmail = auth.email;
    //hinani 7 piti yakami email y u bakarhenani waku naw
    final userName = userEmail!.substring(0, 7);
    final db =
        FirebaseFirestore.instance.collection('user').doc(auth.uid).snapshots();

    return Drawer(
      child: StreamBuilder(
          stream: db,
          builder: (context, snapshot) {
            final snapStatus = snapshot.connectionState;
            switch (snapStatus) {
              case ConnectionState.none:

              case ConnectionState.waiting:

              case ConnectionState.done:
                return const Center(
                  child: CircularProgressIndicator(color: Colors.black),
                );
              case ConnectionState.active:
                if (!snapshot.hasData) {
                  return const Text(
                    'Check your connection',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  );
                }
                final data = snapshot.data!.data()! as Map<String, dynamic>;
                return ListView(
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                            image: NetworkImage(data['image']),
                            fit: BoxFit.cover),
                      ),
                      accountName: Material(
                        color: Colors.black.withOpacity(0.8),
                        child: Text(
                          userName,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(),
                        ),
                      ),
                      accountEmail: Material(
                        color: Colors.black.withOpacity(0.8),
                        child: Text(
                          userEmail.toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final showLogoutDialog =
                            await showLogOutDialog(context);
                        if (showLogoutDialog) {
                          context.read<AppBlocBloc>().add(
                                const AppBlocEventLogOut(),
                              );
                        }
                      },
                      child: Text(
                        'Log out',
                        style: GoogleFonts.montserrat(color: Colors.black),
                      ),
                    )
                  ],
                );
            }
          }),
    );
  }
}
