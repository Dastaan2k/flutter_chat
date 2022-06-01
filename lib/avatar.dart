import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class FCAvatar extends StatelessWidget {

  final double radius;
  final String? imageUrl;

  const FCAvatar({this.radius = 45, this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: radius, width: radius,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade700,
            border: Border.all(color: Colors.blueAccent.withOpacity(0.4), width: 2)
        ),
        child: /*ClipRRect(borderRadius: BorderRadius.circular(radius),child: FadeInImage.assetNetwork(placeholder: 'assets/placeholder.jpg', image: imageUrl ?? Get.put(AppStateController()).user!.imageUrl!, fit: BoxFit.cover))*/Center(child: Icon(Icons.record_voice_over_rounded, color: Colors.grey, size: radius * 0.4))
    );
  }
}
