import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api_integration/models/post.dart';

class PostsScreen extends StatelessWidget {
  PostsScreen({super.key});

  final List<Post> posts = [];
  Future<List<Post>> fetchPosts() async {
    final url = Uri.https('jsonplaceholder.typicode.com', '/posts');
    final response = await http.get(url);
    final resData = json.decode(response.body);
    if (response.statusCode == 200) {
      posts.clear();
      for (Map i in resData) {
        posts.add(Post.fromJson(i));
      }
      return posts;
    } else {
      return posts;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
              future: fetchPosts(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return RefreshIndicator(
                  onRefresh: fetchPosts,
                  child: ListView.builder(
                      // itemCount: snapshot.data!.length,
                      itemCount: posts.length,
                      itemBuilder: (ctx, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Title",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  snapshot.data![index].title.toString(),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "Description",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  snapshot.data![index].body.toString(),
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              }),
        )
      ],
    );
  }
}
