import 'package:flutter/material.dart';
import 'package:instabpkad/api/berita_api.dart';
import 'package:intl/intl.dart';
import 'package:instabpkad/berita/detail_berita.dart';
import 'package:instabpkad/model/berita/berita_model.dart';

class Berita extends StatefulWidget {
  @override
  _BeritaPageState createState() => _BeritaPageState();
}

class _BeritaPageState extends State<Berita> {
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text(
            //   "Cari Berita",
            //   style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 14.0,
            //       fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(
            //   height: 8.0,
            // ),
            TextField(
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 204, 202, 202),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Cari Berita",
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: Colors.blue.shade900,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: FutureBuilder<List<BeritaModel>>(
                future: daftarBerita,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(
                          snapshot.data[index].title,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          // removeAllHtmlTags(snapshot.data[index]['content']),
                          "By " + snapshot.data[index].author,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => DetailBerita(
                                      id: snapshot.data[index].id,
                                      publishedAt:
                                          snapshot.data[index].publishedAt,
                                      title: snapshot.data[index].title,
                                      content: snapshot.data[index].content,
                                      image: snapshot.data[index].image,
                                      author: snapshot.data[index].author,
                                      tags: snapshot.data[index].tag)));
                        },
                        // trailing: Text(
                        //   getCustomFormattedDateTime(
                        //       snapshot.data[index]['created_at'], "MM/dd/yyyy"),
                        //   style: TextStyle(color: Colors.amber),
                        // ),
                        // leading: Image.network("https://bpkad.ntbprov.go.id/" +
                        //     snapshot.data[index].image),
                        leading: Image(
                            image: AssetImage('assets/images/newsfeed.png')),
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
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
