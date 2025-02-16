
import 'package:get/get.dart';
import 'package:wastenot/utils/https/network_manager.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies(){
    Get.put(NetworkManager());
  }
}