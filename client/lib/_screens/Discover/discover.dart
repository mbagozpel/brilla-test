import 'package:flutter/material.dart';

class Discover extends StatelessWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Discover',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
