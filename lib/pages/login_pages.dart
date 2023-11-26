import 'package:bookabuku/components/components.dart';
import 'package:bookabuku/pages/welcome.dart';
import 'package:bookabuku/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

/// The scopes required by this application.
const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);

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
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                future: Authentication.initializeFirebase(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Error initializing Firebase');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GoogleSignInButton();
                  }
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.amber,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded GoogleSignInButton() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () async {
              User? user =
                  await Authentication.signInWithGoogle(context: context);

              if (user != null) {
                Navigator.pushNamed(context, WelcomePage.id);
              }
            },
            icon: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.transparent,
              child: Image.asset('assets/images/icons/google.png'),
            ),
          ),
        ],
      ),
    );
  }
}
