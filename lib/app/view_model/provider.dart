import 'package:project/app/view_model/category_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providerData = [
  ChangeNotifierProvider(create: (context) => CategoryProvier()),
];
