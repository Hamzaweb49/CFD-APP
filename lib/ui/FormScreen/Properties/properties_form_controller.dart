import 'dart:io';
import 'dart:developer';
import 'package:claxified_app/api/repo/gadget_form_repo.dart';
import 'package:claxified_app/api/repo/home_screen_repo.dart';
import 'package:claxified_app/api/repo/property_form_repo.dart';
import 'package:claxified_app/model/get_city_response_model.dart';
import 'package:claxified_app/model/get_nearby_response_model.dart';
import 'package:claxified_app/model/get_pincode_details_response_model.dart';
import 'package:claxified_app/model/get_state_response_model.dart';
import 'package:claxified_app/model/product_list_model/get_property_response_model.dart';
import 'package:claxified_app/model/response_item.dart';
import 'package:claxified_app/theme/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class PropertiesFormScreenController extends GetxController {
  String propType = '';
  int? propTypeId;
  List<String> propertiesList = [
    "Apartment",
    "BuilderFloor",
    "FarmHouses",
    "HousesVilas"
  ];

  String serviceTypeSelect = '';
  int? serviceTypeSelectId;
  List<String> serviceList = ["ForSale", "ForRent", "ForLease"];
  String mealsIncludedSelect = '';
  int? mealsIncludedSelectId;
  List<String> mealsIncludedList = ["No", "Yes"];

  List<String> furnishingList = ["Furnished", "SemiFurnished", "UnFurnished"];
  String furnishType = '';
  int? furnishTypeId;
  List<String> bedroomsList = ['1', '2', '3', '4'];
  String bedroomType = '';
  int? bedroomTypeId;
  List<String> bathroomsList = ['1', '2', '3', '4'];
  String bathroomType = '';
  int? bathroomTypeId;
  List<String> constructionStatusList = [
    "NewLaunch",
    "ReadyToMove",
    "UnderConstruction"
  ];

  String pgType = '';
  int? pgTypeId;
  List<String> pgTypeList = ["GuestHouse", "PG", "Roommate"];

  String constructionStatus = '';
  int? constructionStatusId;

  List<String> listedTypeList = ["Builder", "Dealer", "Owner"];
  String listedByType = '';
  int? listedByTypeId;
  List<String> bachelorsAllowed = ["No", "Yes"];
  String bachelorAllow = '';
  int? bachelorAllowId;
  List<String> carParking = ['1', '2', '3', '4'];
  String carPark = '';
  int? carParkId;

  List<String> facingList = [
    "East",
    "North",
    "NorthEast",
    "NorthWest",
    "South",
    "SouthEast",
    "SouthWest",
    "West"
  ];
  String? facing;
  TextEditingController superBuildUpArea = TextEditingController(text: '0');
  TextEditingController carpetArea = TextEditingController(text: '0');
  TextEditingController maintenance = TextEditingController(text: '0');
  TextEditingController totalFloors = TextEditingController(text: '0');
  TextEditingController floorNo = TextEditingController(text: '0');
  TextEditingController ploatArea = TextEditingController(text: '0');
  TextEditingController lengthController = TextEditingController(text: '0');
  TextEditingController breadthController = TextEditingController(text: '0');
  TextEditingController projectName = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TextEditingController priceController = TextEditingController(text: '0');

  clearControllerValue(TextEditingController controller) {
    controller.clear();
    update();
  }

  int? selectFacingId;

  reorderImages(int newIndex, int oldIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final File image = propertiesImageList.removeAt(oldIndex);
    propertiesImageList.insert(newIndex, image);
    update();
  }

  Future getImages(BuildContext context) async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xFilePick = pickedFile;
    if (xFilePick.isNotEmpty) {
      for (var i = 0; i < xFilePick.length; i++) {
        propertiesImageList.add(File(xFilePick[i].path));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Nothing is selected')));
    }
    update();
  }

  int confirmLocation = 0;
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
  String? nearByIdSelect;
  bool isValidate = false;
  ImagePicker picker = ImagePicker();
  List<File> propertiesImageList = [];

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

  pickImage() async {
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    profileImage = File(file!.path);
    update();
  }

  removePhoto(int index) {
    propertiesImageList.remove(propertiesImageList[index]);
    update();
  }

  RxBool isLoading = false.obs;
  File? profileImage;

  /// UPLOAD IMAGE API
  List imagePropertyUrl = [];

  uploadPropertyImages({required List<File> requestData}) async {
    isLoading.value = true;
    ResponseItem result;
    result = await UploadImagePropertyRepo.uploadImagesPropertyRepo(
        requestData: requestData);
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          imagePropertyUrl = result.data;
          update();
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR====uploadPropertyImages===>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  ///add Property Data

  addPropertyData({required Map<String, dynamic> propertyData}) async {
    isLoading.value = true;
    ResponseItem result;
    result = await AddPropertyRepo.addPropertyRepo(propertyData: propertyData);
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
      log('ERROR====addPropertyData===>>>>====>>>>$e');
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
            stateList.add(element.name.toString());
          }

          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR=======1111>>>>====>>>>$e');
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
  List<GetAllPropertyResponseModel> getAllPropertyData = [];
  assignData() async {
    if (getAllPropertyData.isNotEmpty) {
      saveImage(propertyImageList: getAllPropertyData[0].propertyImageList);

      /// Pincode Api
      getPincodeData(pincode: getAllPropertyData[0].pincode ?? '');
      titleController.text = getAllPropertyData[0].title ?? '';
      stateController.text = getAllPropertyData[0].state ?? '';
      stateSelect = getAllPropertyData[0].state ?? '';
      cityController.text = getAllPropertyData[0].city ?? '';
      citySelect = getAllPropertyData[0].city ?? '';
      nearByController.text = getAllPropertyData[0].nearBy ?? '';
      nearBySelect = getAllPropertyData[0].nearBy ?? '';
      descriptionController.text = getAllPropertyData[0].discription ?? '';
      priceController.text = getAllPropertyData[0].price.toString() ?? '';
      pinCodeController.text = getAllPropertyData[0].pincode ?? '';
      nameController.text = getAllPropertyData[0].name ?? '';
      phoneController.text = getAllPropertyData[0].mobile ?? '';
      superBuildUpArea.text = getAllPropertyData[0].superBuildUpArea.toString();
      carpetArea.text = getAllPropertyData[0].carpetArea.toString();
      maintenance.text = getAllPropertyData[0].maintenanceCharge.toString();
      totalFloors.text = getAllPropertyData[0].totalFloors.toString();
      floorNo.text = getAllPropertyData[0].floorNumber.toString();
      ploatArea.text = getAllPropertyData[0].plotArea.toString();
      lengthController.text = getAllPropertyData[0].lenght.toString();
      breadthController.text = getAllPropertyData[0].breadth.toString();
      projectName.text = getAllPropertyData[0].projectName.toString();

      /// Facing
      if (getAllPropertyData[0].facingType != null &&
          getAllPropertyData[0].facingType != 0) {
        facing = facingList[getAllPropertyData[0].facingType! - 1];
      }
      selectFacingId = getAllPropertyData[0].facingType;

      /// propType
      if (getAllPropertyData[0].houseType != null &&
          getAllPropertyData[0].houseType != 0) {
        propType = propertiesList[getAllPropertyData[0].houseType! - 1];
      }
      propTypeId = getAllPropertyData[0].houseType;

      /// furnishType
      log('---sss->>>>${getAllPropertyData[0].facingType}');
      if (getAllPropertyData[0].furnishingStatus != null &&
          getAllPropertyData[0].furnishingStatus != 0) {
        furnishType =
            furnishingList[getAllPropertyData[0].furnishingStatus! - 1];
      }
      furnishTypeId = getAllPropertyData[0].furnishingStatus;

      /// bedroomType
      if (getAllPropertyData[0].bedrooms != null &&
          getAllPropertyData[0].bedrooms != 0) {
        bedroomType = bedroomsList[getAllPropertyData[0].bedrooms! - 1];
      }
      bedroomTypeId = getAllPropertyData[0].bedrooms;

      /// Bathrooms
      if (getAllPropertyData[0].bathrooms != null &&
          getAllPropertyData[0].bathrooms != 0) {
        bathroomType = bathroomsList[getAllPropertyData[0].bathrooms! - 1];
      }
      bathroomTypeId = getAllPropertyData[0].bathrooms;

      /// Construct Status Type
      if (getAllPropertyData[0].constructionStatus != null &&
          getAllPropertyData[0].constructionStatus != 0) {
        constructionStatus = constructionStatusList[
            getAllPropertyData[0].constructionStatus! - 1];
      }
      constructionStatusId = getAllPropertyData[0].constructionStatus;

      /// listed By Type
      if (getAllPropertyData[0].listedBy != null &&
          getAllPropertyData[0].listedBy != 0) {
        listedByType = listedTypeList[getAllPropertyData[0].listedBy! - 1];
      }
      listedByTypeId = getAllPropertyData[0].listedBy;

      /// Car Parking
      if (getAllPropertyData[0].carParking != null &&
          getAllPropertyData[0].carParking != 0) {
        carPark = carParking[getAllPropertyData[0].carParking! - 1];
      }
      carParkId = getAllPropertyData[0].carParking;

      /// Service Type
      if (getAllPropertyData[0].serviceType != null &&
          getAllPropertyData[0].serviceType != 0) {
        serviceTypeSelect = serviceList[getAllPropertyData[0].serviceType! - 1];
      }
      serviceTypeSelectId = getAllPropertyData[0].serviceType;

      /// Pg Type
      if (getAllPropertyData[0].pgType != null &&
          getAllPropertyData[0].pgType != 0) {
        pgType = pgTypeList[getAllPropertyData[0].pgType! - 1];
      }
      pgTypeId = getAllPropertyData[0].pgType;

      /// Meal Included
      if (getAllPropertyData[0].isMealIncluded != null) {
        if (getAllPropertyData[0].isMealIncluded == true) {
          mealsIncludedSelect = mealsIncludedList[1];
          mealsIncludedSelectId = 1;
        } else {
          mealsIncludedSelect = mealsIncludedList[0];
          mealsIncludedSelectId = 0;
        }
      }

      /// Bachelor allowed
      if (getAllPropertyData[0].bachelorAllowed != null) {
        if (getAllPropertyData[0].bachelorAllowed == true) {
          bachelorAllow = bachelorsAllowed[1];
          bachelorAllowId = 1;
        } else {
          bachelorAllow = bachelorsAllowed[0];
          bachelorAllowId = 0;
        }
      }
    }
    update();
  }

  /// SAVE ASSIGN IMAGES
  saveImage({required List<PropertyImageList>? propertyImageList}) async {
    propertyImageList?.forEach((element) async {
      final http.Response response =
          await http.get(Uri.parse(element.imageUrl ?? ''));

      // Get temporary directory
      final dir = await getTemporaryDirectory();

      // Create an image name
      var filename = '${dir.path}/${element.imageUrl?.split('/').last}';

      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);

      propertiesImageList.add(file);
    });
    update();
  }

  /// put Properties
  updatePropertiesData(
      {required Map<String, dynamic> updatePropertiesData,
      required String id}) async {
    isLoading.value = true;
    ResponseItem result;
    result = await UpdatePropertiesData.updatePropertiesData(
        updateData: updatePropertiesData, id: id);
    try {
      if (result.status == true) {
        showSuccessSnackBar('Update Successfully');
        isLoading.value = false;
        update();
      } else {
        isLoading.value = false;
        showSuccessSnackBar('Something Went Wrong, Please Try Again');
      }
    } catch (e) {
      log('ERROR====putPropertiesAllData===>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  clearData() {
    stateController.clear();
    cityController.clear();
    nearByController.clear();
    titleController.clear();
    descriptionController.clear();
    priceController.clear();
    pinCodeController.clear();
    stateSelect = '';
    citySelect = '';
    nearBySelect = '';
    confirmLocation = 0;
    superBuildUpArea.clear();
    carpetArea.clear();
    maintenance.clear();
    totalFloors.clear();
    floorNo.clear();
    ploatArea.clear();
    lengthController.clear();
    breadthController.clear();
    projectName.clear();
    propType = '';
  }
}
