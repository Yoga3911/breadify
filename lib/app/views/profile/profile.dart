import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/app/constant/color.dart';
import 'package:project/app/constant/glow.dart';
import 'package:project/app/routes/route.dart';
import 'package:project/app/view_model/user_prodvider.dart';
import 'package:project/app/views/profile/change_profile.dart';
import 'package:provider/provider.dart';

import '../main/home/widgets/alert.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;
    return ScrollConfiguration(
      behavior: NoGlow(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.main),
            icon: const Icon(Icons.arrow_back_ios_new),
            color: Colors.white,
          ),
          title: const Text("Profile", style: TextStyle(color: Colors.white)),
          actions: const [
            Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ],
          elevation: 0,
        ),
        body: ListView(
          children: [
            Column(
              children: [
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
                        child: CachedNetworkImage(
                          imageUrl: user.imageUrl,
                          fit: BoxFit.cover,
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
                                child: const Center(child: Text("Customer"))),
                            const Text("Saldo : Rp100.000",
                                style: TextStyle(
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
                  onTap: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return changeProfile();}));},
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
                  decoration: const BoxDecoration(color: Colors.white),
                ),
                GestureDetector(
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) => StatefulBuilder(
                        builder: (context, setState) => AlertDialog(
                          scrollable: true,
                              content: Column( children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('1. '),
                                    SizedBox(width: 5,),
                                    Flexible(child: Text('Produknya berkualitas dan selalu up to date.'))
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('2. '),
                                    SizedBox(width: 5,),
                                    Flexible(child: Text('Varian produknya banyak dan stok terjamin.'))
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('3. '),
                                    SizedBox(width: 5,),
                                    Flexible(child: Text('Harga jual yang ditentukan sesuai dengan kualitas dan sangat bersaing.'))
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('4. '),
                                    SizedBox(width: 5,),
                                    Flexible(child: Text('Minimal sudah menjalankan bisnis selama 1 tahun dan sudah memiliki banyak reseller.'))
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('5. '),
                                    SizedBox(width: 5,),
                                    Flexible(child: Text('Memberikan banyak kemudahan dalam menjalankan bisnis sebagai reseller, seperti menyediakan katalog online, program diskon khusus, bersedia menangani komplain pelanggan.'))
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('6. '),
                                    SizedBox(width: 5,),
                                    Flexible(child: Text('Memberikan informasi yang jujur mengenai kondisi produk, termasuk kelemahan dan kelebihannya.'))
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('7. '),
                                    SizedBox(width: 5,),
                                    Flexible(child: Text('Menjalin hubungan dengan pelanggan di luar urusan jual beli dan jalin komunikasi sebagai teman.'))
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('8. '),
                                    SizedBox(width: 5,),
                                    Flexible(child: Text('Menjawab setiap pertanyaan konsumen tentang produk dengan sabar dan sejelas-jelasnya karena konsumen hanya mengandalkan foto dan keterangan yang tercantum. Anda bisa mempelajari detail produk dari FAQ yang biasanya ada di website supplier.Log Out'))
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(value: isChecked, onChanged: (val) {
                                      isChecked = !val!;
                                      setState(() {
                                        isChecked = !isChecked;
                                      });
                                    }),
                                    Text('I Agree to the Terms Above')
                                  ],
                                ),
                                ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text('Request'))
                              ],),
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
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: ListTile(
                    leading: Icon(
                      Icons.lock_outline_sharp,
                      size: 30,
                      color: Colors.yellow[600],
                    ),
                    title: const Text("Privacy and Security"),
                  ),
                ),
                Container(
                  height: 1,
                  decoration: BoxDecoration(color: Colors.grey[800]),
                ),
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
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: ListTile(
                    leading: Icon(
                      Icons.help_outline,
                      size: 30,
                      color: Colors.yellow[600],
                    ),
                    title: const Text("Help Center"),
                  ),
                ),
                Container(
                  height: 1,
                  decoration: BoxDecoration(color: Colors.grey[800]),
                ),
                Container(
                  height: 100,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
