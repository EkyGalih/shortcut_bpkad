import 'package:flutter/material.dart';
import 'package:instabpkad/api/berita_api.dart';
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
      body: Container(
          height: 230,
          child: FutureBuilder<List<BeritaModel>>(
            future: daftarBerita,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  separatorBuilder: (context, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.blue,
                        child: Column(
                          children: [
                            Image.network(
                                "https://bpkad.ntbprov.go.id/uploads/berita/berita-6b035225d5119410048a5933089e527d.jpeg"),
                            Text(snapshot.data.title)
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )),
    );
  }
}
