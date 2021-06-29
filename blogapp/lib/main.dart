import 'package:flutter/material.dart';
import 'src/app.dart';

void main() async {
  await GetStorage.init();
  return runApp(App());
}
