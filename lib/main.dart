import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_shop_admin/bloc/app_bloc_bloc.dart';
import 'package:online_shop_admin/dialogs/show_auth_error.dart';
import 'package:online_shop_admin/loading/loading_screen.dart';
import 'package:online_shop_admin/main_home.dart';
import 'package:online_shop_admin/screens/details_screen.dart';
import 'package:online_shop_admin/screens/home_screen.dart';
import 'package:online_shop_admin/screens/login_screen.dart';
import 'package:online_shop_admin/screens/order_screen.dart';
import 'package:online_shop_admin/screens/profile_screen.dart';
import 'package:online_shop_admin/screens/register_screen.dart';
import 'package:online_shop_admin/shopping_observer.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = const SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBlocBloc>(
      create: (context) => AppBlocBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'admin',
        theme: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF86E5FF),
            textTheme: GoogleFonts.montserratTextTheme(
              const TextTheme(
                headline6: TextStyle(fontSize: 22.5),
                headline5: TextStyle(color: Colors.black),
                subtitle1: TextStyle(color: Colors.black),
              ),
            ),
            colorScheme:
                const ColorScheme.light().copyWith(primary: Colors.white)),
        home: BlocConsumer<AppBlocBloc, AppBlocState>(
          ///lera ba pey state akan screen akan dagordret
          builder: (context, appState) {
            if (appState is AppBlocStateLoggedOut) {
              return LoginScreen();
            } else if (appState is AppBlocStateLoggedIn) {
              return const HomePage();
            } else if (appState is AppBlocStateIsInRegistrationView) {
              return RegisterScreen();
            } else if (appState is AppBlocEventGoToLogin) {
              return LoginScreen();
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          listener: (context, appState) {
            if (appState.isLoading) {
              LoadingScreen.instance().show(
                context: context,
                text: 'Loading...',
              );
            } else {
              LoadingScreen.instance().hide();
            }

            final authError = appState.authError;
            if (authError != null) {
              showAuthError(
                authError: authError,
                context: context,
              );
            }
          },
        ),
        //routes lo arastakrdni screen akani naw application aka bakar det
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          ProfileScreen.routeName: (context) => const ProfileScreen(),
        },
      ),
    );
  }
}
