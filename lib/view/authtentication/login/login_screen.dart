import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/core/routes/app_routes.dart';
import 'package:barberzlink/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool _rememberMe = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    AppStrings.appLogo,
                    height: 250,
                    fit: BoxFit.cover,
                  ),

                  Text(
                    AppStrings.welcomeMessage,
                    style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Login to BarberzLink — whether you\'re a Barber, Barbershop Owner, Event Organizer, or School Partner, sign in to manage your services, connect with clients, and grow your network all in one place.',
                    style: GoogleFonts.poppins(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          label: 'Username or Email',
                          icon: Icons.person_outline,
                          isTitle: true,
                          titleName: 'Username or Email',
                        ),
                        const SizedBox(height: 18),
                        CustomTextField(
                          label: 'Password',
                          icon: Icons.lock_outline,
                          isPasswordField: true,
                          isTitle: true,
                          titleName: 'Password',
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                              activeColor: Colors.black,
                              checkColor: Colors.white,
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() => _rememberMe = value!);
                              },
                            ),
                            const Text(
                              'Remember Me',
                              style: TextStyle(color: Colors.black54),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.black),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 25),
                        CustomButton(
                          buttonText: 'Login',
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              AppRoutes.goToReplace(
                                  context, AppRoutes.dashboard);
                            }
                          },
                        ),
                        // SizedBox(
                        //   width: double.infinity,
                        //   height: 50,
                        //   child: ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: Colors.black,
                        //       foregroundColor: Colors.white,
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(12),
                        //       ),
                        //       elevation: 2,
                        //     ),
                        //     onPressed: () {
                        //       if (_formKey.currentState!.validate()) {
                        //         // TODO: Implement login logic
                        //         AppRoutes.goToReplace(context, AppRoutes.dashboard);
                        //       }
                        //     },
                        //     child: const Text(
                        //       'Login',
                        //       style: TextStyle(
                        //         fontSize: 18,
                        //         fontWeight: FontWeight.w600,
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Not a member yet?",
                              style: TextStyle(color: Colors.black54),
                            ),
                            TextButton(
                              onPressed: () {
                                // TODO: Navigate to register page

                                Navigator.pushNamed(
                                    context, AppRoutes.registration);
                              },
                              child: Text(
                                'Register now',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
