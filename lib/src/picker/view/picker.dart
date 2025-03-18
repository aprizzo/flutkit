import 'package:flutkit/src/extensions/colors_extensions.dart';
import 'package:flutkit/src/gesture_detector/view/gesture_detector.dart';
import 'package:flutkit/src/modal/modal_repository.dart';
import 'package:flutkit/src/picker/view/item_selector.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PickerKit extends StatefulWidget {
  PickerKit({
    super.key,
    this.label,
    this.modalTitle,
    this.labelMaxLines,
    required this.selectedValue,
    this.mainColor,
    required this.values,
    required this.updateValue,
    this.deleteAction,
  });

  final String? label;
  final String? modalTitle;
  final int? labelMaxLines;
  final Color? mainColor;
  final Iterable<dynamic> values;
  final Function(dynamic element) updateValue;
  final Function()? deleteAction;

  dynamic selectedValue;

  @override
  State<PickerKit> createState() => _CustomPickerState();
}

class _CustomPickerState extends State<PickerKit> {
  bool showList = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [if (widget.label != null) buildLabel(), buildValue()],
      ),
    );
  }

  Widget buildValue() {
    return Expanded(
      flex: 4,
      child: SizedBox(
        width: widget.label == null ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width / 1.9,
        height: 45,
        child: Row(children: [buildPicker(context), if (widget.deleteAction != null) buildDelete()]),
      ),
    );
  }

  Widget buildLabel() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3.5,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Text(
          widget.label!.toUpperCase(),
          style: TextStyle(color: ColorsKit.darkGrey, fontSize: 14),
          maxLines: widget.labelMaxLines ?? 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget buildPicker(BuildContext context) {
    return Expanded(
      child: GestureDetectorKit(
        onTap: () {
          ModalRepository.shared.showBottomSheet(
            context: context,
            mainColor: widget.mainColor,
            bottomSheet: ItemSelectorKit(
              label: widget.label,
              selectedValue: widget.selectedValue,
              values: widget.values,
              updateValue: (dynamic element) {
                widget.updateValue(element);
              },
            ),
            title: widget.modalTitle ?? widget.label,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: ColorsKit.darkGrey, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.selectedValue == null ? '-' : '${widget.selectedValue}',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SizedBox(height: 55, child: Icon(Icons.arrow_drop_down, color: Colors.black, size: 36)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDelete() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: GestureDetectorKit(
        onTap: () async {
          if (widget.deleteAction != null) {
            await widget.deleteAction!();
          }
          setState(() {
            widget.selectedValue = null;
          });
        },
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
          child: Padding(padding: const EdgeInsets.all(5), child: Icon(Icons.close, color: Colors.white, size: 18)),
        ),
      ),
    );
  }
}
