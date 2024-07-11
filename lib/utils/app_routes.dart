import 'package:claxified_app/ui/BottomBarScreen/Screens/ProfileScreen/feed_back_screen.dart';
import 'package:claxified_app/ui/BottomBarScreen/Screens/ProfileScreen/manage_ads_screen.dart';
import 'package:claxified_app/ui/BottomBarScreen/Screens/ProfileScreen/my_wishlist_screen.dart';
import 'package:claxified_app/ui/BottomBarScreen/Screens/ProfileScreen/personal_information_screen.dart';
import 'package:claxified_app/ui/BottomBarScreen/bottom_bar_screen.dart';
import 'package:claxified_app/ui/AuthScreen/splash_screen.dart';
import 'package:claxified_app/ui/BottomBarScreen/Screens/home_screen.dart';
import 'package:claxified_app/ui/FormScreen/Book/book_form_screen.dart';
import 'package:claxified_app/ui/FormScreen/Furniture/furniture_form_screen.dart';
import 'package:claxified_app/ui/FormScreen/CommercialServices/commercial_services_form_screen.dart';
import 'package:claxified_app/ui/FormScreen/Fashion/fashion_form_screen.dart';
import 'package:claxified_app/ui/FormScreen/Electronics/electronics_form_screen.dart';
import 'package:claxified_app/ui/FormScreen/Gadget/gadget_form_screen.dart';
import 'package:claxified_app/ui/FormScreen/Jobs/jobs_form_screen.dart';
import 'package:claxified_app/ui/FormScreen/Pet/pet_form_screen.dart';
import 'package:claxified_app/ui/FormScreen/Properties/properties_form_screen.dart';
import 'package:claxified_app/ui/FormScreen/Sports/sports_form_screen.dart';
import 'package:claxified_app/ui/FormScreen/Vehicle/vehicle_form_screen.dart';
import 'package:claxified_app/ui/ProductScreen/Books/book_details_screen.dart';
import 'package:claxified_app/ui/ProductScreen/Books/book_product_screen.dart';
import 'package:claxified_app/ui/ProductScreen/Furniture/furniture_details_screen.dart';
import 'package:claxified_app/ui/ProductScreen/Furniture/furniture_product_screen.dart';
import 'package:claxified_app/ui/ProductScreen/CommercialServices/comercial_services_details_screen.dart';
import 'package:claxified_app/ui/ProductScreen/CommercialServices/comercial_services_product_screen.dart';
import 'package:claxified_app/ui/ProductScreen/Fashion/fashion_details_screen.dart';
import 'package:claxified_app/ui/ProductScreen/Fashion/fashion_product_screen.dart';
import 'package:claxified_app/ui/ProductScreen/Electronics/electronics_details_screen.dart';
import 'package:claxified_app/ui/ProductScreen/Electronics/electronics_product_screen.dart';
import 'package:claxified_app/ui/ProductScreen/Gadget/gadget_details_screen.dart';
import 'package:claxified_app/ui/ProductScreen/Gadget/gadget_product_screen.dart';
import 'package:claxified_app/ui/ProductScreen/Jobs/jobs_details_screen.dart';
import 'package:claxified_app/ui/ProductScreen/Jobs/jobs_product_screen.dart';
import 'package:claxified_app/ui/ProductScreen/Pet/pet_details_screen.dart';
import 'package:claxified_app/ui/ProductScreen/Pet/pet_product_screen.dart';
import 'package:claxified_app/ui/ProductScreen/Properties/properties_details_screen.dart';
import 'package:claxified_app/ui/ProductScreen/Properties/properties_product_screen.dart';
import 'package:claxified_app/ui/ProductScreen/Sports/sports_details_screen.dart';
import 'package:claxified_app/ui/ProductScreen/Sports/sports_product_screen.dart';
import 'package:claxified_app/ui/ProductScreen/Vehicle/vehicle_details_screen.dart';
import 'package:claxified_app/ui/ProductScreen/Vehicle/vehicle_product_screen.dart';
import 'package:claxified_app/ui/SelectCategoryScreen/select_category_screen_grid.dart';
import 'package:claxified_app/ui/LocationScreen/location_screen.dart';
import 'package:claxified_app/ui/SelectCategoryScreen/select_category_screen_list.dart';
import 'package:claxified_app/ui/SelectCategoryScreen/select_sub_categories_screen.dart';

import 'package:get/get.dart';

