import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_form_bloc/bloc/auth_bloc.dart';
import 'package:login_form_bloc/login_screen.dart';
import 'package:login_form_bloc/widgets/gradient_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final authState = context.watch<AuthBloc>().state as AuthSuccess;
    return Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false);
          }
        }, builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AuthSuccess) {
            return Center(
              child: Column(
                children: [
                  Text(state.uid),
                  GradientButton(onPressed: () {
                    context.read<AuthBloc>().add(AuthLogoutRequested());
                  }),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        })
        // Instead of BlocBuild i can also use context.watch before returning the entire scaffold,
        // but this will rebuild the entire view whenever something changes instead of just this part:
        // body: BlocBuilder<AuthBloc, AuthState>(
        //   builder: (context, state) {
        //     final authState = state as AuthSuccess;
        //     return Center(
        //       child: Text(authState.uid),
        //     );
        //   },
        //),
        );
  }
}
