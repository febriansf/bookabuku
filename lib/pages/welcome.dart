import 'package:bookabuku/pages/login_pages.dart';
import 'package:bookabuku/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key, required User user})
      : _user = user,
        super(key: key);
  static final id = 'welcome_page';

  final User _user;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late User _user;
  bool _isSigningOut = false;

  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue[600],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(),
              _user.photoURL != null
                  ? ClipOval(
                      child: Material(
                        color: Colors.amber[400]!.withOpacity(0.3),
                        child: Image.network(
                          _user.photoURL!,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    )
                  : ClipOval(
                      child: Material(
                        color: Colors.amber[400]!.withOpacity(0.3),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Hello',
                style: TextStyle(color: Colors.grey, fontSize: 26),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                _user.displayName!,
                style: const TextStyle(
                  color: Colors.yellow,
                  fontSize: 26,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                '( ${_user.email!} )',
                style: const TextStyle(
                  color: Colors.yellow,
                  fontSize: 26,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              _isSigningOut
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.redAccent),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(
                          'Sign Out',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          _isSigningOut = true;
                        });

                        await Authentication.signOut(context: context);

                        setState(() {
                          _isSigningOut = false;
                        });

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
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
}
