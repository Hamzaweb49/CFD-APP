import 'dart:io';
import 'dart:developer';
import 'package:claxified_app/api/repo/gadget_form_repo.dart';
import 'package:claxified_app/api/repo/home_screen_repo.dart';
import 'package:claxified_app/api/repo/jobs_form_repo.dart';
import 'package:claxified_app/model/get_city_response_model.dart';
import 'package:claxified_app/model/get_nearby_response_model.dart';
import 'package:claxified_app/model/get_pincode_details_response_model.dart';
import 'package:claxified_app/model/get_state_response_model.dart';
import 'package:claxified_app/model/product_list_model/get_jobs_response_model.dart';
import 'package:claxified_app/model/response_item.dart';
import 'package:claxified_app/theme/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class JobsFormScreenController extends GetxController {
  String salaryPeriod = '';
  int? salaryPeriodId;
  List<String> salaryPeriodList = ["Hourly", "Monthly", "Weekly", "Yearly"];
  String positionType = '';
  int? positionTypeId;
  List<String> positionTypeList = [
    'Contract',
    'FullTime',
    'PartTime',
    'Temporary'
  ];

  clearControllerValue(TextEditingController controller) {
    controller.clear();
    update();
  }

  reorderImages(int newIndex, int oldIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final File image = addJobsImageList.removeAt(oldIndex);
    addJobsImageList.insert(newIndex, image);
    update();
  }

  Future getImages(BuildContext context) async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xFilePick = pickedFile;
    if (xFilePick.isNotEmpty) {
      for (var i = 0; i < xFilePick.length; i++) {
        addJobsImageList.add(File(xFilePick[i].path));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nothing is selected'),
        ),
      );
    }
    update();
  }

  int confirmLocation = 0;
  TextEditingController salaryFromController = TextEditingController();
  TextEditingController salaryToController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nearByController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  String nearBySelect = '';
  String citySelect = '';
  String stateSelect = '';
  String? stateIdSelect;
  String? cityIdSelect;
  ImagePicker picker = ImagePicker();
  bool isValidate = false;
  List<File> addJobsImageList = [];

  ///STATE ID
  Future stateId() async {
    for (var element in getAllStateResponseModel) {
      if (element.name == stateSelect) {
        stateIdSelect = element.id.toString();
      }
    }
    log('stateIdSelect---------->>>>>> $stateIdSelect');
    update();
  }

  ///STATE ID
  Future cityId() async {
    for (var element in getAllCityResponseModel) {
      if (element.name == citySelect) {
        cityIdSelect = element.id.toString();
      }
    }
    log('stateIdSelect---------->>>>>> $cityIdSelect');
    update();
  }

  File? profileImage;

  pickImage() async {
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    profileImage = File(file!.path);
    update();
  }

  removePhoto(int index) {
    addJobsImageList.remove(addJobsImageList[index]);
    update();
  }

  RxBool isLoading = false.obs;

  /// UPLOAD IMAGE
  List imageJobsUrl = [];

  uploadJobsImages({required List<File> requestData}) async {
    isLoading.value = true;
    ResponseItem result;
    result = await UploadImageJobsRepo.uploadImagesJobsRepo(
        requestData: requestData);
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          imageJobsUrl = result.data;
          update();
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR====AddGadgetData===>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  ///add Jobs Data

  addJobsData({required Map<String, dynamic> jobsData}) async {
    isLoading.value = true;
    ResponseItem result;
    result = await AddJobsRepo.addJobsRepo(jobsData: jobsData);
    try {
      if (result.status == true) {
        showSuccessSnackBar('Publish Successfully');
        isLoading.value = false;
        update();
      } else {
        isLoading.value = false;
        showSuccessSnackBar('Something Went Wrong,Please Try Again');
      }
    } catch (e) {
      log('ERROR====AddGadgetData===>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  ///GET PINCODE DATA
  List<GetPincodeDetailsResponseModel> getPincodeDetailsResponseModel = [];

  getPincodeData({required String pincode}) async {
    ResponseItem result;
    result = await PincodeRepo.pincodeRepo(pincode: pincode);
    try {
      if (result.status) {
        if (result.data != null) {
          getPincodeDetailsResponseModel =
              List<GetPincodeDetailsResponseModel>.from(result.data
                  .map((x) => GetPincodeDetailsResponseModel.fromJson(x)));

          if (getPincodeDetailsResponseModel.first.postOffice!.isNotEmpty) {
            stateController.text =
                getPincodeDetailsResponseModel.first.postOffice?.first.state ??
                    "";
            cityController.text = getPincodeDetailsResponseModel
                    .first.postOffice?.first.district ??
                "";
          } else {
            getPincodeDetailsResponseModel.clear();
          }

          update();
        }
      } else {
        showBottomSnackBar(result.message!);
      }
    } catch (e) {
      log('ERROR=====GetPincodeDetails====>>>>====>>>>$e');
    }
    update();
  }

  ///GET STATE DATA
  List<GetAllStateResponseModel> getAllStateResponseModel = [];

  List<String> stateList = [];

  getStateData() async {
    isLoading.value = true;
    ResponseItem result;
    result = await GetStateData.getStateData();
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          getAllStateResponseModel = List<GetAllStateResponseModel>.from(
              result.data.map((x) => GetAllStateResponseModel.fromJson(x)));
          for (var element in getAllStateResponseModel) {
            stateList.add(element.name.toString() ?? "");
          }

          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR=======>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  ///GET CITY DATA
  List<GetAllCityResponseModel> getAllCityResponseModel = [];
  List<String> cityList = [];

  getCityData(String id) async {
    getAllCityResponseModel.clear();
    cityList.clear();

    isLoading.value = true;
    ResponseItem result;
    result = await GetCityData.getCityData(id);
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          getAllCityResponseModel = List<GetAllCityResponseModel>.from(
              result.data.map((x) => GetAllCityResponseModel.fromJson(x)));
          for (var element in getAllCityResponseModel) {
            cityList.add(element.name.toString() ?? "");
          }
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR=======>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  ///GET NEAR BY DATA
  List<GetAllNearByResponseModel> getAllNearByResponseModel = [];
  List<String> nearByList = [];

  getNearByData(String id) async {
    nearByList = [];
    isLoading.value = true;
    ResponseItem result;
    result = await GetNearByData.getNearByData(id);
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          getAllNearByResponseModel = List<GetAllNearByResponseModel>.from(
              result.data.map((x) => GetAllNearByResponseModel.fromJson(x)));

          for (var element in getAllNearByResponseModel) {
            nearByList.add(element.name.toString());
          }

          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR====GetNearByData===>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  /// ASSIGN DATA
  List<GetJobsResponseModel> getAllJobsData = [];
  assignData() {
    if (getAllJobsData.isNotEmpty) {
      saveImage(jobImageList: getAllJobsData[0].jobImageList);

      /// Pincode Api
      getPincodeData(pincode: getAllJobsData[0].pincode ?? '');
      titleController.text = getAllJobsData[0].title ?? '';
      stateController.text = getAllJobsData[0].state ?? '';
      stateSelect = getAllJobsData[0].state ?? '';
      cityController.text = getAllJobsData[0].city ?? '';
      citySelect = getAllJobsData[0].city ?? '';
      nearByController.text = getAllJobsData[0].nearBy ?? '';
      nearBySelect = getAllJobsData[0].nearBy ?? '';
      descriptionController.text = getAllJobsData[0].discription ?? '';
      pinCodeController.text = getAllJobsData[0].pincode ?? '';
      nameController.text = getAllJobsData[0].name ?? '';
      phoneController.text = getAllJobsData[0].mobile ?? '';
      salaryFromController.text = getAllJobsData[0].salaryFrom.toString();
      salaryToController.text = getAllJobsData[0].salaryTo.toString();
      salaryPeriodId = getAllJobsData[0].salaryPeriodType;
      if (getAllJobsData[0].salaryPeriodType != null) {
        salaryPeriod =
            salaryPeriodList[getAllJobsData[0].salaryPeriodType! - 1];
      }
      positionTypeId = getAllJobsData[0].positionType;
      if (getAllJobsData[0].positionType != null) {
        positionType = positionTypeList[getAllJobsData[0].positionType! - 1];
      }
    }
    update();
  }

  /// SAVE ASSIGN IMAGES
  saveImage({required List<JobImageList>? jobImageList}) async {
    jobImageList?.forEach((element) async {
      final http.Response response =
          await http.get(Uri.parse(element.imageUrl ?? ''));
      // Get temporary directory
      final dir = await getTemporaryDirectory();

      // Create an image name
      var filename = '${dir.path}/${element.imageUrl?.split('/').last}';

      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);
      log('---xFilePick[i].path----${file.path}');

      addJobsImageList.add(file);
    });
    update();
  }

  /// put Jobs
  updateJobsData(
      {required Map<String, dynamic> jobsData, required String id}) async {
    isLoading.value = true;
    ResponseItem result;
    result = await UpdateJobData.updateJobData(updateData: jobsData, id: id);
    try {
      if (result.status == true) {
        showSuccessSnackBar('Update Successfully');
        isLoading.value = false;
        update();
      } else {
        isLoading.value = false;
        showSuccessSnackBar('Something Went Wrong,Please Try Again');
      }
    } catch (e) {
      log('ERROR====addFashionData===>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  clearData() {
    stateController.clear();
    cityController.clear();
    nearByController.clear();
    stateSelect = '';
    citySelect = '';
    nearBySelect = '';
    confirmLocation = 0;
    pinCodeController.clear();
    salaryFromController.clear();
    salaryToController.clear();
    titleController.clear();
    descriptionController.clear();
    addJobsImageList.clear();
    salaryPeriod = '';
    positionType = '';
  }
}
