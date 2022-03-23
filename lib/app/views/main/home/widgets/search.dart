import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(width: 0, color: Colors.transparent)),
        label: const Text("Search any products"),
        prefixIcon: Image.asset("assets/icons/search.png"),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: const Color.fromARGB(255, 230, 230, 230),
        filled: true,
        isDense: true,
        contentPadding: const EdgeInsets.all(10),
      ),
    );
  }
}
