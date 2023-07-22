import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hijaukita/core/route/navigator.dart';
import 'package:hijaukita/core/theme/color_values.dart';
import 'package:hijaukita/core/util/validator/input_validator.dart';
import 'package:hijaukita/core/widgets/snackbar/snackbar_item.dart';
import 'package:hijaukita/core/widgets/text_form_field/custom_text_form_field.dart';
import 'package:hijaukita/features/home/presentation/pages/home_page.dart';

import '../../../../../core/gen/assets.gen.dart';
import '../../../../../injection_container.dart';
import '../../bloc/login/login_bloc.dart';
import '../register/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Assets.icons.logo.svg(),
                const SizedBox(height: 16),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Selamat Datang Kembali, ',
                    style: textTheme.titleLarge!.copyWith(),
                    children: [
                      TextSpan(
                        text: 'Ayo Mulai',
                        style: textTheme.titleLarge!.copyWith(
                          color: ColorValues.green02,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Masuk dengan akun yang sudah terdaftar'),
                const SizedBox(height: 24),
                CustomTextFormField(
                  label: 'Email',
                  controller: _emailController,
                  textInputType: TextInputType.emailAddress,
                  validator: (value) => InputValidator.emailValidator(value),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  label: 'Password',
                  controller: _passwordController,
                  isPassword: true,
                  textInputType: TextInputType.visiblePassword,
                  validator: (value) => InputValidator.passwordValidator(value),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Lupa kata sandi?',
                    style: textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: 220),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      navigatorPushAndRemove(context, const HomePage());
                    } else if (state is LoginFailure) {
                      showSnackBar(context, title: state.message);
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginBloc>().add(
                                EmailLoginEvent(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              );
                        }
                      },
                      child: state is LoginLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text('Masuk'),
                    );
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: ColorValues.grey02,
                        thickness: 1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('Atau', style: textTheme.bodySmall),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Divider(
                        color: ColorValues.grey02,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    context.read<LoginBloc>().add(GoogleLoginEvent());
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.icons.google.svg(),
                        const SizedBox(width: 12),
                        Text(
                          'Masuk dengan Google',
                          style: textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    navigatorPush(context, const RegisterPage());
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Belum punya akun? ',
                      style: textTheme.bodySmall,
                      children: [
                        TextSpan(
                          text: 'Daftar',
                          style: textTheme.bodySmall!.copyWith(
                            color: ColorValues.green02,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
