import 'package:flutter/material.dart';

class Banners extends StatelessWidget {
  const Banners({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index)
      {
        return Row(
          children: [
            CircleAvatar(
              child: Text('Hi'),
            )
          ],
        );
      },
    );
  }
}
