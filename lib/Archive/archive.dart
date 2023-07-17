import 'package:flutter/material.dart';
import 'package:pegawai/Archive/add_archive.dart';

void main() {
  runApp(Archive());
}

class Archive extends StatefulWidget {
  @override
  _ArchiveState createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  final List archive = [
    'dokumen 1',
    'dokumen 2',
    'dokumen 3',
    'dokumen 4',
    'dokumen 5',
    'dokumen 6',
    'dokumen 7',
    'dokumen 8',
    'dokumen 9',
    'dokumen 10',
    'dokumen 12',
    'dokumen 13',
    'dokumen 14',
    'dokumen 15',
    'dokumen 16',
    'dokumen 17',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(
                archive[index],
                style: TextStyle(fontSize: 30),
              ),
            ),
          );
        },
        itemCount: archive.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add_archive');
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
