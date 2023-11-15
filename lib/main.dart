import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spaces/screens/home.dart';
import 'package:spaces/screens/login.dart';
import 'blocs/auth_bloc.dart';
import 'firebase_options.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = AuthBloc();

    return BlocProvider<AuthBloc>(
      create: (BuildContext context) => authBloc,
      child: MaterialApp(
        title: 'Spaces',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          'login': (context) => const LoginScreen(),
          'home': (context) => const HomeScreen(),
        },
        home: const LoginScreen(),
      ),
    );
  }



}

