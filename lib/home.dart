import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instabpkad/api/berita_api.dart';
import 'package:instabpkad/berita/detail_berita.dart';
import 'package:instabpkad/model/berita/berita_model.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
    // BeritaService().getBerita().then((value) => print("value: $value"));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder<List<BeritaModel>>(
        future: daftarBerita,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(
                  const Duration(seconds: 1),
                );
                data = BeritaService().getBerita();
                setState(() {});
              },
              color: Colors.white,
              backgroundColor: Colors.blueAccent,
              child: GridView.builder(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                  bottom: 1,
                  top: 1,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 1,
                  childAspectRatio: 8 / 12,
                ),
                itemCount: data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return SingleChildScrollView(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "https://bpkad.ntbprov.go.id/${data?[index].avatar}")),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(48)),
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(data?[index].author),
                                  ),
                                  Icon(
                                    Icons.circle,
                                    size: 5,
                                    color: Colors.grey.shade400,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(getCustomFormattedDateTime(
                                        data?[index].publishedAt,
                                        'dd MM yyyy')),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Ink.image(
                                image: NetworkImage(
                                    "https://bpkad.ntbprov.go.id/${data[index].image}"),
                                height: 300,
                                fit: BoxFit.fill,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (c) => DetailBerita(
                                            id: data?[index].id,
                                            publishedAt:
                                                data?[index].publishedAt,
                                            title: data?[index].title,
                                            content: data?[index].content,
                                            image: data?[index].image,
                                            author: data?[index].author,
                                            tags: data?[index].tag),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.heart_broken),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        Icons.insert_comment_outlined),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.send_outlined),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 8, bottom: 4),
                              child: Text("64.503 suka"),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Padding(
                            padding:
                                const EdgeInsets.all(6).copyWith(bottom: 5),
                            child: ReadMoreText(
                              removeAllHtmlTags(data[index].content),
                              trimLines: 2,
                              colorClickableText: Colors.blue,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: " Selengkapnya",
                              trimExpandedText: " Show less",
                              style: const TextStyle(color: Colors.black),
                              moreStyle: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
