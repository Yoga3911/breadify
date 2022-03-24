import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/view_model/provider.dart';
import 'app/constant/color.dart';
import 'app/routes/route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providerData,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MyColor.theme(context),
        initialRoute: Routes.introduction,
        routes: Routes.data,
      ),
    );
  }
}
