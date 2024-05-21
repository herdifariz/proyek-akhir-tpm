import 'package:flutter/material.dart';

class WishlistItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 150,
              height: 150,
              alignment: Alignment.centerLeft,
              child: Image.network(
                'https://media.discordapp.net/attachments/480720671274696739/1241811686558535774/gracia1.jpg?ex=664d8901&is=664c3781&hm=5ea384e44f17d5a6983ecfa5daf85882b360a22e9bf8a0092010fc72a08a4211&=&format=webp&width=936&height=936',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Name',
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Product Price',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  IconButton(
                    icon: Icon(Icons.favorite, color: Colors.deepPurple),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
