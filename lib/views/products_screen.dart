import 'package:flutter/material.dart';
import 'package:api_integration/data/products_data.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (ctx, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(products['data'][index]['shop']['name']),
                      subtitle:
                          Text(products['data'][index]['shop']['shopemail']),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            products['data'][index]['shop']['image']),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 1,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: (products['data'][index]['images'] as List)
                              .length,
                          itemBuilder: (ctx, ind) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      products['data'][index]['images'][ind]
                                          ['url'],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Icon(products['data'][index]['in_wishlist']
                        ? Icons.favorite
                        : Icons.favorite_border),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
