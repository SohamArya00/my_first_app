import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/components/my_button.dart';
import 'package:first_app/components/my_textfield.dart';
import 'package:first_app/components/square_tile.dart';
import 'package:first_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //Sign User In
  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Try Sign In
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // pop the loading Circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading Circle
      Navigator.pop(context);

      //show error meassage
      showErrorMessage(e.code);
    }
  }

  //Error Message to the user
  void showErrorMessage(String mesaage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 255, 72, 196),
          title: Center(
            child: Text(
              mesaage,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 13, 104, 180),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),

                  // Logo
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Image.asset(
                      'lib/images/Pixel_Foods_Logo_White.png',
                    ),
                  ),

                  const SizedBox(height: 50),

                  //Welcome Back
                  const Text(
                    'LOGIN TO YOUR ACCOUNT',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 25),

                  //email TextField
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  //Password TextField
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  // Forgot Password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.white60),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // SignIn Button
                  MyButton(
                    text: 'Sign In',
                    onTap: signUserIn,
                  ),

                  const SizedBox(height: 50),

                  // or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.white38,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or Continue With',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.white38,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  // google + apple signIn buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Google Button
                      SquareTile(
                        onTap: () => AuthService().signInWithGoogle(),
                        imagePath: 'lib/images/google.png',
                      ),

                      const SizedBox(width: 25),
                      // Apple Button
                      SquareTile(
                        onTap: () {},
                        imagePath: 'lib/images/apple.png',
                      ),
                    ],
                  ),

                  const SizedBox(height: 50),

                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Register Now',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 72, 196),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
