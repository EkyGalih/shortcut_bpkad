// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';

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
                    child: Image.network(
                        'https://bpkad.ntbprov.go.id/upload/mobile/newsfeed.png'),
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
                    GetTimeAgo.parse(
                      DateTime.parse(publishedAt),
                      pattern: "dd-MM-yyyy hh:mm aa",
                      locale: 'id',
                    ),
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
