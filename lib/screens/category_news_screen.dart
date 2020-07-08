import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news/services/news_api.dart';
import 'package:news/widgets/news_tile.dart';

class CategoryNewsScreen extends StatefulWidget {
  final String newsCategory;
  final String category;

  CategoryNewsScreen({this.newsCategory, this.category});
  @override
  _CategoryNewsScreenState createState() => _CategoryNewsScreenState();
}

class _CategoryNewsScreenState extends State<CategoryNewsScreen> {
  bool _loading;
  var newsList;

  void getNews() async {
    CategoryNewsApi news = CategoryNewsApi();
    await news.getCategoryNews(widget.newsCategory);
    newsList = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            widget.category,
            style: TextStyle(fontSize: 25),
          ),
          elevation: 0.0,
        ),
        body: _loading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  SizedBox(
                    height: 10,
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

class CategoryCard extends StatelessWidget {
  final String imgUrl, categoryName;

  CategoryCard({this.imgUrl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Container(
          height: 300,
          width: 180,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.black38, borderRadius: BorderRadius.circular(10)),
          child: Text(
            categoryName,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: imgUrl,
            height: 300,
            width: 180,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
