import 'package:flutter/material.dart';
import 'package:instabpkad/Pegawai/dettail_pegawai.dart';
import 'package:instabpkad/api/pegawai_api.dart';
import 'package:instabpkad/model/pegawai/pegawai_model.dart';
// import 'package:image_card/image_card.dart';

class Pegawai extends StatefulWidget {
  const Pegawai({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PegawaiState createState() => _PegawaiState();
}

class _PegawaiState extends State<Pegawai> {
  late Future<List<PegawaiModel>> daftarPegawai;

  @override
  void initState() {
    super.initState();
    daftarPegawai = PegawaiService().getPegawai();
  }

  @override
  Widget build(BuildContext context) {
    // PegawaiService().getPegawai().then((value) => print("value: $value"));
    return Scaffold(
      body: FutureBuilder<List<PegawaiModel>>(
        future: daftarPegawai,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(
                  const Duration(seconds: 1),
                );
                data = PegawaiService().getPegawai();
                setState(() {});
              },
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 800,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Material(
                              child: Ink.image(
                                image: NetworkImage(
                                    "https://bpkad.ntbprov.go.id/uploads/pegawai/${data?[index].foto}"),
                                fit: BoxFit.fill,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (c) => DetailPegawai(
                                          name: data?[index].name,
                                          nip: data?[index].nip,
                                          jabatan: data?[index].jabatan,
                                          foto: data?[index].foto,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              data?[index].name,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              data?[index].nip ?? '------',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
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
      //     Navigator.of(context).pushNamed('/add_pegawai');
      //   },
      //   backgroundColor: Colors.blue,
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
