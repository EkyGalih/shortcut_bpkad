import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instabpkad/api/berita_api.dart';
import 'package:instabpkad/berita/detail_berita.dart';
import 'package:instabpkad/model/berita/berita_model.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  late Future<List<BeritaModel>> carouselBerita;
  late final PageController pageController;
  int pageNo = 0;

  Timer? caraouselTimer;

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageNo == 4) {
        pageNo = 0;
      }
      if (pageController.hasClients) {
        pageController.animateToPage(
          pageNo,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOutCirc,
        );
      }
      pageNo++;
    });
  }

  @override
  void initState() {
    carouselBerita = BeritaService().getBerita();
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    caraouselTimer = getTimer();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
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
    BeritaService().getBerita().then((value) => print("value: $value"));
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 200,
              child: FutureBuilder<List<BeritaModel>>(
                  future: carouselBerita,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return PageView.builder(
                      controller: pageController,
                      onPageChanged: (idx) {
                        pageNo = idx;
                        setState(() {});
                      },
                      itemBuilder: (context, index) {
                        return AnimatedBuilder(
                          animation: pageController,
                          builder: (ctx, child) {
                            return child!;
                          },
                          child: GestureDetector(
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
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   SnackBar(
                              //     content:
                              //         Text("${snapshot.data[index].title}"),
                              //   ),
                              // );
                            },
                            // onPanDown: (d) {
                            //   caraouselTimer?.cancel();
                            //   caraouselTimer = null;
                            // },
                            // onPanCancel: () {
                            //   caraouselTimer = getTimer();
                            // },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  right: 8, left: 8, top: 1, bottom: 5),
                              // height: 180,
                              child: Image.network(
                                "https://bpkad.ntbprov.go.id/uploads/berita/berita-6820d13b719c973b854eb810e9e00a7f.jpeg",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: 5,
                    );
                  }),
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => Container(
                  margin: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.circle,
                    size: 12.0,
                    color: pageNo == index
                        ? Colors.indigoAccent
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
