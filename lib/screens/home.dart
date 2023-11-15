import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("data"),
      ),
      body: buildSafeArea(),
    );
  }

  BlocListener<AuthBloc, AuthState> buildSafeArea() {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen:  (prevState, _) => prevState is SignedIn,
      listener: (BuildContext context, AuthState state) {
        if (state is SignedOut) {
          Navigator.pushReplacementNamed(context, 'login');
          print("signout");
        }

        print("user $state");
        if (state is SignedIn) print("username ${state.fireBaseUser.displayName}");

      },
      child: SafeArea(child: BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (_, currentState) => currentState is SignedIn,
        builder: (BuildContext context, state) {
          if (state is SignedIn) {
            return Column(
              children: [
                const Center(child: Text("Home"),),
                TextButton(onPressed: () =>  context.read<AuthBloc>().add(Logout()),
                    child: const Text("Logout"))
              ],
            );
          }
          return const SizedBox.shrink();
        },
      )),
    );
  }
}
