import 'package:flutter/material.dart';
import '../data/heatmap_color.dart';

class HeatMapContainer extends StatelessWidget {
  final DateTime date;
  final int? score;
  final Size size;
  final double? fontSize;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? textColor;
  final EdgeInsets? margin;
  final bool? showText;
  final Function(DateTime dateTime)? onClick;

  const HeatMapContainer({
    Key? key,
    required this.date,
    this.score,
    this.margin,
    required this.size,
    this.fontSize,
    this.borderRadius,
    this.backgroundColor,
    this.selectedColor,
    this.textColor,
    this.onClick,
    this.showText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    return Padding(
      padding: margin ?? const EdgeInsets.all(2),
      child: GestureDetector(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            color: backgroundColor ?? HeatMapColor.defaultColor,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 5)),
            border: DateTime(now.year, now.month, now.day) ==
                    DateTime(date.year, date.month, date.day)
                ? Border.all(color: Colors.blue, width: 2)
                : null,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOutQuad,
            width: size.width,
            height: size.height,
            alignment: Alignment.center,
            child: (showText ?? true)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        date.day.toString(),
                        style: TextStyle(
                            color: textColor ?? const Color(0xFF8A8A8A),
                            fontSize: fontSize),
                      ),
                      if (score != null)
                        Text(
                          "${score}m",
                          style: TextStyle(
                              color: textColor ?? const Color(0xFF8A8A8A),
                              fontSize: 9),
                        )
                      else
                        ...[],
                    ],
                  )
                : null,
            decoration: BoxDecoration(
              color: selectedColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 5)),
            ),
          ),
        ),
        onTap: () {
          onClick != null ? onClick!(date) : null;
        },
      ),
    );
  }
}
