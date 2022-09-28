import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perfume/core/helper/app_localization.dart';

import 'app.dart';
import 'core/helper/network_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await localization.init();

  runApp(Phoenix(child: const MyApp()));
}
