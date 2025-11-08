import 'package:flutter/widgets.dart';

class Command<T> extends ChangeNotifier {
  T data;
  bool isLoading;

  Command({required this.data, this.isLoading = false});

  void toggleLoading() {
    isLoading = !isLoading;
    execute();
  }

  void setData(T newData) {
    data = newData;
    execute();
  }

  void execute() => notifyListeners();
}
