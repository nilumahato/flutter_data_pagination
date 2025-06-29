import 'package:flutter/material.dart';
import 'package:flutter_pagination/controller/pagination_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PostProvider postProvider;

  @override
  void initState() {
    super.initState();
    postProvider = PostProvider();
  }

  @override
  void dispose() {
    postProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pagination')),
      body: ChangeNotifierProvider<PostProvider>(
        create: (context) => postProvider,
        child: Consumer<PostProvider>(
          builder: (context, provider, child) {
            return NotificationListener(
              //adding pagination
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    !postProvider.isLoading) {
                  postProvider.fetchPosts();
                }
                return false;
              },

              child: ListView.builder(
                itemCount:
                    provider.posts.length + (postProvider.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= provider.posts.length) {
                    // Show a loading indicator at the end
                    return const Center(child: CircularProgressIndicator());
                  }
                  final post = provider.posts[index];
                  return Card(
                    child: ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.body),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
