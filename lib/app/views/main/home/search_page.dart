import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/app/models/product_model.dart';
import 'package:project/app/routes/route.dart';
import 'package:project/app/view_model/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<ProductModel> dataFilter = [];
  List<ProductModel> dataSaved = [];

  filter(String key, List<ProductModel> product) {
    dataFilter = product
        .where((element) => element.name.toLowerCase().contains(key))
        .toList();
  }

  bool isSearch = false;

  @override
  void didChangeDependencies() async {
    final pref = await SharedPreferences.getInstance();
    final product = Provider.of<ProductProvider>(context, listen: false);
    if (pref.getStringList("history") != null) {
      for (String item in pref.getStringList("history")!.toList()) {
        dataFilter.addAll(
          product.getAllProduct.where(
            (e) {
              return e.name.contains(item);
            },
          ),
        );
      }
      dataSaved = dataFilter;
      setState(() {});
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 20,
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              _controller.clear();
              dataFilter = [];
              final pref = await SharedPreferences.getInstance();
              final product =
                  Provider.of<ProductProvider>(context, listen: false);
              if (pref.getStringList("history") != null) {
                for (String item in pref.getStringList("history")!.toList()) {
                  dataFilter.addAll(
                    product.getAllProduct.where(
                      (e) {
                        return e.name.contains(item);
                      },
                    ),
                  );
                }
                dataSaved = dataFilter;
                setState(() {});
              }
            },
            icon: const Icon(Icons.clear_rounded),
            color: Colors.white,
            splashRadius: 20,
          )
        ],
        title: TextField(
          controller: _controller,
          autofocus: true,
          onChanged: (val) async {
            filter(val, product.getAllProduct);
            if (_controller.text.isEmpty) {
              dataFilter = [];
              final pref = await SharedPreferences.getInstance();
              final product =
                  Provider.of<ProductProvider>(context, listen: false);
              if (pref.getStringList("history") != null) {
                for (String item in pref.getStringList("history")!.toList()) {
                  dataFilter.addAll(
                    product.getAllProduct.where(
                      (e) {
                        return e.name.contains(item);
                      },
                    ),
                  );
                }
                dataSaved = dataFilter;
                setState(() {});
              }
            }
            setState(() {});
          },
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: dataFilter.length,
        itemBuilder: (_, index) {
          final prod = dataFilter[index];
          final queryText =
              dataFilter[index].name.substring(0, _controller.text.length);
          final remainingText =
              dataFilter[index].name.substring(_controller.text.length);
          return ListTile(
            leading: CircleAvatar(
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: prod.image,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  // fit: BoxFit.cover,
                ),
              ),
            ),
            trailing: _controller.text.isEmpty
                ? const Icon(Icons.history)
                : const Icon(Icons.arrow_forward_ios_rounded),
            title: Text.rich(
              TextSpan(
                text: queryText,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: remainingText,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            onTap: () async {
              final pref = await SharedPreferences.getInstance();
              if (pref.getStringList("history") != null) {
                final temp = pref.getStringList("history");
                int i = 0;
                for (var item in temp!.toList()) {
                  if (dataFilter[index].name == item) {
                    i++;
                  }
                }
                if (i == 0) {
                  pref.setStringList("history", [
                    dataFilter[index].name,
                    ...temp,
                  ]);
                  i = 0;
                }
              } else if (pref.getStringList("history") == null) {
                pref.setStringList(
                  "history",
                  [
                    dataFilter[index].name,
                  ],
                );
              }
              Navigator.pushNamed(
                context,
                Routes.product,
                arguments: {
                  "id": dataFilter[index].id,
                  "name": dataFilter[index].name,
                  "price": dataFilter[index].price,
                  "quantity": dataFilter[index].quantity,
                  "image": dataFilter[index].image,
                  "product": dataFilter[index],
                  "store_id": dataFilter[index].storeId
                },
              );
            },
          );
        },
      ),
    );
  }
}
