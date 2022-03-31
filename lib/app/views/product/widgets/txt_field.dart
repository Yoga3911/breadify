import 'package:flutter/material.dart';

import '../../../constant/color.dart';

class MyTxtField extends StatefulWidget {
  const MyTxtField({Key? key, required this.icon, required this.controller, required this.hint})
      : super(key: key);
  final String icon;
  final TextEditingController controller;
  final String hint;

  @override
  State<MyTxtField> createState() => _MyTxtFieldState();
}

class _MyTxtFieldState extends State<MyTxtField> {
  final FocusNode _focus = FocusNode();
  Color _color = Colors.black;
  bool _isFloating = false;
  @override
  void initState() {
    _focus.addListener(
      () => setState(
        () {
          _color = _focus.hasFocus ? MyColor.yellow : Colors.black;
          _isFloating =
              _focus.hasFocus ? _isFloating = true : _isFloating = false;
        },
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: widget.controller,
        focusNode: _focus,
        decoration: InputDecoration(
          label: Text(widget.hint),
          floatingLabelBehavior: _isFloating
            ? FloatingLabelBehavior.auto
            : FloatingLabelBehavior.never,
          hintText: widget.hint,
          prefixIcon: Image.asset(
            widget.icon,
            color: _color,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: MyColor.yellow, width: 2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: MyColor.yellow, width: 3),
          ),
        ),
      ),
    );
  }
}
