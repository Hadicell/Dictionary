import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const Dictionary());
}

class Dictionary extends StatefulWidget {
  const Dictionary({Key? key}) : super(key: key);

  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  var listDictionary;
  final txtSearch = TextEditingController();
  Future<dynamic> Dictionary(String text) async {
    var url = "http://hitaldev.ir/dictionary/search?word=$text";
    var dio = Dio();
    var response = await dio.get(url);
    final jsonResponse = json.decode(response.toString());
    listDictionary = jsonResponse;
    setState(() {});
    return jsonResponse;
  }

  FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Theme(
          data: ThemeData(fontFamily: "YekanBakh"),
          child: SafeArea(
            child: Scaffold(
              backgroundColor: const Color(0xff92008d),
              body: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(30),
                        ),
                        color: Color(0xffd0da56)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/dic.png",
                            width: 35,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "دیکشنری",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w900),
                          ),
                          const Spacer(),
                          const Text(
                            "Actev Novin",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: txtSearch,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      decoration: InputDecoration(
                        isDense: true,
                        fillColor: const Color(0xff9f2eb1),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 8),
                        hintText: "لطفا کلمه مورد نظر را وارد کنید...",
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xff9f2eb1), width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xff9f2eb1), width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Dictionary(txtSearch.text);
                          },
                          child: const Icon(
                            CupertinoIcons.search,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        hintStyle:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                  listDictionary == null || listDictionary["data"].isEmpty
                      ? const Center(
                          child: Text(
                            "موردی یافت نشد",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        )
                      : Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xffd0da56),
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListView.builder(
                                itemCount: listDictionary["data"].length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      listDictionary["data"]
                                                          [index]["word"],
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xff92008d),
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Text(
                                                      listDictionary["data"]
                                                          [index]["meaning"],
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              await flutterTts.speak(
                                                  listDictionary["data"][index]
                                                      ["word"]);
                                            },
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff92008d),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: const Center(
                                                  child: Icon(
                                                Icons.mic_none_sharp,
                                                color: Colors.white,
                                                size: 20,
                                              )),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
