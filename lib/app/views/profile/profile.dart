import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/app/constant/color.dart';
import 'package:project/app/constant/glow.dart';
import 'package:project/app/models/store_model.dart';
import 'package:project/app/routes/route.dart';
import 'package:project/app/utils/currency.dart';
import 'package:project/app/view_model/store_provider.dart';
import 'package:project/app/view_model/user_prodvider.dart';
import 'package:project/app/views/profile/change_profile.dart';
import 'package:project/app/views/profile/request_seller.dart';
import 'package:project/app/views/profile/top_up.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main/home/widgets/alert.dart';
import 'change_password.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isChecked = false;
  bool _isHidden = true;
  late TextEditingController pass;
  String? storeId;

  void getStoreId() async {
    final pref = await SharedPreferences.getInstance();
    storeId = pref.getString("store_id");
  }

  @override
  void initState() {
    pass = TextEditingController();
    getStoreId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;
    return ScrollConfiguration(
      behavior: NoGlow(),
      child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () => Navigator.pushNamed(context, Routes.main),
              child: Container(
                margin: const EdgeInsets.all(9),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)),
                child: const Icon(Icons.arrow_back_ios_new),
              ),
            ),
            title: const Text("Profile",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w900)),
            elevation: 0,
          ),
          body: ListView(
            children: [
              Column(children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: const BoxDecoration(color: MyColor.yellow),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                      ),
                      CircleAvatar(
                        radius: 40,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: user.imageUrl,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Container(
                        width: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Container(
                                width: 80,
                                height: 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white),
                                child: Center(
                                    child: Text((user.roleId == "1")
                                        ? "Customer"
                                        : "Seller"))),
                            Text("Saldo : Rp ${currency(user.bmoney)}",
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ChangeProfile(
                        name: user.name,
                        id: user.id,
                      );
                    })).then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: ListTile(
                      leading: Icon(
                        Icons.camera_alt_outlined,
                        size: 30,
                        color: Colors.yellow[600],
                      ),
                      title: const Text("Change Profile"),
                    ),
                  ),
                ),
                Container(
                  height: 5,
                ),
                (user.roleId == "1")
                    ? GestureDetector(
                        onTap: () => showDialog(
                            context: context,
                            builder: (context) => StatefulBuilder(
                                  builder: (context, setState) => AlertDialog(
                                    scrollable: true,
                                    content: Column(
                                      children: [
                                        rowRequest('1. ',
                                            'Produknya berkualitas dan selalu up to date.'),
                                        rowRequest('2. ',
                                            'Varian produknya banyak dan stok terjamin.'),
                                        rowRequest('3. ',
                                            'Harga jual yang ditentukan sesuai dengan kualitas dan sangat bersaing.'),
                                        rowRequest('4. ',
                                            'Minimal sudah menjalankan bisnis selama 1 tahun dan sudah memiliki banyak reseller.'),
                                        rowRequest('5. ',
                                            'Memberikan banyak kemudahan dalam menjalankan bisnis sebagai reseller, seperti menyediakan katalog online, program diskon khusus, bersedia menangani komplain pelanggan.'),
                                        rowRequest('6. ',
                                            'Memberikan informasi yang jujur mengenai kondisi produk, termasuk kelemahan dan kelebihannya.'),
                                        rowRequest('7. ',
                                            'Menjalin hubungan dengan pelanggan di luar urusan jual beli dan jalin komunikasi sebagai teman.'),
                                        rowRequest('8. ',
                                            'Menjawab setiap pertanyaan konsumen tentang produk dengan sabar dan sejelas-jelasnya karena konsumen hanya mengandalkan foto dan keterangan yang tercantum. Anda bisa mempelajari detail produk dari FAQ yang biasanya ada di website supplier.'),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Checkbox(
                                                value: isChecked,
                                                onChanged: (val) {
                                                  isChecked = !val!;
                                                  setState(() {
                                                    isChecked = !isChecked;
                                                  });
                                                }),
                                            const Text(
                                                'I Agree to the Terms Above')
                                          ],
                                        ),
                                        ElevatedButton(
                                            onPressed: (isChecked)
                                                ? () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return const RequestSeller();
                                                        },
                                                      ),
                                                    );
                                                  }
                                                : null,
                                            child: const Text(
                                              'Request',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))
                                      ],
                                    ),
                                  ),
                                )),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(color: Colors.grey[200]),
                          child: ListTile(
                            leading: Icon(
                              Icons.request_page_outlined,
                              size: 30,
                              color: Colors.yellow[600],
                            ),
                            title: const Text("Request To Be A Seller"),
                          ),
                        ),
                      )
                    : FutureBuilder<StoreModel>(
                        future: context
                            .read<StoreProvider>()
                            .getStoreById(user.storeId),
                        builder: (_, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox();
                          }
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.store,
                                arguments: {
                                  "seller_image": user.imageUrl,
                                  "id": snapshot.data!.id,
                                  "name": snapshot.data!.storeName,
                                  "address": snapshot.data!.address,
                                  "open": snapshot.data!.open,
                                  "close": snapshot.data!.close,
                                  "seller_id": snapshot.data!.userId,
                                },
                              );
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration:
                                  BoxDecoration(color: Colors.grey[200]),
                              child: ListTile(
                                leading: Icon(
                                  Icons.store_rounded,
                                  size: 30,
                                  color: Colors.yellow[600],
                                ),
                                title: const Text("My Store"),
                              ),
                            ),
                          );
                        }),
              ]),
              Container(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const TopUp();
                      },
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: ListTile(
                    leading: Icon(
                      Icons.attach_money,
                      size: 30,
                      color: Colors.yellow[600],
                    ),
                    title: const Text("Top Up"),
                  ),
                ),
              ),
              Container(
                height: 5,
                decoration: const BoxDecoration(color: Colors.white),
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: const ListTile(
                  title: Text("Settings"),
                ),
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(color: Colors.grey[800]),
              ),
              (user.provider == "email")
                  ? GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => StatefulBuilder(
                                builder: (context, setState) => AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Text('Password'),
                                      ),
                                      TextField(
                                        controller: pass,
                                        obscureText: _isHidden,
                                        decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.lock_outline,
                                              color: MyColor.yellow,
                                            ),
                                            suffixIcon: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _isHidden = !_isHidden;
                                                });
                                              },
                                              child: Icon(
                                                _isHidden
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                              ),
                                            ),
                                            prefixStyle: const TextStyle(
                                                color: Colors.blue),
                                            hintText: "Password",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  color: MyColor.yellow,
                                                ))),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<UserProvider>()
                                                .checkPassword(
                                                    userId: user.id,
                                                    password: pass.text)
                                                .then(
                                              (value) {
                                                pass.text = "";
                                                if (value) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return const ChangePassword();
                                                      },
                                                    ),
                                                  );
                                                  return;
                                                }
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        "Password tidak valid"),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: const Text('Confirm'))
                                    ],
                                  ),
                                ),
                              )),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: ListTile(
                          leading: Icon(
                            Icons.lock_outline_sharp,
                            size: 30,
                            color: Colors.yellow[600],
                          ),
                          title: const Text("Change Password"),
                        ),
                      ),
                    )
                  : const SizedBox(),
              (user.provider == "email")
                  ? Container(
                      height: 2,
                      decoration: BoxDecoration(color: Colors.grey[800]),
                    )
                  : const SizedBox(),
              GestureDetector(
                onTap: () => showDialog(
                    context: context, builder: (_) => const LogOutDialog()),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: ListTile(
                    leading: Icon(
                      Icons.logout_outlined,
                      size: 30,
                      color: Colors.yellow[600],
                    ),
                    title: const Text("Logout"),
                  ),
                ),
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(color: Colors.grey[800]),
              ),
            ],
          )),
    );
  }

  Row rowRequest(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(number),
        const SizedBox(
          width: 5,
        ),
        Flexible(child: Text(text))
      ],
    );
  }
}