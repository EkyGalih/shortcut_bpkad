import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:pegawai/berita/detail_berita.dart';

class Home extends StatelessWidget {
  final String apiUrl = "https://bpkad.ntbprov.go.id/api/berita";

  Future<List<dynamic>> _fetchDataBerita() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(5),
        child: FutureBuilder<List<dynamic>>(
          future: _fetchDataBerita(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      color: Colors.grey[200],
                      height: 100,
                      width: 100,
                      child: snapshot.data[index]['foto_berita'] != null
                          ? Image.network(
                              "https://bpkad.ntbprov.go.id/" +
                                  snapshot.data[index]['foto_berita'],
                              width: 100,
                              fit: BoxFit.cover)
                          : Center(),
                    ),
                    title: Text(
                      snapshot.data[index]['title'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      snapshot.data[index]['content'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => DetailBerita(
                                  uuid: snapshot.data[index]['id'])));
                    },
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
