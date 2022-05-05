// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ShowImageNetWork extends StatelessWidget {
  final String path;
  const ShowImageNetWork({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(path);
  }
}
