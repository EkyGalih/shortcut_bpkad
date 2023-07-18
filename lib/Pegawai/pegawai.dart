import 'package:flutter/material.dart';
import 'package:pegawai/Pegawai/add_pegawai.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(Pegawai());
}

class Pegawai extends StatefulWidget {
  @override
  _PegawaiState createState() => _PegawaiState();
}

class _PegawaiState extends State<Pegawai> {
  final String apiUrl = "https://bpkad.ntbprov.go.id/api/pegawai";

  Future<List<dynamic>> _fetchDataPegawai() async {
    var pegawai = await http.get(Uri.parse(apiUrl));
    return json.decode(pegawai.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: _fetchDataPegawai(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://bpkad.ntbprov.go.id/uploads/pegawai/" +
                                snapshot.data[index]['foto']),
                      ),
                      title: Text(snapshot.data[index]['name']),
                      subtitle: Text(snapshot.data[index]['nip']),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
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
