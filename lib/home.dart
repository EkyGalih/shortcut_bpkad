// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
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
  final scrollController = ScrollController();
  bool isloadingMore = false;
  List daftarBerita = [];
  int page = 1;
  late double scrollmark;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    fetchBerita();

    // fab
    fab = FloatingActionButton(
      child: const Icon(Icons.arrow_upward),
      onPressed: () {
        scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
    );

    // scroll listener for fab
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          reversing = true;
        });
      } else {
        setState(() {
          reversing = false;
        });
      }
    });
  }

  // get data
  Future<void> fetchBerita() async {
    final url = 'https://bpkad.ntbprov.go.id/api/berita?page=$page';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body)['data']['data'] as List;
      setState(() {
        daftarBerita = daftarBerita + json;
      });
    } else {
      print('Unexpected response');
    }
  }

  // scrolling load function
  Future<void> _scrollListener() async {
    if (isloadingMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isloadingMore = true;
      });
      page = page + 1;
      await fetchBerita();
      setState(() {
        isloadingMore = false;
      });
    }
  }

  // bact to top
  bool reversing = false;
  late FloatingActionButton fab;

  FloatingActionButton? getFab() {
    if (reversing && scrollController.position.pixels > 0.0) {
      return fab;
    }
    return null;
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
      floatingActionButton: getFab(),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(
            const Duration(seconds: 1),
          );
          daftarBerita = daftarBerita;
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
          controller: scrollController,
          itemCount:
              isloadingMore ? daftarBerita.length + 1 : daftarBerita.length,
          itemBuilder: (BuildContext context, int index) {
            if (index < daftarBerita.length) {
              final berita = daftarBerita[index];
              final id = berita['id'];
              final author = berita['author'];
              final title = berita['title'];
              final content = berita['content'];
              final image = berita['foto_berita'];
              final tags = berita['tags'];
              final publishedAt = berita['created_at'];
              final avatar = berita['avatar'];
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
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://bpkad.ntbprov.go.id/$avatar")),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(48)),
                                  color: Colors.blue,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(author),
                              ),
                              Icon(
                                Icons.circle,
                                size: 5,
                                color: Colors.grey.shade400,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(getCustomFormattedDateTime(
                                    publishedAt, 'dd MM yyyy')),
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
                                "https://bpkad.ntbprov.go.id/$image"),
                            height: 250,
                            fit: BoxFit.fill,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (c) => DetailBerita(
                                        id: id,
                                        publishedAt: publishedAt,
                                        title: title,
                                        content: content,
                                        image: image,
                                        author: author,
                                        tags: tags),
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
                                icon: const Icon(Icons.insert_comment_outlined),
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
                        padding: const EdgeInsets.all(6).copyWith(bottom: 5),
                        child: ReadMoreText(
                          removeAllHtmlTags(content),
                          trimLines: 2,
                          colorClickableText: Colors.blue,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: " Selengkapnya",
                          trimExpandedText: " Show less",
                          style: const TextStyle(color: Colors.black),
                          moreStyle: const TextStyle(fontSize: 14),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: Text("Lihat Semua 50 Komentar"),
                        ),
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(6),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: 270,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: 'Tambahkan Komentar',
                                    contentPadding:
                                        EdgeInsetsDirectional.symmetric(
                                      vertical: 2,
                                    ),
                                  ),
                                  maxLines: 2,
                                  minLines: 1,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.send),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
