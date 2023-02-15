// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';


// class OrderScreen extends StatelessWidget {
//   static const routeName = '/order';
//   OrderScreen({super.key});

//   bool _isDisable = false;

//   String phone = '';
//   Future<String> _getUserPhoneNo(String userId) async {
//     FirebaseFirestore.instance.collection('user').doc(userId).get().then(
//           (value) => phone = value.data()!['phoneNo'].toString(),
//         );
//     return phone;
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final screenWidth = size.width;
//     final screenHeight = size.height;
//     return BlocConsumer<CartBloc, CartState>(
//       listener: (context, state) {
//         const CartLoaded();
//       },
//       builder: (context, state) {
//         if (state is CartLoading) {
//           return const Center(
//             child: CircularProgressIndicator(
//               color: Colors.black,
//             ),
//           );
//         }
//         if (state is CartLoaded) {
//           final totalPrice = state.cart.totalPrice;
//           if (totalPrice != 0) {
//             _isDisable = true;
//           } else {
//             _isDisable = false;
//           }
//           var itemsName;
//           final itemsInCart = state.cart.items;
//           // for (int i = 0; i < itemList.length; i++) {
//           //   itemsInCart.map((e) => e.toMap()[i]).toList();
//           // }
//           for (var index in itemsInCart) {
//             itemsName = index;
//           }
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               children: [
//                 ListTile(
//                   enabled: _isDisable,
//                   title: const Text("Total"),
//                   subtitle: Text(
//                     totalPrice.toString(),
//                     style: GoogleFonts.montserrat(
//                         color: Colors.blueAccent.shade700),
//                   ),
//                   trailing: ElevatedButton(
//                     onPressed: _isDisable
//                         ? () async {
//                             final userId = FirebaseAuth.instance.currentUser;
//                             final getUseremail = userId!.email;
//                             await _getUserPhoneNo(userId.uid);
//                             DateTime today = DateTime.now();
//                             String dateStr = today.toString().substring(0, 19);
//                             FirebaseFirestore.instance
//                                 .collection('orders')
//                                 .doc(dateStr)
//                                 .set({
//                                   'userEmail': getUseremail,
//                                   'phoneNo': phone,
//                                   'price': totalPrice,
//                                   'itemsName': itemsInCart
//                                       .map<Map>((e) => e.toMap())
//                                       .toList(),
//                                 })
//                                 .then(
//                                   (value) => ScaffoldMessenger.of(context)
//                                       .showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                           'Thanks For Your Order Wait We Will Call You As Soon As Possible '),
//                                     ),
//                                   ),
//                                 )
//                                 .then((value) => itemsInCart.clear());
//                           }
//                         : null,
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.black,
//                       backgroundColor: const Color(0xFF86E5FF),
//                     ),
//                     child: const Text(
//                       "Order",
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: screenHeight * 0.6,
//                   child: ListView.builder(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       itemCount: state.cart.items.length,
//                       itemBuilder: (context, index) {
//                         final items = state.cart.items[index];

//                         return ListTile(
//                           leading: CircleAvatar(
//                             backgroundImage: NetworkImage(items.image),
//                           ),
//                           title: Text(items.name),
//                           subtitle: Text(
//                             "${items.price} \$",
//                             style: GoogleFonts.montserrat(
//                                 color: Colors.blueAccent.shade700),
//                           ),
//                           trailing: Text(
//                             "x2",
//                             style: GoogleFonts.montserrat(color: Colors.black),
//                           ),
//                         );
//                       }),
//                 )
//               ],
//             ),
//           );
//         }
//         return const Text('Something went wrong!');
//       },
//     );
//   }
// }
