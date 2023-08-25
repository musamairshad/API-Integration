import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api_integration/models/photo.dart';

class PhotosScreen extends StatelessWidget {
  PhotosScreen({super.key});

  final List<Photo> photos = [];
  Future<List<Photo>> fetchPhotos() async {
    final url = Uri.https('jsonplaceholder.typicode.com', '/photos');
    final response = await http.get(url);
    final resData = json.decode(response.body);

    if (response.statusCode == 200) {
      for (Map i in resData) {
        Photo photo = Photo(id: i['id'], title: i['title'], url: i['url']);
        photos.add(photo);
      }
      return photos;
    } else {
      return photos;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
              future: fetchPhotos(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return RefreshIndicator(
                  onRefresh: fetchPhotos,
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (ctx, index) {
                        return ListTile(
                          title: Text("Notes id: ${snapshot.data![index].id}"),
                          subtitle: Text(snapshot.data![index].title),
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(snapshot.data![index].url),
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
