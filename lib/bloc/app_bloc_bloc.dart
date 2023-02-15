import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_shop_admin/auth/auth_error.dart';
import 'package:online_shop_admin/model/items.dart';

part 'app_bloc_event.dart';
part 'app_bloc_state.dart';

class AppBlocBloc extends Bloc<AppBlocEvent, AppBlocState> {
  AppBlocBloc()
      : super(const AppBlocStateLoggedOut(
          isLoading: false,
        )) {
    //aw event a katak barnamaka dabitawa yan ka dastpedakat
    on<AppBlocEventInitialize>((event, emit) async {
      //hinani user y la Firebase y
      final user = FirebaseAuth.instance.currentUser;
      //agar user null bu ya#ni batal bu w login nabubu awa dabi bchina page y logout y
      if (user == null) {
        emit(const AppBlocStateLoggedOut(
          isLoading: false,
        ));
      }
      //agar user peshtr login bu awa dachina naw barnamakay
      emit(AppBlocStateLoggedIn(
        isLoading: false,
        user: user!,
      ));
    });
    on<AppBlocEventLogIn>((event, emit) async {
      //lera aw event a wadaka ka login bi yakam sht pesh away login bi dabi logout bi
      emit(
        const AppBlocStateLoggedOut(
          isLoading: true,
        ),
      );
      //lera try agar eshaka ba rasty u ba reky roy w agar error y habu awa catch (e)
      //catch (e) ya3ni grtny error akay w danani lanaw (e)
      //on FirebaseAuthException  ya3ni waxty login dabi FirevaseAuth away mas2ula lasar login y user y
      //agar xalali tedabi awa error man dadate + baxoshman Error akanman danaya lanaw
      //auth_error.dart
      try {
        final email = event.email;
        final password = event.password;
        final userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        final user = userCredential.user!;
        emit(AppBlocStateLoggedIn(
          isLoading: false,
          user: user,
        ));
        final db = FirebaseFirestore.instance.collection('items');
        late Map<String, dynamic> getData;
        await db.get().then((value) {
          for (var doc in value.docs) {
            getData = doc.data();
          }
        });
        var items = Items.fromJson(getData);
        Items(
          name: items.name,
          description: items.description,
          price: items.price,
          image: items.image,
          category: items.category,
        );
      } on FirebaseAuthException catch (e) {
        emit(AppBlocStateLoggedOut(
          isLoading: false,
          authError: AuthError.from(e),
        ));
      }
    });
    //aw event a loway broya page y login y
    on<AppBlocEventGoToLogin>(
      (event, emit) => emit(
        const AppBlocStateLoggedOut(
          isLoading: false,
        ),
      ),
    );
    //aw event a loway broyna page y Registration y
    on<AppBlocEventGoToRegistration>((event, emit) async {
      emit(
        const AppBlocStateIsInRegistrationView(
          isLoading: false,
        ),
      );
    });
    on<AppBlocEventLogOut>((event, emit) {
      emit(const AppBlocStateLoggedOut(
        isLoading: true,
      ));
      //logout la Firebase y
      FirebaseAuth.instance.signOut();
      emit(const AppBlocStateLoggedOut(
        isLoading: false,
      ));
    });
    on<AppBlocEventRegister>((event, emit) async {
      //start loading
      emit(
        const AppBlocStateIsInRegistrationView(isLoading: true),
      );
      try {
        final image = event.image;
        final email = event.email;
        final password = event.password;
        final phone = event.phone;
        final role = event.role;
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        final db = FirebaseFirestore.instance
            .collection('user')
            .doc(userCredential.user!.uid);
        db.set(
          {
            'email': email,
            'password': password,
            'image': image,
            'phoneNo': phone,
            'role': role,
          },
        );
        emit(
          AppBlocStateLoggedIn(
            isLoading: false,
            user: userCredential.user!,
          ),
        );
      } on FirebaseAuthException catch (e) {
        emit(AppBlocStateLoggedOut(
            isLoading: false, authError: AuthError.from(e)));
      }
    });
  }
}
