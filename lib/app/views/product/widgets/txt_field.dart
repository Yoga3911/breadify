import 'package:flutter/material.dart';
import 'package:project/app/view_model/product_provider.dart';
import 'package:provider/provider.dart';

import '../../../constant/color.dart';

class MyTxtField extends StatefulWidget {
  const MyTxtField({
    Key? key,
    required this.icon,
    required this.controller,
    required this.hint,
    required this.isNum,
    this.name = "",
    this.price = 0,
    this.quantity = 0,
  }) : super(key: key);
  final String icon;
  final TextEditingController controller;
  final String hint;
  final bool isNum;
  final String name;
  final int price;
  final int quantity;

  @override
  State<MyTxtField> createState() => _MyTxtFieldState();
}

class _MyTxtFieldState extends State<MyTxtField> {
  final FocusNode _focus = FocusNode();
  Color _color = Colors.black;
  bool _isFloating = false;
  bool isError = false;
  @override
  void initState() {
    (widget.name != "")? widget.controller.text = widget.name : null;
    (widget.price != 0)? widget.controller.text = widget.price.toString() : null;
    (widget.quantity != 0)? widget.controller.text = widget.quantity.toString(): null;
    _focus.addListener(
      () => setState(
        () {
          if (widget.controller.text.isEmpty) {
            isError = true;
          } else if (widget.controller.text.isNotEmpty) {
            isError = false;
          }
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
    final product = Provider.of<ProductProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        onChanged: (val) {
          if (widget.controller.text.isEmpty) {
            isError = true;
            product.isError = true;
          } else {
            isError = false;
            product.isError = false;
          }
          setState(() {});
        },
        controller: widget.controller,
        focusNode: _focus,
        keyboardType: widget.isNum ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          errorText: isError ? "Data tidak boleh kosong" : null,
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
