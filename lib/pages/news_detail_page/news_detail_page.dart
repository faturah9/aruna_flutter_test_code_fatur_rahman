import 'package:arunafluttertestcodefatur/datas/models/news_model.dart';
import 'package:flutter/material.dart';

class NewsDetailPage extends StatefulWidget {
  final Map<String, dynamic> arguments;
  const NewsDetailPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    NewsModel title = widget.arguments.values.first;

    return Scaffold(
      appBar: AppBar(
        title: const Text('News Detail'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    title.title!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    title.body!,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
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
