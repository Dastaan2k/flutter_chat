import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: NeumorphicTheme.baseColor(context),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const FlutterLogo(size: 120),
                      const SizedBox(width: 30),
                      Text('Flutter Chat', style: Theme.of(context).textTheme.displayLarge)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
