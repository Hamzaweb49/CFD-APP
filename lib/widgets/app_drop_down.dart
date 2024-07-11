import 'dart:developer';

import 'package:claxified_app/constant/app_color.dart';
import 'package:claxified_app/constant/app_string.dart';
import 'package:claxified_app/ui/FormScreen/Gadget/gadget_form_controller.dart';
import 'package:claxified_app/utils/extension.dart';
import 'package:claxified_app/widgets/app_text_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDropDown extends StatelessWidget {
  const AppDropDown(
      {super.key,
      required this.values,
      required this.valueList,
      required this.onChanged,
      this.height,
      this.hint,
      this.borderColor,
      this.formScreen = false});

  final String values;
  final List valueList;
  final ValueChanged onChanged;
  final double? height;
  final Widget? hint;
  final Color? borderColor;
  final bool formScreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton<String>(
        hint: hint,
        icon: const Icon(
          Icons.arrow_drop_down_sharp,
          size: 35,
          color: blackColor,
        ),
        isExpanded: true,
        borderRadius: BorderRadius.circular(8),
        underline: const SizedBox(),
        padding: EdgeInsets.zero,
        items: valueList.map((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value ?? "",
              style: textFieldTextStyleBlack,
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}

class AutoCorrectField extends StatelessWidget {
  const AutoCorrectField(
      {super.key,
      required this.optionList,
      required this.label,
      this.onSelected,
      this.initialValue,
      this.onChanged,
      this.suffixIcon});

  final List<String> optionList;
  final String label;
  final Function(String)? onSelected;
  final TextEditingValue? initialValue;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      initialValue: initialValue,
      optionsBuilder: (TextEditingValue textEditingValue) {
        return optionList.where(
          (String option) {
            return option
                .toUpperCase()
                .contains(textEditingValue.text.toUpperCase());
          },
        );
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        return DropDownTextField(
          onChanged: onChanged,
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          controller: textEditingController,
          hintText: AppString.pickoneText,
          labelText: label,
          suffixIcon: suffixIcon ??
              IconButton(
                  onPressed: () {
                    textEditingController.clear();
                  },
                  icon: const Icon(Icons.cancel)),
        );
      },
      onSelected: onSelected,
    );
  }
}
