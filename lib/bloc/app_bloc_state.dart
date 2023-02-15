part of 'app_bloc_bloc.dart';

///state loway bakar de lanaw eventakan esh bkan w agayan la gorankari data y by yan
///hinan u brdni data y

@immutable
abstract class AppBlocState {
  final Items? items;
  final bool isLoading;
  final AuthError? authError;

  const AppBlocState({
    required this.isLoading,
    this.authError,
    this.items,
  });
}

@immutable
class AppBlocStateLoggedIn extends AppBlocState {
  final User user;
  // final Iterable<Reference> images;
  const AppBlocStateLoggedIn({
    required bool isLoading,
    required this.user,
    // required this.images,
    AuthError? authError,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );

  // @override
  // bool operator ==(other) {
  //   final otherClass = other;
  //   if (otherClass is AppBlocStateLoggedIn) {
  //     return isLoading == otherClass.isLoading &&
  //         user.uid == otherClass.user.uid;
  //   } else {
  //     return false;
  //   }
  // }

  // @override
  // int get hashCode => Object.hash(
  //       user.uid,
  //       isLoading,
  //     );

  // @override
  // String toString() => 'AppBlocStateLoggedIn, images.length = ${images.length}';
}

@immutable
class AppBlocStateLoggedOut extends AppBlocState {
  const AppBlocStateLoggedOut({
    required bool isLoading,
    final AuthError? authError,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );

  @override
  String toString() =>
      'AppBlocStateLoggedOut, isLoading = $isLoading, authError = $authError';
}

@immutable
class AppBlocStateIsInRegistrationView extends AppBlocState {
  const AppBlocStateIsInRegistrationView({
    required bool isLoading,
    AuthError? authError,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );
}

@immutable
class AppBlocStateGoToDetailScreen extends AppBlocState {
  final BuildContext? context;
  final String? ref;
  const AppBlocStateGoToDetailScreen({
    this.context,
    this.ref,
    Items? items,
    required bool isLoading,
    AuthError? authError,
  }) : super(
          isLoading: isLoading,
          authError: authError,
          items: items,
        );

  // @override
  // bool operator==(other){
  //   final documnetId=other;
  //   return documnetId is AppBlocStateGoToDetailScreen && documnetId==ref;
  // }

  //   @override

  //   int get hashCode => Object.hash(ref, I);
}

extension GetUser on AppBlocState {
  User? get user {
    final cls = this;
    if (cls is AppBlocStateLoggedIn) {
      return cls.user;
    } else {
      return null;
    }
  }
}

// extension GetImages on AppBlocState {
//   Iterable<Reference>? get images {
//     final cls = this;
//     if (cls is AppBlocStateLoggedIn) {
//       return cls.images;
//     } else {
//       return null;
//     }
//   }
// }
