import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cbt_dhani/core/extensions/build_context_ext.dart';
import 'package:flutter_cbt_dhani/data/models/requests/register_request_model.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/constants/colors.dart';
import '../bloc/register/register_bloc.dart';
import '../widgets/register_success_dialog.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Register'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: emailController,
                    label: 'Email Address',
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextField(
                    controller: usernameController,
                    label: 'Username',
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextField(
                    controller: passwordController,
                    label: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    height: 60.0,
                    color: AppColors.light,
                    child: TextFormField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        labelText: 'Confirm Password',
                        labelStyle: const TextStyle(color: AppColors.grey),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 24.0),
          BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                success: (model) {
                  Future.delayed(
                    const Duration(seconds: 2),
                    () => context.pushReplacement(const LoginPage()),
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const RegisterSuccessDialog();
                    },
                  );
                },
                error: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Button.filled(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final model = RegisterRequestModel(
                          name: usernameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        context.read<RegisterBloc>().add(
                              RegisterEvent.register(model),
                            );
                      }
                      // final model = RegisterRequestModel(
                      //   name: usernameController.text,
                      //   email: emailController.text,
                      //   password: passwordController.text,
                      // );
                      // context.read<RegisterBloc>().add(
                      //       RegisterEvent.register(model),
                      //     );
                    },
                    label: 'REGISTER',
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 24.0),
          GestureDetector(
            onTap: () {
              context.pushReplacement(const LoginPage());
            },
            child: const Text.rich(
              TextSpan(
                text: 'Already have an account?? ',
                children: [
                  TextSpan(
                    text: 'Sign in',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
