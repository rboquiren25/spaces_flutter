import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(Initial());
    return  Scaffold(
      appBar: AppBar(
        title: const Text("abc"),
      ),
      body: buildSafeArea(context),
    );
  }

  BlocListener buildSafeArea(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, state) {
        if (state is SignedIn) {
          Navigator.pushReplacementNamed(context,'home');
          // Navigator.of(context, rootNavigator: true).pushNamed('home');
          print("signedin");
        }
      },
      child: SafeArea(
        child: Column(
          children: [
            TextButton(onPressed: () =>  context.read<AuthBloc>().add(Login()),
             child: const Text("Login with google"))
          ],
        ),
      ),
    );
  }
}
