import 'package:flutter/material.dart';
import 'package:instabpkad/api/berita_api.dart';
import 'package:intl/intl.dart';
import 'package:instabpkad/berita/detail_berita.dart';
import 'package:instabpkad/model/berita/berita_model.dart';

class Berita extends StatefulWidget {
  const Berita({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BeritaPageState createState() => _BeritaPageState();
}

class _BeritaPageState extends State<Berita> {
  late Future<List<BeritaModel>> daftarBerita;

  @override
  void initState() {
    super.initState();
    daftarBerita = BeritaService().getBerita();
  }

  // List<BeritaModel> display_list = List.from(daftarBerita);

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  // convert timestampt to date
  getCustomFormattedDateTime(String givenDateTime, String dateFormat) {
    // dateFormat = 'MM/dd/yy';
    final DateTime docDateTime = DateTime.parse(givenDateTime);
    return DateFormat(dateFormat).format(docDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(
                  labelText: 'Cari Berita', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<List<BeritaModel>>(
                future: daftarBerita,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data;
                    return ListView.builder(
                      itemCount: data?.length,
                      itemBuilder: (context, index) => ListTile(
                          title: Text(
                            data?[index].title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            // removeAllHtmlTags(snapshot.data[index]['content']),
                            "By ${data?[index].author}",
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => DetailBerita(
                                        id: data?[index].id,
                                        publishedAt: data?[index].publishedAt,
                                        title: data?[index].title,
                                        content: data?[index].content,
                                        image: data?[index].image,
                                        author: data?[index].author,
                                        tags: data?[index].tag)));
                          },
                          // trailing: Text(
                          //   getCustomFormattedDateTime(
                          //       snapshot.data[index]['created_at'], "MM/dd/yyyy"),
                          //   style: TextStyle(color: Colors.amber),
                          // ),
                          // leading: Image.network("https://bpkad.ntbprov.go.id/" +
                          //     snapshot.data[index].image),
                          leading: Image.network(
                              "https://bpkad.ntbprov.go.id/${data?[index].image}")),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
