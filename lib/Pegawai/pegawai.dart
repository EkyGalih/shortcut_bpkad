import 'package:flutter/material.dart';
import 'package:pegawai/Pegawai/add_pegawai.dart';

void main() {
  runApp(Pegawai());
}

class Pegawai extends StatefulWidget {
  @override
  _PegawaiState createState() => _PegawaiState();
}

class _PegawaiState extends State<Pegawai> {
  final List pegawai = [
    'Yul Hadiansyah',
    'Eky Galih Gunanda',
    'Edi Suprayatno',
    'Arsani Aryadi',
    'Yudha Sancoko',
    'Niar Rosianan',
    'Anita Rosiana',
    'Erika Yuliandari',
    'Asad',
    'Irvin Wira'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(
                pegawai[index],
                style: TextStyle(fontSize: 30),
              ),
              subtitle: Text('disini nip'),
              leading: ClipOval(
                child: Image(
                  width: 30,
                  height: 30,
                  image: AssetImage('assets/images/male.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: pegawai.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add_pegawai');
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
