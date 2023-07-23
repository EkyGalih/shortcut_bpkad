import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(Archive());
}

class Archive extends StatefulWidget {
  @override
  _ArchiveState createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  final String apiUrl = "https://bpkad.ntbprov.go.id/api/kip";

  Future<List<dynamic>> _fetchDataFile() async {
    var file = await http.get(Uri.parse(apiUrl));
    return json.decode(file.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: _fetchDataFile(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          snapshot.data[index]['nama_informasi'][0] +
                              "" +
                              snapshot.data[index]['nama_informasi'][2],
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      title: Text(snapshot.data[index]['nama_informasi']),
                      subtitle: Text("informasi " +
                          snapshot.data[index]['jenis_informasi'] +
                          " - [" +
                          snapshot.data[index]['tahun'].toString() +
                          "]"),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context).pushNamed('/add_archive');
      //   },
      //   backgroundColor: Colors.blue,
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
