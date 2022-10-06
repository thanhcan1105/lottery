import 'package:flutter/material.dart';

class ShaderMaskCustom extends StatelessWidget {
  const ShaderMaskCustom({
    Key? key,
    this.icon,
    this.height,
    this.width,
    this.imageAsset,
    this.size,
    this.text,
  }) : super(key: key);

  final IconData? icon;
  final String? imageAsset;
  final String? text;
  final double? height;
  final double? width;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return RadialGradient(
          center: Alignment.topLeft,
          radius: 0.5,
          colors: <Color>[Colors.greenAccent, Colors.blueAccent],
          tileMode: TileMode.repeated,
        ).createShader(bounds);
      },
      child: icon != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: size ?? 30,
                ),
                text != null
                    ? Text(
                        text.toString(),
                        style: TextStyle(fontSize: 12),
                      )
                    : Container(),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imageAsset!,
                  height: height ?? 30,
                  width: width ?? 30,
                ),
                text != null
                    ? Text(
                        text.toString(),
                        style: TextStyle(fontSize: 12),
                      )
                    : Container(),
              ],
            ),
    );
  }
}
