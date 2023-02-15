part of 'app_bloc_bloc.dart';

///lera eventakan dyari dakayn (Event dyari dakre lo aw eshanay ka pewista bkre w lagal App bloc y bastraytawa ) eventakan wak login logout peshandani data
@immutable
abstract class AppBlocEvent {
  const AppBlocEvent();
}

// @immutable
// class AppBlocEventUploadImage implements AppBlocEvent {
//   final String filePathToUpload;

//   const AppBlocEventUploadImage({
//     required this.filePathToUpload,
//   });
// }

// @immutable
// class AppBlocEventDeleteAccount implements AppBlocEvent {
//   const AppBlocEventDeleteAccount();
// }

@immutable
class AppBlocEventLogOut implements AppBlocEvent {
  const AppBlocEventLogOut();
}

@immutable
class AppBlocEventInitialize implements AppBlocEvent {
  const AppBlocEventInitialize();
}

@immutable
class AppBlocEventLogIn implements AppBlocEvent {
  final String email;
  final String password;

  const AppBlocEventLogIn({
    required this.email,
    required this.password,
  });
}

@immutable
class AppBlocEventGoToRegistration implements AppBlocEvent {
  const AppBlocEventGoToRegistration();
}

@immutable
class AppBlocEventGoToLogin implements AppBlocEvent {
  const AppBlocEventGoToLogin();
}

@immutable
class AppBlocEventRegister implements AppBlocEvent {
  final String role;
  final String image;
  final String email;
  final String password;
  final String phone;

  const AppBlocEventRegister({
    required this.phone,
    required this.image,
    required this.email,
    required this.password,
    this.role = 'admin',
  });
}

@immutable
class AppBlocEventGoToDetailScreen implements AppBlocEvent {
  final BuildContext context;
  final String? ref;
  const AppBlocEventGoToDetailScreen({
    this.ref,
    required this.context,
  });
}
