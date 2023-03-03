import 'package:flutter/material.dart';
import 'package:utc_flutter_app/star_bus_app.dart';
import 'package:utc_flutter_app/utils/sharedpref/memory_management.dart';
import 'package:utc_flutter_app/utils/sharedpref/search_bus_model_sp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MemoryManagement.init();
  await SaveSearchBusSP.init();//initialize the shared preference once
  runApp(StarBusApp());
}
