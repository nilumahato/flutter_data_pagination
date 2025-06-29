import 'package:flutter/material.dart';
import 'package:flutter_pagination/controller/pagination_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<PostProvider>(context, listen: false).fetchPosts();
      });
      _isInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pagination')),
      body: Consumer<PostProvider>(
        builder: (context, provider, child) {
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent &&
                  !provider.isLoading &&
                  provider.hasMore) {
                provider.fetchPosts();
              }
              return false;
            },
            child: ListView.builder(
              itemCount: provider.posts.length + (provider.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < provider.posts.length) {
                  final post = provider.posts[index];
                  return Card(
                    child: ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.body),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          );
        },
      ),
    );
  }
}
