import 'package:flutter/material.dart';

class ShelvesPage extends StatefulWidget {
  const ShelvesPage({super.key});

  @override
  State<ShelvesPage> createState() => _ShelvesPageState();
}

class _ShelvesPageState extends State<ShelvesPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 20.0,
      ),
      child: Text('RAK BUKU'),
    );
  }
}
//note