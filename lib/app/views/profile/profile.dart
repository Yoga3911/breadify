import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios),
        title: const Text("Profile"),
        actions: const [
          Icon(Icons.more_vert),
        ],),
      body: ListView(
        children: [
          Row(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
                child: const Image(image: AssetImage("assets/images/superman.png"),),
              ),
              Column(
                children: [
                  Text("Pakdhe"),
                  Text("Customer"),
                  Text("Saldo Rp 100.000"),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}