import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/components.dart';

class ProductDescription extends StatelessWidget {
  String description;
  ProductDescription(this.description);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: back(context),
        title: Text(
          'Description',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            color: Colors.white,
            width: double.infinity,
            padding: EdgeInsets.all(5.0),
            child: Text(
              '${description}',
            ),
          ),
        ),
      ),
    );
  }
}