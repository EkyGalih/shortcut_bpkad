import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailBerita extends StatelessWidget {
  final id;
  final image;
  final title;
  final content;
  final author;
  final publishedAt;
  final tags;

  const DetailBerita(
      {super.key,
      this.id = 0,
      this.image,
      this.title,
      this.content,
      this.author,
      this.publishedAt,
      this.tags});

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
                ? Image.network("https://bpkad.ntbprov.go.id/$image")
                : SizedBox(
                    height: 250,
                    child: Image.asset('assets/images/newsfeed.png'),
                  ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    getCustomFormattedDateTime(publishedAt, 'MM/dd/yyyy'),
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  Text('By  $author',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic)),
                  const Divider(),
                  const SizedBox(height: 5),
                  Text(removeAllHtmlTags(content)),
                  const Divider(),
                  Text(
                    tags ?? "-",
                    style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
