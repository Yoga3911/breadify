import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/app/constant/collection.dart';
import 'package:project/app/models/store_model.dart';
import 'package:project/app/routes/route.dart';
import 'package:project/app/view_model/store_provider.dart';
import 'package:project/app/views/product/widgets/txt_field2.dart';
import 'package:project/app/widgets/custom_loading.dart';
import 'package:provider/provider.dart';

class EditStore extends StatefulWidget {
  const EditStore({Key? key}) : super(key: key);

  @override
  State<EditStore> createState() => _EditStoreState();
}

class _EditStoreState extends State<EditStore> {
  late TextEditingController storeName;
  late TextEditingController address;
  late TextEditingController open;
  late TextEditingController close;

  @override
  void initState() {
    storeName = TextEditingController();
    address = TextEditingController();
    open = TextEditingController();
    close = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    storeName.dispose();
    address.dispose();
    open.dispose();
    close.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update Store",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Material(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder<DocumentSnapshot>(
            future: MyCollection.store.doc(args["store_id"]).get(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final data = StoreModel.fromJson(
                  snapshot.data!.data() as Map<String, dynamic>);
              return ListView(
                children: [
                  const SizedBox(height: 10),
                  const Text("Store Name"),
                  MyTxtField2(
                    icon: Icons.store,
                    controller: storeName,
                    hint: "Store name",
                    isNum: false,
                    name: data.storeName,
                  ),
                  const Text("Address"),
                  MyTxtField2(
                    icon: Icons.location_on,
                    controller: address,
                    hint: "Address",
                    isNum: false,
                    name: data.address,
                  ),
                  const Text("Open"),
                  MyTxtField2(
                    icon: Icons.timelapse_outlined,
                    controller: open,
                    hint: "Open",
                    isNum: false,
                    name: data.open,
                  ),
                  const Text("Close"),
                  MyTxtField2(
                    icon: Icons.timelapse_outlined,
                    controller: close,
                    hint: "Close",
                    isNum: false,
                    name: data.close,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => const CustomLoading(),
                      );
                      context
                          .read<StoreProvider>()
                          .updateStore(
                            storeId: args["store_id"],
                            storeName: storeName.text,
                            address: address.text,
                            open: open.text,
                            close: close.text,
                          )
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Data toko berhasil diperbarui"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.main,
                          (_) => false,
                        );
                      });
                    },
                    child: const Text(
                      "Simpan",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}