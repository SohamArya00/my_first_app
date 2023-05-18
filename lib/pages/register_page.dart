import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/components/my_button.dart';
import 'package:first_app/components/my_textfield.dart';
import 'package:first_app/components/square_tile.dart';
import 'package:first_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //Sign User Up
  void signUserUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //Check if the password is confirmed
    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);
      showErrorMessage("Passwords do not match");
      return;
    }

    // Try Creating the user
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
                  const SizedBox(height: 30),

                  // Logo
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Image.asset(
                      'lib/images/Pixel_Foods_Logo_White.png',
                    ),
                  ),

                  const SizedBox(height: 40),

                  //Create an account
                  const Text(
                    'CREATE YOUR ACCOUNT',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 20),

                  //username TextField
                  MyTextField(
                    controller: userNameController,
                    hintText: 'Username',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

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

                  //Confirm Password TextField
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 20),

                  // Forgot Password
                  //Padding(
                  //padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //child: Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  //children: const [
                  //Text(
                  //'Forgot Password?',
                  //style: TextStyle(color: Colors.white60),
                  //),
                  //],
                  //),
                  //),

                  //const SizedBox(height: 20),

                  // SignIn Button
                  MyButton(
                    text: 'Sign Up',
                    onTap: signUserUp,
                  ),

                  const SizedBox(height: 30),

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

                  const SizedBox(height: 30),

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

                  const SizedBox(height: 30),

                  // already a member? sign in
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 72, 196),
                            fontWeight: FontWeight.bold,
                          ),
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
