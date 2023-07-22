import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijaukita/core/route/navigator.dart';
import 'package:hijaukita/core/theme/color_values.dart';
import 'package:hijaukita/core/util/validator/input_validator.dart';
import 'package:hijaukita/core/widgets/text_form_field/custom_text_form_field.dart';
import 'package:hijaukita/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:hijaukita/features/auth/presentation/pages/login/login_page.dart';
import 'package:hijaukita/features/auth/presentation/pages/otp/otp_page.dart';

import '../../../../../core/gen/assets.gen.dart';
import '../../../../../core/widgets/snackbar/snackbar_item.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
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
                    text: 'Selamat ',
                    style: textTheme.titleLarge!.copyWith(),
                    children: [
                      TextSpan(
                        text: 'Datang',
                        style: textTheme.titleLarge!.copyWith(
                          color: ColorValues.green02,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Kamu diharuskan mendaftar untuk masuk ke dalam aplikasi',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                CustomTextFormField(
                  label: 'Nama Lengkap',
                  controller: _fullNameController,
                  textInputType: TextInputType.name,
                  validator: (value) => InputValidator.emptyValidator(value),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  label: 'Email',
                  controller: _emailController,
                  textInputType: TextInputType.emailAddress,
                  validator: (value) => InputValidator.emailValidator(value),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  label: 'Kata sandi',
                  controller: _passwordController,
                  isPassword: true,
                  textInputType: TextInputType.visiblePassword,
                  validator: (value) => InputValidator.passwordValidator(value),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  label: 'Konfirmasi Kata sandi',
                  controller: _confirmPasswordController,
                  isPassword: true,
                  textInputType: TextInputType.visiblePassword,
                  validator: (value) => InputValidator.passwordValidator(value),
                ),
                const SizedBox(height: 16),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Dengan register kamu menyetujui ',
                    style: textTheme.bodySmall,
                    children: [
                      TextSpan(
                        text: 'Kebijakan ',
                        style: textTheme.bodySmall!.copyWith(
                          color: ColorValues.green02,
                        ),
                      ),
                      TextSpan(
                        text: 'dan ',
                        style: textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: 'Privasi ',
                        style: textTheme.bodySmall!.copyWith(
                          color: ColorValues.green02,
                        ),
                      ),
                      TextSpan(
                        text: 'Kami',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
                BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterSuccess) {
                      navigatorPushAndRemove(
                        context,
                        const OtpPage(),
                      );
                    } else if (state is RegisterFailure) {
                      showSnackBar(context, title: state.message);
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_passwordController.text !=
                              _confirmPasswordController.text) {
                            showSnackBar(context, title: 'Password tidak sama');
                          } else {
                            context.read<RegisterBloc>().add(
                                  PostRegisterEvent(
                                    fullName: _fullNameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                          }
                        }
                      },
                      child: state is RegisterLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text('Daftar'),
                    );
                  },
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    navigatorPush(context, const LoginPage());
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Sudah punya akun? ',
                      style: textTheme.bodySmall,
                      children: [
                        TextSpan(
                          text: 'Masuk',
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
