import 'package:flutter/cupertino.dart';

import '../../async_value.dart';
import '../../data/model/pancake.dart';
import '../../data/repository/pancake_repo.dart';

class Pancakeprovider extends ChangeNotifier {
  final PancakeRepository _repository;
  AsyncValue<List<Pancake>>? pancakesState;

  Pancakeprovider(this._repository) {
    fetchUsers();
  }

  bool get isLoading =>
      pancakesState != null && pancakesState!.state == AsyncValueState.loading;
  bool get hasData =>
      pancakesState != null && pancakesState!.state == AsyncValueState.success;

  void fetchUsers() async {
    try {
      pancakesState = AsyncValue.loading();
      notifyListeners();

      pancakesState = AsyncValue.success(await _repository.getPancakes());
      print("SUCCESS: list size ${pancakesState!.data!.length.toString()}");
    } catch (error) {
      print("ERROR: $error");
      pancakesState = AsyncValue.error(error);
    }

    notifyListeners();
  }

  void addPancake(String color, double price) async {
    await _repository.addPancake(color: color, price: price);
    fetchUsers();
  }

  void deletePancake(String id) async {
    await _repository.deletePancake(pancakeId: id);
    fetchUsers();
  }
}
