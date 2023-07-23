import 'dart:async';

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
  late final PageController pageController;
  int pageNo = 0;

  Timer? caraouselTimer;

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageNo == 4) {
        pageNo = 0;
      }
      pageController.animateToPage(
        pageNo,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCirc,
      );
      pageNo++;
    });
  }

  @override
  void initState() {
    daftarBerita = BeritaService().getBerita();
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
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) {
                  pageNo = index;
                  setState(() {});
                },
                itemBuilder: (_, index) {
                  return AnimatedBuilder(
                    animation: pageController,
                    builder: (ctx, child) {
                      return child!;
                    },
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("hallo anda menekan ${index + 1}"),
                          ),
                        );
                      },
                      onPanDown: (d) {
                        caraouselTimer?.cancel();
                        caraouselTimer = null;
                      },
                      onPanCancel: () {
                        caraouselTimer = getTimer();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            right: 8, left: 8, top: 1, bottom: 5),
                        // height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: Colors.amberAccent,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: 5,
              ),
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
