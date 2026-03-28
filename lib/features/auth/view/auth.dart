import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partner_dashboard/constants/constants.dart';
import 'package:partner_dashboard/features/auth/logic/auth_bloc/auth_bloc.dart';
import 'package:partner_dashboard/features/dashboard/view/dashboard.dart';
import 'package:partner_dashboard/widgets/button.dart';
import 'package:partner_dashboard/widgets/text_input_field.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  late TextEditingController _partnerKeyController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _partnerKeyController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _partnerKeyController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const Dashboard()),
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 8,
                  children: [
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 8,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  Constants.loginTitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                ),
                              ),
                              Text(
                                Constants.loginDescription,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(fontSize: 16),
                              ),
                              TextInputField(
                                label: Constants.partnerIdLabel,
                                hintText: Constants.partnerIdHint,
                                controller: _partnerKeyController,
                              ),
                              TextInputField(
                                label: Constants.emailLabel,
                                hintText: Constants.emailHint,
                                controller: _emailController,
                              ),
                              TextInputField(
                                label: Constants.passwordLabel,
                                hintText: Constants.passwordHint,
                                controller: _passwordController,
                                isPassword: true,
                              ),
                              SizedBox(height: 8),
                              ButtonWidget(
                                label: Constants.loginButton,
                                onPressed: () {
                                  context.read<AuthBloc>().add(
                                    LoginRequested(
                                      partnerKey: _partnerKeyController.text
                                          .trim(),
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 8),
                              Center(
                                child: Column(
                                  spacing: 4,
                                  children: [
                                    Text(
                                      Constants.newToMealNest,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                    Text(
                                      Constants.contactUs,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.outline,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text(
                      Constants.privacyPolicy,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
