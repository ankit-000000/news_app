import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/providers/article_provider.dart';
import 'package:news_app/screens/widgets/news_card.dart';
import 'package:provider/provider.dart';

import '../model/article.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    ArticleProvider provider = Provider.of<ArticleProvider>(context);
    List<Article> articles = List.from(provider.articles);
    return SizedBox(
      height: screenSize.height * 0.6,
      child: CarouselSlider.builder(
        itemCount: articles.length,
        itemBuilder: (BuildContext context, int index, _) {
          Article article = articles[index];
          return NewsCard(
            article: article,
            index: index + 20,
          );
        },
        options: CarouselOptions(
            initialPage: 0,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            height: screenSize.height * 0.6,
            scrollDirection: Axis.horizontal),
      ),
    );
  }
}
