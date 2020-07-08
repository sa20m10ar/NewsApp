import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news/services/news_api.dart';
import 'package:news/widgets/categories_list.dart';
import '../widgets/news_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading;
  var newsList;
  Timer timer;

  @override
  void initState() {
    _loading = true;
    super.initState();
    timer = Timer.periodic(Duration(seconds: 10), (Timer t) => getNews());

  }

  void getNews() async {
    NewsApi news = NewsApi();
    await news.getNews();
    newsList = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _loading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'الأقسام',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  //Category
                  CategoriesListView(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'آخر الأخبار',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 1),
                    child: ListView.builder(
                      itemCount: newsList.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: NewsTile(
                              articleUrl: newsList[index].articleUrl,
                              title: newsList[index].title,
                              subtitle: newsList[index].description,
                              imgUrl: newsList[index].imgUrl,
                            ));
                      },
                    ),
                  ),
                ],
              ));
  }
}
