import 'package:project/app/view_model/category_provider.dart';
import 'package:project/app/view_model/login_provider.dart';
import 'package:project/app/view_model/product_provider.dart';
import 'package:project/app/view_model/store_provider.dart';
import 'package:project/app/view_model/user_prodvider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providerData = [
  ChangeNotifierProvider(create: (_) => CategoryProvider()),
  ChangeNotifierProvider(create: (_) => UserProvider()),
  ChangeNotifierProvider(create: (_) => LoginProvider()),
  ChangeNotifierProvider(create: (_) => ProductProvider()),
  ChangeNotifierProvider(create: (_) => StoreProvider()),
];