class Routes {
  static String splashScreen = "/";
  static String loginScreen = "/loginScreen";
  static String bottomBarScreen = "/bottomBarScreen";
  static String homeScreen = "/homeScreen";
  static String gadgetProductScreen = "/gadgetProductScreen";
  static String gadgetFormScreen = "/gadgetFormScreen";
  static String gadgetDetailsScreen = "/gadgetDetailsScreen";
  static String vehicleProductScreen = "/vehicleProductScreen";
  static String vehicleFormScreen = "/vehicleFormScreen";
  static String vehicleDetailsScreen = "/vehicleDetailsScreen";
  static String productDetailScreen = "/productDetailScreen";
  static String selectCategoryScreenList = "/selectCategoryScreenList";
  static String locationScreen = "/locationScreen";
  static String selectSubCategoriesScreen = "/selectSubCategoriesScreen";
  static String propertiesProductScreen = "/propertiesProductScreen";
  static String propertiesDetailsScreen = "/propertiesDetailScreen";
  static String jobsProductScreen = "/jobsProductScreen";
  static String propertiesFormScreen = "/propertiesFormScreen";
  static String jobsFormScreen = "/jobsFormScreen";
  static String selectCategoryScreenGrid = "/selectCategoryScreenGrid";
  static String jobsDetailsScreen = "/jobsDetailsScreen";
  static String electronicsFormScreen = "/electronicsFormScreen";
  static String electronicsProductScreen = "/electronicsProductScreen";
  static String electronicsDetailsScreen = "/electronicsDetailsScreen";
  static String furnitureFormScreen = "/furnitureFormScreen";
  static String furnitureProductScreen = "/furnitureProductScreen";
  static String furnitureDetailsScreen = "/furnitureDetailsScreen";
  static String bookFormScreen = "/bookFormScreen";
  static String bookProductScreen = "/bookProductScreen";
  static String bookDetailsScreen = "/bookDetailsScreen";
  static String commercialServicesDetailsScreen =
      "/commercialServicesDetailsScreen";
  static String commercialServicesProductScreen =
      "/commercialServicesProductScreen";
  static String commercialServicesFormScreen = "/commercialServicesFormScreen";
  static String fashionDetailsScreen = "/fashionDetailsScreen";
  static String fashionProductScreen = "/fashionProductScreen";
  static String fashionFormScreen = "/fashionFormScreen";
  static String petDetailsScreen = "/petDetailsScreen";
  static String petProductScreen = "/petProductScreen";
  static String petFormScreen = "/petFormScreen";
  static String sportsDetailsScreen = "/sportsDetailsScreen";
  static String sportsProductScreen = "/sportsProductScreen";
  static String sportsFormScreen = "/sportsFormScreen";
  static String manageAdsScreen = "/manageAdsScreen";
  static String personalInformationScreen = "/personalInformationScreen";
  static String myWishListScreen = "/myWishListScreen";
  static String addFeedBackScreen = "/addFeedBackScreen";

  static List<GetPage> routes = [
    GetPage(
        name: splashScreen,
        page: () => const SplashScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: bottomBarScreen,
        page: () => const BottomBarScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: homeScreen,
        page: () => const HomeScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: gadgetProductScreen,
        page: () => const GadgetProductScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: vehicleProductScreen,
        page: () => const VehicleProductScreen(),
        transition: Transition.leftToRight),
    // GetPage(
    //     name: productDetailScreen,
    //     page: () => const ProductDetailScreen(),
    //     transition: Transition.leftToRight),
    GetPage(
        name: selectCategoryScreenList,
        page: () => const SelectCategoryScreenList(),
        transition: Transition.leftToRight),
    GetPage(
        name: locationScreen,
        page: () => const LocationScreen(),
        transition: Transition.downToUp),
    GetPage(
        name: selectSubCategoriesScreen,
        page: () => const SelectSubCategoriesScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: gadgetFormScreen,
        page: () => const GadgetFormScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: vehicleFormScreen,
        page: () => const VehicleFormScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: propertiesFormScreen,
        page: () => const PropertiesFormScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: selectCategoryScreenGrid,
        page: () => const SelectCategoryScreenGrid(),
        transition: Transition.leftToRight),
    GetPage(
        name: vehicleDetailsScreen,
        page: () => const VehicleDetailsScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: gadgetDetailsScreen,
        page: () => const GadgetDetailsScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: propertiesProductScreen,
        page: () => const PropertiesProductScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: propertiesDetailsScreen,
        page: () => const PropertiesDetailScree(),
        transition: Transition.leftToRight),
    GetPage(
        name: jobsFormScreen,
        page: () => const JobsFormScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: jobsProductScreen,
        page: () => const JobsProductScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: jobsDetailsScreen,
        page: () => const JobsDetailsScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: electronicsFormScreen,
        page: () => const ElectronicsFormScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: electronicsProductScreen,
        page: () => const ElectronicsProductScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: electronicsDetailsScreen,
        page: () => const ElectronicsDetailsScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: furnitureFormScreen,
        page: () => const FurnitureFormScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: furnitureProductScreen,
        page: () => const FurnitureProductScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: furnitureDetailsScreen,
        page: () => const FurnitureDetailsScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: bookFormScreen,
        page: () => const BookFormScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: bookProductScreen,
        page: () => const BookProductScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: bookDetailsScreen,
        page: () => const BookDetailsScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: commercialServicesProductScreen,
        page: () => const CommercialServicesProductScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: commercialServicesDetailsScreen,
        page: () => const CommercialServicesDetailsScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: commercialServicesFormScreen,
        page: () => const CommercialServicesFormScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: fashionProductScreen,
        page: () => const FashionProductScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: fashionDetailsScreen,
        page: () => const FashionDetailsScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: fashionFormScreen,
        page: () => const FashionFormScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: petProductScreen,
        page: () => const PetProductScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: petDetailsScreen,
        page: () => const PetDetailsScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: petFormScreen,
        page: () => const PetFormScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: sportsProductScreen,
        page: () => const SportProductScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: sportsDetailsScreen,
        page: () => const SportDetailsScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: sportsFormScreen,
        page: () => const SportsFormScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: manageAdsScreen,
        page: () => const ManageAdsScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: personalInformationScreen,
        page: () => const PersonalInformationScreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: myWishListScreen,
        page: () => const MyWishListScreen(),
        transition: Transition.leftToRight),

    GetPage(
        name: addFeedBackScreen,
        page: () => const AddFeedBackScreen(),
        transition: Transition.leftToRight),
  ];
}
