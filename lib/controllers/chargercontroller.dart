import 'package:get/get.dart';

class Chargercontroller extends GetxController {
  var chargers = <String>[].obs;
  var isLoading = false.obs;
  var selectedCharger = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchChargers();
  }

  void fetchChargers() {
    isLoading.value = true;
    try {
      // Add your API call or data fetching logic here
      chargers.value = ['Charger 1', 'Charger 2', 'Charger 3'];
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch chargers');
    } finally {
      isLoading.value = false;
    }
  }

  void selectCharger(String charger) {
    selectedCharger.value = charger;
  }

  void clearSelection() {
    selectedCharger.value = '';
  }
}
