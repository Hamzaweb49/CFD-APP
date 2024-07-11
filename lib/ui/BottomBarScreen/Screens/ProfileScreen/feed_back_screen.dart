import 'package:claxified_app/constant/app_color.dart';
import 'package:claxified_app/constant/app_string.dart';
import 'package:claxified_app/ui/BottomBarScreen/Controller/add_feed_back_controller.dart';
import 'package:claxified_app/utils/extension.dart';
import 'package:claxified_app/utils/shared_prefs.dart';
import 'package:claxified_app/widgets/app_appbar.dart';
import 'package:claxified_app/widgets/app_button.dart';
import 'package:claxified_app/widgets/app_container.dart';
import 'package:claxified_app/widgets/app_text_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddFeedBackScreen extends StatefulWidget {
  const AddFeedBackScreen({super.key});

  @override
  State<AddFeedBackScreen> createState() => _AddFeedBackScreen();
}

class _AddFeedBackScreen extends State<AddFeedBackScreen> {
  FeedBackController feedBackController = Get.put(FeedBackController());

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return AppContainer(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: whiteColor,
          appBar: CommonAppBar(
            h: h,
            w: w,
            title: AppString.feedBackFormText,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.048),
            child: GetBuilder<FeedBackController>(
              builder: (controller) {
                return Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: h * 0.03),
                          child: AppString.feedBackDetailsText
                              .semiBoldMontserratTextStyle(
                                  fontColor: greyColor, fontSize: h * 0.018),
                        ),
                        SizedBox(height: h * 0.011),
                        AppSearchBar.formTextField(
                          textInputType: TextInputType.text,
                          hintText: AppString.title,
                          labelText: AppString.title
                              .semiBoldMontserratTextStyle(
                                  fontColor: blackColor),
                          controller: controller.feedBackTitle,
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(
                                top: h * 0.009, left: w * 0.045),
                            child: "T"
                                .boldMontserratTextStyle(fontSize: h * 0.032),
                          ),
                          validator: (value) {
                            if (controller.feedBackTitle.text.isEmpty) {
                              return AppString.enterTitleText;
                            } else {
                              return null;
                            }
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: h * 0.02)
                              .copyWith(bottom: h * 0.04),
                          child: DescriptionTextField(
                            hintText: AppString.messageText,
                            labelText: AppString.messageText,
                            maxLines: 7,
                            controller: controller.feedBackDescription,
                            validator: (value) {
                              if (controller.feedBackDescription.text.isEmpty) {
                                return AppString.enterdescriptionText;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        AppFilledButton(
                          onPressed: () async {
                            if (controller.formKey.currentState!.validate()) {
                              Map<String, dynamic> feedBackData = {
                                "id": 0,
                                "title": controller.feedBackTitle.text,
                                "message": controller.feedBackDescription.text,
                                "createdBy":
                                    preferences.getInt(SharedPreference.userId),
                                "createdOn":
                                    DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'")
                                        .format(DateTime.now())
                              };
                              await controller.addFeedBackData(
                                  feedBackData: feedBackData);
                            }
                          },
                          title: AppString.submitText,
                          textColor: whiteColor,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
