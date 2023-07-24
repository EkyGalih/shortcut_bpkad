import 'package:flutter/material.dart';
import 'package:instabpkad/api/archive_api.dart';

import 'package:instabpkad/model/archive/archive_model.dart';

void main() {
  runApp(const Archive());
}

class Archive extends StatefulWidget {
  const Archive({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ArchiveState createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  late Future<List<ArchiveModel>> daftarArchive;

  @override
  void initState() {
    super.initState();
    daftarArchive = ArchiveService().getArchive();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: daftarArchive,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading:
                        const CircleAvatar(child: Icon(Icons.file_present)),
                    title: Text(snapshot.data[index].nama),
                    subtitle: Text(
                      "Informasi ${snapshot.data[index].jenis} (${snapshot.data[index].tahun})"
                          .toString(),
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${snapshot.data[index].nama}"),
                        ),
                      );
                    },
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
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
