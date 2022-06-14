import 'package:flutter/material.dart';
import 'package:project/app/constant/color.dart';

import '../../constant/glow.dart';

class requestSeller extends StatefulWidget {
  const requestSeller({Key? key}) : super(key: key);

  @override
  State<requestSeller> createState() => _requestSellerState();
}

class _requestSellerState extends State<requestSeller> {

  late TextEditingController _storeName;
  late TextEditingController _storeLocation;
  late TextEditingController _storeOpen;
  late TextEditingController _storeClose;

  @override
  void initState() {
    _storeName = TextEditingController();
    _storeLocation = TextEditingController();
    _storeOpen = TextEditingController();
    _storeClose = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _storeName.dispose();
    _storeClose.dispose();
    _storeLocation.dispose();
    _storeOpen.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: NoGlow(),
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              title: Text(
                "Request To Be A Seller",
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: ListView(children: [
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.height * 0.05,
                    30,
                    MediaQuery.of(context).size.height * 0.05,
                    0),
                child: TextField(
                  controller: _storeName,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.store),
                    labelText: "Nama Toko",
                    hintText: "Red Bakery",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.height * 0.05,
                    30,
                    MediaQuery.of(context).size.height * 0.05,
                    0),
                child: TextField(
                  controller: _storeLocation,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                    labelText: "Alamat",
                    hintText: "Jl. Diponegoro No.47, Tembaan, Kepatihan, Kec. Kaliwates, Kabupaten Jember, Jawa Timur 68131",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.height * 0.05,
                    30,
                    MediaQuery.of(context).size.height * 0.05,
                    0),
                child: TextField(
                  controller: _storeOpen,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.door_front_door),
                    labelText: "Buka",
                    hintText: "9am",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.height * 0.05,
                    30,
                    MediaQuery.of(context).size.height * 0.05,
                    0),
                child: TextField(
                  controller: _storeClose,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.close),
                    labelText: "Tutup",
                    hintText: "9pm",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              Container(
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height * 0.05,
                  50,
                  MediaQuery.of(context).size.height * 0.05,
                  30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: MyColor.yellow,
                  padding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {
                  final isValid = validator(context);
                  if (isValid) {
                  }
                },
                child: const Text("Confirm",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
              ),
            ),
            ])));
  }
  bool validator(BuildContext context) {
    if (_storeName.text.isEmpty) {
      snackBar(context, 'Username Tidak Boleh Kosong');
      return false;
    } else if (_storeClose.text.isEmpty) {
      snackBar(context, 'Email Tidak Boleh Kosong');
      return false;
    } else if (_storeLocation.text.isEmpty) {
      snackBar(context, 'Password Tidak Boleh Kosong');
      return false;
    } else if (_storeOpen.text.isEmpty) {
      snackBar(context, 'Konfirmasi Password Tidak Boleh Kosong');
      return false;
    }return true;
  }

  void snackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
