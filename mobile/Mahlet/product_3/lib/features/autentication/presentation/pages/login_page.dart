import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_route.dart';
import '../../../chat/data/Service/sockat_io.dart';
import '../../../chat/presentation/Bloc/chat_bloc.dart';
import '../../../chat/presentation/Bloc/chat_event.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';
import '../widget/custome_Button.dart';
import '../widget/custome_TextFormField.dart';
import '../widget/title.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final imegepath = 'asset/images/logo.png';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      body: Scaffold(
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 30, right: 30),
          // Make sure the container fills the entire screen
          width: double.infinity,
          height: double.infinity,

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo
                // Container(
                //   decoration: BoxDecoration(
                //     border: Border.all(color: AppColors.accent),
                //     borderRadius: BorderRadius.circular(200),
                //   ),
                //   height: 150,
                //   child: ClipRRect(child: image(imegepath)),
                // ),
                const SizedBox(height: 10),

                // Title
                Text(
                  'Sign in to your',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                    fontFamily: 'inter',
                  ),
                ),
                Text(
                  'Account',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                    fontFamily: 'inter',
                  ),
                ),
                const SizedBox(height: 5),
                Titles(
                  text: 'Enter your email and password to login',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 20),

                // Phone field
                CustomTextFormField(
                  onChanged: (value) {},
                  controller: emailController,
                  hintText: 'Enter your Email',
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 10),

                // Password field
                CustomTextFormField(
                  onChanged: (value) {},
                  controller: passwordController,
                  hintText: 'Enter your password',
                  keyboardType: TextInputType.visiblePassword,

                  isPassword: true,
                ),

                const SizedBox(height: 15),

                // Remember + Forget Password row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: checked,
                          onChanged: (value) {
                            setState(() {
                              checked = value ?? false;
                            });
                          },
                        ),
                        Text(
                          'Remember me',
                          style: TextStyle(color: Colors.black45, fontSize: 14),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                customButton(
                  onTap: () {
                    context.read<UserBloc>().add(
                      LoginEvent(emailController.text, passwordController.text),
                    );
                    // Handle login logic here
                    // context.go('/home');
                  },
                  text: 'Login',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),

                  color: Colors.black,
                ),

                // Login button
                const SizedBox(height: 15),
                BlocListener<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is LoginUserstate)  {
                      // print('applay to loadconatct');
                      // print(state);
                      // context.read<ChatBloc>().add(Loadcontact());
                      // print(state);
                      Navigator.pushNamed(context, AppRoute.contact);
                    }
                  },
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is UserError) {
                        return Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        );
                      }
                      // Build your UI here, e.g. show loading, error, or login form
                      return Container();
                    },
                  ),
                ),

                const SizedBox(height: 15),
                // OR divider
                Row(
                  children: [
                    Expanded(child: Divider(thickness: 1)),
                    const SizedBox(width: 10),
                    Text('or '),
                    const SizedBox(width: 10),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),

                const SizedBox(height: 15),

                // customButton(
                //   onTap: () {
                //     // Handle login logic here
                //   },
                //   text: 'Continue as a Guest',
                //   style: TextStyle(
                //     fontSize: 14,
                //     color: Colors.black,
                //     fontWeight: FontWeight.w500,
                //     fontFamily: 'Inter',
                //   ),

                //   color: AppColors.textSecondary,
                // ),

                // Socials (examples)
                const SizedBox(height: 70),

                // Sign up row
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,

                //   children: [
                //     Text(
                //       'Don\'t have an account? ',
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         fontSize: 14,
                //         color: AppColors.primary,
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         // context.go('/signup');
                //       },
                //       child: Text(
                //         'Sign up',
                //         style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: 14,
                //           color: AppColors.accent,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
