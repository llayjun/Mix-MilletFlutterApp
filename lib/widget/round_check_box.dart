import 'package:MilletFlutterApp/constant/app_colors.dart';
import 'package:flutter/material.dart';

class RoundCheckBox extends StatefulWidget {
  var value = false;

  Function(bool) onChanged;

  RoundCheckBox({Key key, @required this.value, this.onChanged})
      : super(key: key);

  @override
  _RoundCheckBoxState createState() => _RoundCheckBoxState();
}

class _RoundCheckBoxState extends State<RoundCheckBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.value = !widget.value;
        widget.onChanged(widget.value);
      },
      child: widget.value
          ? Icon(
              Icons.check_circle,
              size: 25.0,
              color: AppColors.color_4a73ff,
            )
          : Icon(
              Icons.panorama_fish_eye,
              size: 25.0,
              color: Colors.grey,
            ),
    );
  }
}
