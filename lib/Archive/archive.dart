import 'package:flutter/material.dart';
import 'package:instabpkad/api/archive_api.dart';
import 'package:url_launcher/url_launcher.dart';
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
            var archive = snapshot.data;
            return RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(
                  const Duration(seconds: 1),
                );
                archive = ArchiveService().getArchive();
                setState(() {});
              },
              color: Colors.white,
              backgroundColor: Colors.blueAccent,
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: archive?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: 292,
                          child: ListTile(
                            leading: const Image(
                              image: AssetImage('assets/images/archive.png'),
                              height: 35,
                              width: 35,
                            ),
                            title: Text(archive?[index].nama),
                            subtitle: Text(
                              "Informasi ${archive?[index].jenis} (${archive?[index].tahun})"
                                  .toString(),
                            ),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("${archive?[index].nama}"),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () async {
                            final String baseUrl = archive?[index].files;
                            final url = Uri.parse(baseUrl);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                          icon: const Icon(Icons.download),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
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
