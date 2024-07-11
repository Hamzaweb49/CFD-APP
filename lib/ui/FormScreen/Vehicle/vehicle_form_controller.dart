import 'dart:developer';
import 'dart:io';
import 'package:claxified_app/api/repo/gadget_form_repo.dart';
import 'package:claxified_app/api/repo/home_screen_repo.dart';
import 'package:claxified_app/api/repo/vehicle_form_repo.dart';
import 'package:claxified_app/model/get_bicycle_brand_response_model.dart';
import 'package:claxified_app/model/get_bike_brand_response_model.dart';
import 'package:claxified_app/model/get_bike_model_response_model.dart';
import 'package:claxified_app/model/get_car_brand_response_model.dart';
import 'package:claxified_app/model/get_car_model_response_model.dart';
import 'package:claxified_app/model/get_city_response_model.dart';
import 'package:claxified_app/model/get_nearby_response_model.dart';
import 'package:claxified_app/model/get_pincode_details_response_model.dart';
import 'package:claxified_app/model/get_scooty_brand_response_model.dart';
import 'package:claxified_app/model/get_state_response_model.dart';
import 'package:claxified_app/model/product_list_model/get_vehicle_response_model.dart';
import 'package:claxified_app/model/response_item.dart';
import 'package:claxified_app/theme/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class VehicleFormScreenController extends GetxController {
  int? fuelTypeId;
  int? transmissionId;
  int? ownersId;
  bool modelData = false;
  String fuelType = '';
  String transmissionType = '';
  String owners = '';
  String carModelSelect = "";
  String bikeModelSelect = "";
  ImagePicker picker = ImagePicker();
  List<File> addVehicleImageList = [];
  File? profileImage;

  int? selectedBrandID;
  int? selectedModelID;
  RxBool isLoading = false.obs;
  int confirmLocation = 0;
  String nearBySelect = '';
  String stateSelect = '';
  String citySelect = '';
  String? stateIdSelect;
  String? cityIdSelect;
  bool isValidate = false;

  List fuelTypeList = ["Petrol", "Diesel", "CNG", "Electric"];
  List filteredFuelTypeList = [];
  List transmissionList = ["Manual", "Automatic"];
  List filteredTransmissionList = [];
  List ownersList = ["1", "2", "3", "4"];

  void filterFuelTypes(String? subCategoryName) {
    if (subCategoryName == "Bikes" || subCategoryName == "Scooty") {
      filteredFuelTypeList = ["Petrol", "Electric"];
    } else {
      filteredFuelTypeList = fuelTypeList;
    }
    update();
  }

  void filterTransmissionTypes(String? subCategoryName) {
    // print("Subcategory name: $subCategoryName");
    if (subCategoryName == "Bikes" || subCategoryName == "Scooty") {
      filteredTransmissionList = ["Manual"];
    } else {
      filteredTransmissionList = transmissionList;
    }
    update();
  }

  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController nearByController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController kmsController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController modelController = TextEditingController();

  clearControllerValue(TextEditingController controller) {
    controller.clear();
    update();
  }

  removePhoto(int index) {
    addVehicleImageList.remove(addVehicleImageList[index]);
    update();
  }

  reorderImages(int newIndex, int oldIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final File image = addVehicleImageList.removeAt(oldIndex);
    addVehicleImageList.insert(newIndex, image);
    update();
  }

  ///Car Brand Id

  Future getBrandId({required String value, required String category}) async {
    if (category == 'Cars') {
      for (var element in getCarBrandResponseModel) {
        if (element.brandName == value) {
          selectedBrandID = element.id;
          await getCarModelData(selectedBrandID.toString());
          modelData = true;
          break;
        }
      }
    } else if (category == 'Bikes') {
      for (var element in getBikeBrandResponseModel) {
        if (element.brandName == value) {
          selectedBrandID = element.id;
          await getBikeModelData(selectedBrandID.toString());
          modelData = true;
          break;
        }
      }
    } else if (category == 'Scooty') {
      for (var element in getScootyBrandResponseModel) {
        if (element.brandName == value) {
          selectedBrandID = element.id;
          break;
        }
      }
    } else {
      for (var element in getBicycleBrandResponseModel) {
        if (element.brandName == value) {
          selectedBrandID = element.id;
          break;
        }
      }
    }
    log('carBrandId ---------- >>>>>> $selectedBrandID');
    update();
  }

  /// GET MODEL ID

  Future getModelId({required String value, required String category}) async {
    if (category == 'Cars') {
      for (var element in getCarModelResponseModel) {
        if (element.model == value) {
          selectedModelID = element.id;
        }
      }
    } else if (category == 'Bikes') {
      for (var element in getBikeModelResponseModel) {
        if (element.model == value) {
          selectedModelID = element.id;
        }
      }
    }
    log('ModelId---------->>>>>> $selectedModelID');
    update();
  }

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

  /// PICK MULTI IMAGE
  Future getImages(BuildContext context) async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xFilePick = pickedFile;
    if (xFilePick.isNotEmpty) {
      for (var i = 0; i < xFilePick.length; i++) {
        addVehicleImageList.add(File(xFilePick[i].path));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Nothing is selected')));
    }
    update();
  }

  /// PICK SINGLE IMAGE
  pickImage() async {
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    profileImage = File(file!.path);
    update();
  }

  /// ADD NEW GADGET DATA API
  addVehicleData({required Map<String, dynamic> vehicleData}) async {
    isLoading.value = true;
    ResponseItem result;
    result = await AddVehicleRepo.addVehicleRepo(vehicleData: vehicleData);
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
      log('ERROR====AddVehicleData===>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  /// UPLOAD IMAGE API
  List vehicleImageUrl = [];
  uploadVehicleImages({required List<File> requestData}) async {
    isLoading.value = true;
    ResponseItem result;
    result = await UploadImageVehicleRepo.uploadImagesVehicleRepo(
        requestData: requestData);
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          vehicleImageUrl = result.data;
          update();
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR==== Upload Vehicle Data ===>>>>====>>>>$e');
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

    // isLoading.value = true;
    ResponseItem result;
    result = await GetCityData.getCityData(id);
    try {
      if (result.status) {
        if (result.data != null) {
          // isLoading.value = false;
          getAllCityResponseModel = List<GetAllCityResponseModel>.from(
              result.data.map((x) => GetAllCityResponseModel.fromJson(x)));
          for (var element in getAllCityResponseModel) {
            cityList.add(element.name.toString());
          }
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        // isLoading.value = false;
      }
    } catch (e) {
      log('ERROR=======>>>>====>>>>$e');
      // isLoading.value = false;
    }
    update();
  }

  ///GET NEAR BY DATA
  List<GetAllNearByResponseModel> getAllNearByResponseModel = [];
  List<String> nearByList = [];

  getNearByData(String id) async {
    nearByList = [];
    // isLoading.value = true;
    ResponseItem result;
    result = await GetNearByData.getNearByData(id);
    try {
      if (result.status) {
        if (result.data != null) {
          // isLoading.value = false;
          getAllNearByResponseModel = List<GetAllNearByResponseModel>.from(
              result.data.map((x) => GetAllNearByResponseModel.fromJson(x)));

          for (var element in getAllNearByResponseModel) {
            nearByList.add(element.name.toString());
          }
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        // isLoading.value = false;
      }
    } catch (e) {
      log('ERROR====GetNearByData===>>>>====>>>>$e');
      // isLoading.value = false;
    }
    update();
  }

  ///GET CAR BRAND DATA
  List<GetCarBrandResponseModel> getCarBrandResponseModel = [];
  List<String> carBrandList = [];

  getCarBrandsData() async {
    carBrandList = [];
    isLoading.value = true;
    ResponseItem result;
    result = await GetCarBrandData.getCarBrandData();
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;

          getCarBrandResponseModel = List<GetCarBrandResponseModel>.from(
              result.data.map((x) => GetCarBrandResponseModel.fromJson(x)));

          for (var element in getCarBrandResponseModel) {
            carBrandList.add(element.brandName.toString());
          }
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR===GetMobileData===>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  ///GET CAR MODEL DATA
  List<GetCarModelResponseModel> getCarModelResponseModel = [];
  List<String> carModelList = [];

  getCarModelData(String id) async {
    // getCarModelResponseModel.clear();
    carModelList = [];
    // isLoading.value = true;
    ResponseItem result;
    result = await GetCarModelData.getCarModelData(id);
    try {
      if (result.status) {
        if (result.data != null) {
          // isLoading.value = false;

          getCarModelResponseModel = List<GetCarModelResponseModel>.from(
              result.data.map((x) => GetCarModelResponseModel.fromJson(x)));
          for (var element in getCarModelResponseModel) {
            carModelList.add(element.model.toString());
          }

          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        // isLoading.value = false;
      }
    } catch (e) {
      log('ERROR=======>>>>====>>>>$e');
      // isLoading.value = false;
    }
    update();
  }

  ///GET BIKE BRAND DATA

  List<GetBikeBrandResponseModel> getBikeBrandResponseModel = [];
  List<String> bikeBrandList = [];

  getBikeBrandsData() async {
    bikeBrandList = [];
    isLoading.value = true;
    ResponseItem result;
    result = await GetBikeBrandData.getBikeBrandData();
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          getBikeBrandResponseModel = List<GetBikeBrandResponseModel>.from(
              result.data.map((x) => GetBikeBrandResponseModel.fromJson(x)));

          for (var element in getBikeBrandResponseModel) {
            bikeBrandList.add(element.brandName.toString());
          }
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR===GetMobileData===>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  ///GET Bike MODEL DATA
  List<GetBikeModelResponseModel> getBikeModelResponseModel = [];
  List<String> bikeModelList = [];

  getBikeModelData(String id) async {
    getBikeModelResponseModel.clear();
    bikeModelList = [];
    // isLoading.value = true;
    ResponseItem result;
    result = await GetBikeModelData.getBikeModelData(id);
    try {
      if (result.status) {
        if (result.data != null) {
          // isLoading.value = false;

          getBikeModelResponseModel = List<GetBikeModelResponseModel>.from(
              result.data.map((x) => GetBikeModelResponseModel.fromJson(x)));
          for (var element in getBikeModelResponseModel) {
            bikeModelList.add(element.model.toString());
          }
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        // isLoading.value = false;
      }
      update();
    } catch (e) {
      log('ERROR=======>>>>====>>>>$e');
      // isLoading.value = false;
    }
    update();
  }

  ///GET SCOOTY BRAND DATA

  List<GetScootyBrandResponseModel> getScootyBrandResponseModel = [];
  List<String> scootyBrandList = [];

  getScootyBrandsData() async {
    bikeBrandList = [];
    isLoading.value = true;
    ResponseItem result;
    result = await GetScootyBrandData.getScootyBrandData();
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;

          getScootyBrandResponseModel = List<GetScootyBrandResponseModel>.from(
              result.data.map((x) => GetScootyBrandResponseModel.fromJson(x)));
          for (var element in getScootyBrandResponseModel) {
            scootyBrandList.add(element.brandName.toString());
          }
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR===GetMobileData===>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  ///GET SCOOTY BRAND DATA

  List<GetBicycleBrandResponseModel> getBicycleBrandResponseModel = [];
  List<String> bicycleBrandList = [];

  getBicycleBrandsData() async {
    bicycleBrandList = [];
    isLoading.value = true;
    ResponseItem result;
    result = await GetBicycleBrandData.getBicycleBrandData();
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;

          getBicycleBrandResponseModel =
              List<GetBicycleBrandResponseModel>.from(result.data
                  .map((x) => GetBicycleBrandResponseModel.fromJson(x)));
          for (var element in getBicycleBrandResponseModel) {
            bicycleBrandList.add(element.brandName.toString());
          }
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR===GetMobileData===>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  /// ASSIGN DATA
  List<GetAllVehicleResponseModel> getAllVehicleData = [];
  assignData() async {
    if (getAllVehicleData.isNotEmpty) {
      saveImage(gadgetImageList: getAllVehicleData[0].vehicleImageList);

      /// Pincode Api
      getPincodeData(pincode: getAllVehicleData[0].pincode ?? '');
      titleController.text = getAllVehicleData[0].title ?? '';
      stateController.text = getAllVehicleData[0].state ?? '';
      stateSelect = getAllVehicleData[0].state ?? '';
      cityController.text = getAllVehicleData[0].city ?? '';
      citySelect = getAllVehicleData[0].city ?? '';
      nearByController.text = getAllVehicleData[0].nearBy ?? '';
      nearBySelect = getAllVehicleData[0].nearBy ?? '';
      descriptionController.text = getAllVehicleData[0].discription ?? '';
      priceController.text = getAllVehicleData[0].price.toString() ?? '';
      pinCodeController.text = getAllVehicleData[0].pincode ?? '';
      nameController.text = getAllVehicleData[0].name ?? '';
      phoneController.text = getAllVehicleData[0].mobile ?? '';
      yearController.text = getAllVehicleData[0].year.toString();
      kmsController.text = getAllVehicleData[0].kmDriven.toString();
      selectedBrandID = getAllVehicleData[0].vehicelBrandId;
      selectedModelID = getAllVehicleData[0].modelId;
      fuelTypeId = getAllVehicleData[0].fuelType ?? 0;
      if (getAllVehicleData[0].fuelType != null) {
        fuelType = fuelTypeList[getAllVehicleData[0].fuelType ?? 0];
      }

      if (getAllVehicleData[0].subCategoryId == 5) {
        modelData = true;
        getCarModelData(getAllVehicleData[0].vehicelBrandId.toString());
      } else if (getAllVehicleData[0].subCategoryId == 6) {
        modelData = true;
        getBikeModelData(getAllVehicleData[0].vehicelBrandId.toString());
      }

      transmissionId = getAllVehicleData[0].transmissionType ?? 0;
      if (getAllVehicleData[0].transmissionType != null ||
          getAllVehicleData[0].noOfOwner != 0) {
        transmissionType =
            transmissionList[getAllVehicleData[0].transmissionType! - 1];
      }
      ownersId = getAllVehicleData[0].noOfOwner ?? 0;

      if (getAllVehicleData[0].noOfOwner != null ||
          getAllVehicleData[0].noOfOwner != 0) {
        owners = ownersList[getAllVehicleData[0].noOfOwner! - 1];
      }
    }
    update();
  }

  /// SAVE ASSIGN IMAGES
  saveImage({required List<VehicleImageList>? gadgetImageList}) async {
    gadgetImageList?.forEach((element) async {
      final http.Response response =
          await http.get(Uri.parse(element.imageUrl ?? ''));
      // Get temporary directory
      final dir = await getTemporaryDirectory();

      // Create an image name
      var filename = '${dir.path}/${element.imageUrl?.split('/').last}';

      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);
      log('----xFilePick[i].path----${file.path}');

      addVehicleImageList.add(file);
    });
    update();
  }

  /// UPDATE VEHICLES
  updateVehicleData(
      {required Map<String, dynamic> vehicleData, required String id}) async {
    isLoading.value = true;
    ResponseItem result;
    result = await UpdateVehiclesData.updateVehiclesData(
        updateData: vehicleData, id: id);
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
      log('ERROR ==== Update Vehicle ==== >>>> ==== >>>> $e');
      isLoading.value = false;
    }
    update();
  }

  clearData() {
    fuelTypeId = null;
    transmissionId = null;
    ownersId = null;
    carBrandList = [];
    addVehicleImageList = [];
    stateController.clear();
    cityController.clear();
    nearByController.clear();
    stateSelect = '';
    citySelect = '';
    nearBySelect = '';
    confirmLocation = 0;
    titleController.clear();
    descriptionController.clear();
    priceController.clear();
    pinCodeController.clear();
    nameController.clear();
    phoneController.clear();
    kmsController.clear();
    yearController.clear();
    modelController.clear();
    modelData = false;
  }
}
