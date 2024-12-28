import 'package:flutter/material.dart';

enum TextType { h1, h2, h3, h4, h5, h6, p, strong, em, small }

class CustomText extends StatelessWidget {
  final String text;
  final TextType type;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextDecoration? decoration;
  const CustomText({
    super.key,
    required this.text,
    this.type = TextType.p,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.fontSize,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextStyle(context),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  TextStyle getTextStyle(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    switch (type) {
      case TextType.h1:
        return theme.textTheme.displayLarge?.copyWith(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              decoration: decoration,
            ) ??
            TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
              decoration: decoration,
            );

      case TextType.h2:
        return theme.textTheme.displayMedium?.copyWith(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              decoration: decoration,
            ) ??
            TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
              decoration: decoration,
            );

      case TextType.h3:
        return theme.textTheme.displaySmall?.copyWith(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              decoration: decoration,
            ) ??
            TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
              decoration: decoration,
            );
      case TextType.h4:
        return theme.textTheme.headlineMedium?.copyWith(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              decoration: decoration,
            ) ??
            TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
              decoration: decoration,
            );

      case TextType.h5:
        return theme.textTheme.headlineSmall?.copyWith(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              decoration: decoration,
            ) ??
            TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
              decoration: decoration,
            );

      case TextType.h6:
        return theme.textTheme.titleLarge?.copyWith(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              decoration: decoration,
            ) ??
            TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
              decoration: decoration,
            );

      case TextType.strong:
        return theme.textTheme.bodyLarge?.copyWith(
              color: color,
              fontWeight: fontWeight,
              decoration: decoration,
            ) ??
            TextStyle(
              fontWeight: fontWeight,
              decoration: decoration,
              color: color,
            );

      case TextType.em:
        return theme.textTheme.bodyLarge?.copyWith(
              color: color,
              fontStyle: FontStyle.italic,
              decoration: decoration,
            ) ??
            TextStyle(
              fontStyle: FontStyle.italic,
              decoration: decoration,
              color: color,
            );

      case TextType.small:
        return theme.textTheme.bodySmall?.copyWith(
              color: color,
              fontSize: fontSize,
              decoration: decoration,
            ) ??
            TextStyle(
              fontSize: fontSize,
              color: color,
              decoration: decoration,
            );

      case TextType.p:
        return theme.textTheme.bodyLarge?.copyWith(
              color: color,
              fontWeight: fontWeight,
              decoration: decoration,
            ) ??
            TextStyle(
              color: color,
              fontWeight: fontWeight,
              decoration: decoration,
            );
    }
  }
}

class RichCustomText extends StatelessWidget {
  final List<CustomTextSpan> spans;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const RichCustomText({
    super.key,
    required this.spans,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: spans.map((span) => span.toTextSpan(context)).toList(),
      ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}

class CustomTextSpan {
  final String text;
  final TextType type;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;

  const CustomTextSpan({
    required this.text,
    this.type = TextType.p,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
  });

  TextSpan toTextSpan(BuildContext context) {
    return TextSpan(
      text: text,
      style: CustomText(text: text).getTextStyle(context).copyWith(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
          ),
    );
  }
}
