import 'dart:io';
import 'package:claxified_app/constant/app_color.dart';
import 'package:claxified_app/constant/app_string.dart';
import 'package:claxified_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'app_text_fields.dart';

class FormScreenReviewDetails extends StatelessWidget {
  const FormScreenReviewDetails(
      {super.key,
      required this.nameController,
      required this.numberController,
      this.profileImage,
      required this.pickImageOnTap});

  final TextEditingController nameController;
  final TextEditingController numberController;
  final File? profileImage;
  final GestureTapCallback pickImageOnTap;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
      height: h * 0.17,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: whiteColor,
        boxShadow: const [BoxShadow(color: greyColor, blurRadius: 1)],
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: w * 0.035),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                      height: h * 0.13,
                      width: h * 0.13,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      child: Center(
                        child: profileImage == null
                            ? const Icon(
                                Icons.camera_alt_outlined,
                                size: 35,
                                color: appColor,
                              )
                            : Image.file(
                                profileImage!,
                                fit: BoxFit.cover,
                              ),
                      )),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: pickImageOnTap,
                    child: Container(
                        height: h * 0.035,
                        width: h * 0.035,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: greyColor, blurRadius: 2)
                            ],
                            color: whiteColor),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            size: 22,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppSearchBar.formTextField(
                    readOnly: true,
                    controller: nameController,
                    labelText:
                        AppString.nameFormText.semiBoldMontserratTextStyle(),
                    hintText: AppString.nameText,
                  ),
                  (h * 0.008).addHSpace(),
                  AppSearchBar.formTextField(
                    readOnly: true,
                    textInputType: TextInputType.number,
                    controller: numberController,
                    labelText:
                        AppString.phoneNumberText.semiBoldMontserratTextStyle(),
                    hintText: AppString.enterPhoneText,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
