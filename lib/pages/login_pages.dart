import 'package:bookabuku/components/components.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/images/signup.png'),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Login Page',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const CustomTextField(
                        textField: TextField(
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Email'),
                        ),
                      ),
                      const CustomTextField(
                        textField: TextField(
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Passwword'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Login'),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.transparent,
                        child: Image.asset('assets/images/icons/google.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
