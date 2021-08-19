import 'package:flutter/material.dart';

class CategoryMealScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The Recipies'),
      ),
      body: Center(
        child: Text('Recipies of Category'),
      ),
    );
  }
}
