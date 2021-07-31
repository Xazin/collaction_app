import 'package:collaction_app/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'api/graphql_api.dart';

void main() async {
  // We're using HiveStore for persistence,
  // so we need to initialize Hive.
  await initHiveForFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: client, // The client is provided by the graphql_api file
        child: MaterialApp(
            title: 'Welcome to CollAction',
            theme: ThemeData(
              primaryColor: Color(0xff23d884),
            ),
            home: HomeScreen()));
  }
}
