// ignore_for_file: constant_identifier_names

class AppUrls {
  static const BASE_URL = "https://claxified.in/api/";
  static const PINCODE_URL = "https://api.postalpincode.in/pincode/";
}

class MethodNames {
  static const getAllCategory = "Common/GetAllCategory";
  static const getSubCategory = "Common/GetSubCategory?categoryId=";
  static const getAllDashboardData = "Dashboard/GetAll";
  static const getAllGadgetData = "Gadget/GetAll";
  static const getStateData = "Common/GetAllState?countryId=1";
  static const getCityData = "Common/GetAllCity?stateId=";
  static const getNearByData = "Common/GetAllNearBy?cityId=";
  static const getMobileBrandData = "Gadget/GetAllMobileBrand";
  static const getTabletBrandData = "Gadget/GetAllTabletBrand";
  static const addGadget = "Gadget";
  static const uploadGadgetImage = "Gadget/UploadImages";
  static const authSendOtp = "Auth/SendLoginOTP";
  static const authOtpLogin = "Auth/OTPLogin";
  static const getCarBrandData = "Vehicle/GetCarBrand";
  static const getCarModelData = "Vehicle/GetCarModel?carBrandId=";
  static const addVehicle = "Vehicle";
  static const getBikeBrandData = "Vehicle/GetBikeBrand";
  static const getBikeModelData = "Vehicle/GetBikeModel?bikeBrandId=";
  static const getScootyBrandData = "Vehicle/GetScootyBrand";
  static const getBicycleBrandData = "Vehicle/GetBicycleBrand";
  static const uploadVehicleImage = "Vehicle/UploadImages";
  static const getAllVehicleData = "Vehicle/GetAll";
  static const addPropertyData = "Property";
  static const uploadPropertyImage = "Property/UploadImages";
  static const addJobs = "Job";
  static const uploadJobsImage = "Job/UploadImages";
  static const getAllJobsData = "Job";
  static const getAllPropertyData = "Property";
  static const addFurniture = "Furniture";
  static const uploadFurnitureImage = "Furniture/UploadImages";
  static const getAllFurniture = "Furniture/GetAll";
  static const addBook = "Book";
  static const uploadBookImage = "Book/UploadImages";
  static const getAllBook = "Book";

  static const getAllCommercialService = "CommercialService";
  static const uploadCommercialServiceImage = "CommercialService/UploadImages";
  static const addCommercialService = "CommercialService";

  static const getAllFashion = "Fashion";
  static const uploadFashionImage = "Fashion/UploadImages";
  static const addFashion = "Fashion";

  static const getAllPet = "Pet/GetAll";
  static const uploadPetImage = "Pet/UploadImages";
  static const addPet = "Pet";

  static const getAllSports = "Sport/GetAll";
  static const uploadSportsImage = "Sport/UploadImages";
  static const addSports = "Sport";
  static const addElectronicsData = "ElectricAppliance";
  static const uploadElectronicsImage = "ElectricAppliance/UploadImages";
  static const getAllElectronicsImage = "ElectricAppliance";
  static const getAllAds = "User/GetAllAdsByUserId";

  /// Ref guid
  static const getDashBoardByGuid = "Dashboard/GetDashboardItemByGuid";

  static const getGadgetByGuid = "Gadget/GetGadgetByGuid";
  static const getVehicleByGuid = "Vehicle/GetVehicleByTabRefGuid";
  static const getPropertyByGuid = "Property/GetPropertyByGuid";
  static const getSportByGuid = "Sport/GetByTabRefGuid";
  static const getBookByGuid = "Book/GetByTabRefGuid";
  static const getCommercialServiceByGuid = "CommercialService/GetByTabRefGuid";
  static const getElectricApplianceByGuid = "ElectricAppliance/GetByTabRefGuid";
  static const getFurnitureByGuid = "Furniture/GetByTabRefGuid";
  static const getJobByGuid = "Job/GetByTabRefGuid";
  static const getPetByGuid = "Pet/GetByTabRefGuid";
  static const getFashionByGuid = "Fashion/GetByTabRefGuid";

  /// category Update api

  static const updateGadgets = "Gadget/";
  static const updateVehicles = "Vehicle/";
  static const updateProperty = "Property/";
  static const updateJob = "Job/";
  static const updateElectricAppliance = "ElectricAppliance/";
  static const updateFurniture = "Furniture/";
  static const updateBook = "Book/";
  static const updateSports = "Sport/";
  static const updatePets = "Pet/";
  static const updateFashion = "Fashion/";
  static const updateCommercialService = "CommercialService/";

  ///Ads Delete Api

  static const gadgetsDelete = "Gadget/";
  static const vehicleDelete = "Vehicle/";
  static const propertyDelete = "Property/";
  static const jobDelete = "Job/";
  static const electricApplianceDelete = "ElectricAppliance/";
  static const furnitureDelete = "Furniture/";
  static const bookDelete = "Book/";
  static const sportDelete = "Sport/";
  static const petDelete = "Pet/";
  static const fashionDelete = "Fashion/";
  static const commercialServiceDelete = "CommercialService/";

  /// Add WishList Api

  static const addWishList = "User/AddWishList";
  static const getAllWishList = "User/GetWishlistByUserId";

  /// Feed Back screen

  static const addFeedBack = "User/AddUserFeedback";
}
