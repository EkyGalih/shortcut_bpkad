import 'package:flutter/material.dart';
import 'package:instabpkad/api/berita_api.dart';
import 'package:instabpkad/berita/detail_berita.dart';
import 'package:instabpkad/model/berita/berita_model.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  late Future<List<BeritaModel>> daftarBerita;

  @override
  void initState() {
    super.initState();
    daftarBerita = BeritaService().getBerita();
  }

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
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              // Navigator.pushNamed(context, '/berita');
            },
            child: Container(
              padding: const EdgeInsets.only(top: 12, bottom: 10),
              child: Row(
                children: [
                  const Align(alignment: Alignment.centerLeft),
                  Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      child: const Text(
                        "Semua Berita",
                        style: TextStyle(fontSize: 14.0),
                      ))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 230,
            child: FutureBuilder<List<BeritaModel>>(
              future: daftarBerita,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    separatorBuilder: (context, _) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      return Card(
                        child: SizedBox(
                          width: 200,
                          // height: 200,
                          // color: Colors.blue,
                          child: Column(
                            children: [
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 4 / 3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Material(
                                      child: Ink.image(
                                        image: NetworkImage(
                                            'https://bpkad.ntbprov.go.id/${snapshot.data[index].image}'),
                                        fit: BoxFit.cover,
                                        child: InkWell(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailBerita(
                                                          id: snapshot
                                                              .data[index].id,
                                                          publishedAt: snapshot
                                                              .data[index]
                                                              .publishedAt,
                                                          title: snapshot
                                                              .data[index]
                                                              .title,
                                                          content: snapshot
                                                              .data[index]
                                                              .content,
                                                          image: snapshot
                                                              .data[index]
                                                              .image,
                                                          author: snapshot
                                                              .data[index]
                                                              .author,
                                                          tags: snapshot
                                                              .data[index]
                                                              .tag))),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                snapshot.data[index].title,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "By ${snapshot.data[index].author}",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black54),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
