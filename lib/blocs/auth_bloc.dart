import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../firebase_options.dart';



abstract class AuthEvent {}
class Initial extends AuthEvent {}
class Login extends AuthEvent {}
class Logout extends AuthEvent {}

@immutable
abstract class AuthState {}
class SignedIn extends AuthState{
  User fireBaseUser;
  SignedIn({required this.fireBaseUser});
}
class SignedOut extends AuthState{}
class Progress extends AuthState{}



class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static final AuthBloc _authBloc = AuthBloc._internal();

  factory AuthBloc() {
    return _authBloc;
  }

  User? _fireBaseUser;

  AuthBloc._internal(): super(SignedOut()) {
    on<Initial>((event, emit) {
      googleAuthInit();
      });
    on<Login>((_,__) => signInWithGoogle());
    on<Logout>((_,__) => FirebaseAuth.instance.signOut());
  }

  googleAuthInit() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        _fireBaseUser = null;
        emit(SignedOut());
      } else {
        _fireBaseUser = user;
        emit(SignedIn(fireBaseUser: _fireBaseUser!));
      }
    });

    FirebaseAuth.instance
        .userChanges()
        .listen((User? user) {
      if (user == null) {
        _fireBaseUser = null;
        emit(SignedOut());
      } else {
        _fireBaseUser = user;
        emit(SignedIn(fireBaseUser: _fireBaseUser!));
      }
    });
  }
}

Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
    "https://www.googleapis.com/auth/userinfo.profile"
  ]).signIn();

  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;


  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  return await FirebaseAuth.instance.signInWithCredential(credential);
}