import 'package:flutter/material.dart';
import '../model/post_model.dart';
import '../repository/post_repository.dart';

class PostProvider with ChangeNotifier {
  // Repository instance
  final _postRepo = PostRepository();

  // List to hold fetched posts
  final List<PostModel> _posts = [];

  // Pagination state
  bool _isLoading = false;

  // Flag to check if there are more posts to load
  bool _hasMore = true;

  // Current page and limit for pagination
  int _page = 1;
  final int _limit = 10;

  // Getters for posts and loading state
  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  // Method to reset pagination
  Future<void> fetchPosts() async {
    if (_isLoading || !_hasMore) return; // Prevent multiple requests
    _isLoading = true;
    notifyListeners();

    try {
      List<PostModel> newPosts = await _postRepo.fetchPosts(_page, _limit);
      if (newPosts.isEmpty) {
        _hasMore = false;
      } else {
        _posts.addAll(newPosts);
        _page++; // Increment page for next fetch
      }
    } catch (e) {
      // Handle error
      print('Error fetching posts: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
