import 'package:widgetly/src/button/view/button.dart';
import 'package:widgetly/src/extensions/colors_extensions.dart';
import 'package:widgetly/src/localization/localization.dart';
import 'package:flutter/material.dart';

class PlaceholderLy extends StatelessWidget {
  const PlaceholderLy({
    super.key,
    this.icon,
    required this.placeholderText,
    this.resetAction,
    this.resetButtonLabel,
    this.resetButtonColor,
    this.paddingTop,
    this.paddingBottom,
    this.mainColor,
  });

  final IconData? icon;
  final String placeholderText;
  final Function()? resetAction;
  final String? resetButtonLabel;
  final Color? resetButtonColor;
  final double? paddingTop;
  final double? paddingBottom;
  final Color? mainColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [buildIcon(), buildText(), if (resetAction != null) buildReset()],
        ),
      ),
    );
  }

  Widget buildIcon() {
    return Icon(icon ?? Icons.search, color: mainColor ?? Colors.black, size: 90);
  }

  Widget buildText() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        placeholderText,
        style: TextStyle(color: mainColor ?? ColorsLy.darkGrey, fontSize: 30, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildReset() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ButtonLy(
        label: resetButtonLabel ?? LocalizationLy.instance.translate('Reset'),
        buttonFunc: () {
          resetAction!();
        },
        mainColor: resetButtonColor ?? Colors.red,
        showOutline: true,
      ),
    );
  }
}
