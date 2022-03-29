import 'package:flutter/material.dart';

import '../../../../constant/color.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(width: 0, color: Colors.transparent),
          ),
          label: const Text("Search any products"),
          prefixIcon: Image.asset("assets/icons/search.png"),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: MyColor.grey3,
          filled: true,
          isDense: true,
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
