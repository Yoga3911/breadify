import 'package:project/app/view_model/add_prod_provider.dart';
import 'package:project/app/view_model/category_provider.dart';
import 'package:project/app/view_model/login_provider.dart';
import 'package:project/app/view_model/user_prodvider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providerData = [
  ChangeNotifierProvider(create: (context) => CategoryProvider()),
  ChangeNotifierProvider(create: (context) => UserProvider()),
  ChangeNotifierProvider(create: (context) => LoginProvider()),
  ChangeNotifierProvider(create: (context) => AddProductProvider())
];
