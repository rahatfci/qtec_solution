import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<int> {
  CartCubit() : super(0);

  void increment() {
    emit(state + 1);
  }

  void decrement() {
    if (state > 0) {
      emit(state - 1);
    }
  }
}
