import 'package:firstapp/pages/dashboart.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/components/my_textfield.dart';
import 'package:firstapp/components/my_button.dart';

import 'package:firstapp/components/square_tile.dart';


class  LoginPage extends StatelessWidget {
   LoginPage({super.key});

  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

   // sign user in method
   void signUserIn() {}

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 5),
               const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(height: 5),
                Text('welcome back you been missed',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16
                ),
                ),
                const SizedBox(height: 5),
             // username
                MyTextField(
                  controller: usernameController,
                  hintText: "userName",
                  obscureText: false,
                ),
                //password
                const SizedBox(height: 1),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 1),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 2),

                MyButton(

                  onTap: signUserIn,
                ),
                const SizedBox(height: 2),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the SecondPage when the button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NavigationExample()),
                    );
                  },
                  child: Text('Go to Second Page'),
                ),
                const SizedBox(height: 50),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // google button
                    SquareTile(imagePath: 'lib/images/google.jpg'),

                    SizedBox(width: 25),

                    // apple button
                    SquareTile(imagePath: 'lib/images/apple.jpg')
                  ],
                ),
                const SizedBox(height: 50),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )

              ],
            ),
          )
      )

    );
  }
}