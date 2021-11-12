import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  const AppButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      this.height = 65,
      this.color = Colors.white,
      this.titleStyle = const TextStyle(
        color: Colors.black,
        fontSize: 19,
        fontWeight: FontWeight.w600,
      )})
      : super(key: key);

  final Function() onPressed;
  final String title;
  final double height;
  final Color color;
  final TextStyle titleStyle;

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () async {
        setState(() {
          loading = true;
        });
        await widget.onPressed();
        setState(() {
          loading = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(100),
        ),
        alignment: Alignment.center,
        child: !loading
            ? Text(
                widget.title,
                style: widget.titleStyle,
              )
            : CircularProgressIndicator(
                strokeWidth: 2,
                color: widget.titleStyle.color,
              ),
        height: widget.height,
        width: double.infinity,
      ),
    );
  }
}
