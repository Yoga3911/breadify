import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/app/constant/glow.dart';

import '../../routes/route.dart';

class changeProfile extends StatefulWidget {
  const changeProfile({Key? key}) : super(key: key);

  @override
  State<changeProfile> createState() => _changeProfileState();
}

class _changeProfileState extends State<changeProfile> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: NoGlow(),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pushNamed(context, Routes.profile),
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Colors.white,
            ),
            title: const Text("Profile", style: TextStyle(color: Colors.white)),
          ),
          body: ListView(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Nama",
                  style: TextStyle(fontSize: 20),
                            ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Nama",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Username",
                  style: TextStyle(fontSize: 20),
                            ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Username",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Picture",
                  style: TextStyle(fontSize: 20),
                            ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: (){}, child: Text('Import From Galery')),
                  ElevatedButton(onPressed: (){}, child: Text('Take From Camera')),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Image(image: NetworkImage('https://media.istockphoto.com/vectors/transparent-background-seamless-pattern-vector-vector-id875273764')))
            ],
          ),
        ));
  }
}
