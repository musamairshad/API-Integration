import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api_integration/models/user.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({super.key});

  final List<User> users = [];
  var resData;
  Future<List<User>> fetchUsers() async {
    final url = Uri.https('jsonplaceholder.typicode.com', '/users');
    final response = await http.get(url);
    resData = json.decode(response.body);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in resData) {
        users.add(User.fromJson(i));
      }
      return users;
    } else {
      return users;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
              future: fetchUsers(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (ctx, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            snapshot.data![index].name.toString(),
                          ),
                          // subtitle: Text(
                          //   snapshot.data![index].email.toString(),
                          // ),
                          // subtitle:
                          //     Text(resData[index]['address']['geo']['lat']),
                          subtitle: Text(resData[index]['email']),
                          trailing: const Icon(Icons.person),
                        ),
                      );
                    });
              }),
        )
      ],
    );
  }
}
