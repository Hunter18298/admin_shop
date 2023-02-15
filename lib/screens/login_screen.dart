import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_shop_admin/bloc/app_bloc_bloc.dart';
import 'package:online_shop_admin/extentions/if_debugging.dart';

class LoginScreen extends HookWidget {
  static const routeName = '/login';
  LoginScreen({super.key});
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;
    final emailController =
        useTextEditingController(text: 'paywandadmin@gmail.com'.ifDebugging);
    final passwordController =
        useTextEditingController(text: 'paywand&*'.ifDebugging);

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
                  'Login',
                  style:
                      GoogleFonts.montserrat(fontSize: 40, color: Colors.black),
                ),
              ),
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Enter Your Email',
                contentPadding: EdgeInsets.all(8),
              ),
              keyboardType: TextInputType.emailAddress,
              keyboardAppearance: Brightness.dark,
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Enter Your Password',
                contentPadding: EdgeInsets.all(8),
              ),
              obscureText: true,
              obscuringCharacter: '◎',
              keyboardType: TextInputType.visiblePassword,
              keyboardAppearance: Brightness.dark,
            ),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text;
                final password = passwordController.text;
                context.read<AppBlocBloc>().add(
                      AppBlocEventLogIn(
                        email: email,
                        password: password,
                      ),
                    );
              },
              child: Text(
                'Log in',
                style: GoogleFonts.montserrat(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () async {
                context
                    .read<AppBlocBloc>()
                    .add(const AppBlocEventGoToRegistration());
              },
              child: Text(
                "Don't have account yet?! Register here.",
                style: GoogleFonts.montserrat(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
