import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/architecture/achitecture.dart';

enum HomeStatus { initial, loading, error, success }

class HomeViewModel extends ChangeNotifier {
  final AddUserUsecase addUserUsecase;

  HomeViewModel({required this.addUserUsecase});

  HomeStatus _status = HomeStatus.initial;

  HomeStatus get status => _status;

  void setStatus(HomeStatus status) {
    _status = status;
    notifyListeners();
  }

  Future<bool> saveUser(User value) async {
    setStatus(HomeStatus.loading);

    final result = await addUserUsecase.call(value);

    return result.fold(
      (failure) {
        setStatus(HomeStatus.error);
        return false;
      },
      (success) {
        setStatus(HomeStatus.success);
        return true;
      },
    );
  }
}
