import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/Entity/user_entiry.dart';
import '../../domain/repository/user_repo.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';
import '../widget/customPhoneField.dart';
import '../widget/custome_Button.dart';
import '../widget/custome_TextFormField.dart';
import '../widget/title.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _signupPageState();
}

class _signupPageState extends State<SignupPage> {
  final imegepath = 'asset/images/logo.png';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
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
          decoration: const BoxDecoration(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),

                // Title
                Text(
                  'Register',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                    fontFamily: 'inter',
                  ),
                ),

                const SizedBox(height: 5),
                Titles(
                  text: 'create Account to continue!',
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
                  controller: nameController,
                  hintText: 'Enter your First name',
                  keyboardType: TextInputType.text,
                ),

                const SizedBox(height: 10),

                CustomTextFormField(
                  onChanged: (value) {},
                  controller: emailController,
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 10),
                // customPhoneField(passwordController),
                const SizedBox(height: 10),
                // Password field
                CustomTextFormField(
                  onChanged: (value) {},
                  controller: passwordController,
                  hintText: 'Enter your password',
                  keyboardType: TextInputType.visiblePassword,

                  isPassword: true,
                ),
                const SizedBox(height: 10),
                // Password field
                CustomTextFormField(
                  onChanged: (value) {},
                  controller: confirmpasswordController,
                  hintText: 'Confirm your password',
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
                    print('button clicked');
                    // Handle signup logic here

                    // Dispatch the RegisterEvent with the user data
                    context.read<UserBloc>().add(
                      RegisterEvent(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                      ),
                    );
                  },
                  text: 'Register',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),

                  color: Colors.black,
                ),

                const SizedBox(height: 20),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is RegisterUserstate) {
                      return Text(
                        'registed user is : ${state.user.username}',
                        style: const TextStyle(color: Colors.red),
                      );
                    } else if (state is UserError) {
                      return Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      );
                    }

                    return Container();
                  },
                ),

                // signup button
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
                //     // Handle signup logic here
                //   },
                //   text: 'Continue as a Guest',
                //   style: TextStyle(
                //     fontSize: 14,
                //     color: AppColors.black,
                //     fontWeight: FontWeight.w500,
                //     fontFamily: 'Inter',
                //   ),

                //   color: AppColors.textSecondary,
                // ),

                // Socials (examples)
                const SizedBox(height: 70),

                // Sign up row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // context.go('/login');

                        Navigator.pushNamed(context, '/signin');
                      },
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
