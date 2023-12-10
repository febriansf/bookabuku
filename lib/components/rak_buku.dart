import 'package:flutter/material.dart';

class ShelvesPage extends StatefulWidget {
  const ShelvesPage({super.key});

  @override
  State<ShelvesPage> createState() => _ShelvesPageState();
}

class _ShelvesPageState extends State<ShelvesPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(16, 32, 16, 32),
            child: Text('Rak Buku',
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3EC6FF))),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
                child: Row(
                  children: [
                    rakList(),
                    rakList(),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
                child: Row(
                  children: [
                    rakList(),
                    rakList(),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: 200,
            height: 45,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFF3EC6FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    var emailController = TextEditingController();
                    var messageController = TextEditingController();
                    return AlertDialog(
                      title: Text('Tambah Rak'),
                      insetPadding: EdgeInsets.all(16),
                      content: SingleChildScrollView(
                          child: Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(hintText: 'Nama Rak'),
                          ),
                        ],
                      )),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Send them to your email maybe?
                            var email = emailController.text;
                            print(email);
                            Navigator.pop(context);
                          },
                          child: Text('Simpan'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                "Tambah Rak",
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          FloatingActionButton.extended(
            backgroundColor: const Color(0xFF3EC6FF),
            foregroundColor: Color(0xffffffff),
            onPressed: () {
              // Respond to button press
            },
            icon: Icon(Icons.add),
            label: Text('Tambah Rak'),
          ),
        ],
      ),
    );
  }
}

class rakList extends StatelessWidget {
  const rakList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // margin: EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Color(0xFF3EC6FF),
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: PopupMenuButton(
                      color: Colors.white,
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem<int>(
                            value: 0,
                            child: Text("Ubah nama"),
                          ),
                          PopupMenuItem<int>(
                            value: 1,
                            child: Text("Hapus rak"),
                          ),
                        ];
                      },
                      onSelected: (value) {
                        if (value == 0) {
                          print("My account menu is selected.");
                        } else if (value == 1) {
                          print("Settings menu is selected.");
                        }
                      }),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Text("Sedang dibaca",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
