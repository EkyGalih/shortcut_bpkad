import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailBerita extends StatelessWidget {
  final uuid;
  final String apiUrl = "https://bpkad.ntbrprov.go.id/api/berita/";
  DetailBerita({this.uuid});

  Future<List<dynamic>> _fetchBerita() async {
    var result = await http.get(Uri.parse(apiUrl, uuid));
    return json.decode(result.body)['data'];
  }

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
                  'titles',
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
