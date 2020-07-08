

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';
import '../screens/category_news_screen.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesList.categories.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CategoryCard(
              imgUrl:
              categoriesList.categories[index].imageAssetUrl,
              categoryName:
              categoriesList.categories[index].categoryName,
            ),
          );
        },
      ),
    );
  }
}


class CategoryCard extends StatelessWidget {
  final String imgUrl, categoryName;

  CategoryCard({this.imgUrl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNewsScreen(
                  category: categoryName,
                  newsCategory: categoryName.toLowerCase(),
                )));
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: imgUrl,
              height: 300,
              width: 180,
              fit: BoxFit.cover,
            ),
          ),
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
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}