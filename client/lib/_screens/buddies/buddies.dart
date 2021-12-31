import 'package:flutter/material.dart';

class Buddies extends StatelessWidget {
  const Buddies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Hi buddy',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
