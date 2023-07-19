import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailBerita extends StatelessWidget {
  final id;
  final image;
  final title;
  final content;
  final author;
  final publishedAt;

  DetailBerita({
    this.id = 0,
    this.image,
    this.title,
    this.content,
    this.author,
    this.publishedAt,
  });

  // hapus tag html pada tulisan content
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
        title: const Text("Detail Berita"),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            image != null
                ? Image.network("https://bpkad.ntbprov.go.id/" + image)
                : Container(
                    height: 250,
                    color: Colors.grey[200],
                  ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    getCustomFormattedDateTime(publishedAt, 'MM/dd/yyyy'),
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  Divider(),
                  SizedBox(height: 5),
                  Text(removeAllHtmlTags(content)),
                  Divider(),
                  Text('Author :' + author),
                  Text('Sumber : bpkad.ntbprov.go.id/berita/detail/' + id),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
