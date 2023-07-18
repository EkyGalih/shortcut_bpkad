import 'package:flutter/material.dart';

class DetailBerita extends StatelessWidget {
  final uuid;

  DetailBerita({this.uuid});

  // final String apiUrl = "https://bpkad.ntbprov.go.id/api/berita/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Berita"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            color: Colors.grey[200],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'title',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'date',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 5),
                Text('Content'),
                Divider(),
                Text('Author :'),
                Text('Sumber :'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
