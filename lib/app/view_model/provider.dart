import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../view_model/category_provider.dart';
import '../view_model/login_provider.dart';
import '../view_model/product_provider.dart';
import '../view_model/store_provider.dart';
import '../view_model/user_prodvider.dart';

final List<SingleChildWidget> providerData = [
  ChangeNotifierProvider(create: (_) => CategoryProvider()),
  ChangeNotifierProvider(create: (_) => UserProvider()),
  ChangeNotifierProvider(create: (_) => LoginProvider()),
  ChangeNotifierProvider(create: (_) => ProductProvider()),
  ChangeNotifierProvider(create: (_) => StoreProvider()),
];
