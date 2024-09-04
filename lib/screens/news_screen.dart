import 'package:flutter/material.dart';
import 'package:news_app/providers/article_provider.dart';
import 'package:news_app/providers/category_provider.dart';
import 'package:news_app/screens/Auth/registration_page.dart';
import 'package:provider/provider.dart';

import 'news_list.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final articleProvider = Provider.of<ArticleProvider>(context);
    List<String> category = [
      "Trending",
      "World",
      "Entertainment",
      "Sports",
      "Business",
      "Other"
    ];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('News',
                  style: TextStyle(
                    color: Colors.white,
                  )),
              IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrationPage()));
                },
              ),
            ],
          ),
          SizedBox(
            height: 55,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: category.length,
                itemBuilder: (BuildContext context, int index) {
                  final c = category[index];
                  final selectedCategory = categoryProvider.category;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      disabledColor: Colors.transparent,
                      selectedColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36)),
                      label: Text(
                        c,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                      selected: selectedCategory == category[index],
                      onSelected: (_) {
                        categoryProvider.setCategory(category[index]);
                        articleProvider.findArticleByCategory(category[index]);
                        articleProvider.setCategoryIndex(index);
                      },
                    ),
                  );
                }),
          ),
          const NewsList(),
        ],
      ),
    );
  }
}
