import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();
//lera generic dialog Dialog aka lo error u logout u login y bakar de
//ka bakarmanhinaytawa la logout dialog u show auth error y
Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionsBuilder,
}) {
  final options = optionsBuilder();
  //lerawa dastpedaka showDialog a widget y flutter ya lo peshandani dialog y bakar de
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: options.keys.map((optionTitle) {
          final value = options[optionTitle];
          return TextButton(
            onPressed: () {
              if (value != null) {
                Navigator.of(context).pop(value);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(
              optionTitle,
              style: GoogleFonts.montserrat(color: Colors.blueGrey),
            ),
          );
        }).toList(),
      );
    },
  );
}
