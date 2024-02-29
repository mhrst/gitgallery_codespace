import 'package:common/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const WessiteApp());
}

class WessiteApp extends StatelessWidget {
  const WessiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GoRouterApp(appName: 'app', routes: [
      GoRouterConfig(
        name: 'home',
        path: '/',
        builder: (context, state) {
          return Scaffold(
            body: FutureBuilder<String>(
              future: loadAsset(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  final images = (snapshot.data ?? '').trim().split('\n');
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        for (final image in images)
                          Image.network('images/$image'),
                      ],
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          );
        },
      ),
    ]);
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/images-list.txt');
  }
}
