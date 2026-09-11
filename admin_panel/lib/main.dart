import 'package:flutter/widgets.dart';

import 'src/app.dart';
import 'src/configs/dependency_injection/dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AdminDependencyInjection.init();
  runApp(const AdminApp());
}
