import 'package:flutter_bloc/flutter_bloc.dart';

import '../api_services.dart';

class SearchCubit extends Cubit<dynamic> {
  SearchCubit() : super(null);

  void searchProduct(String searchKeyWord) async {
    dynamic products = await fetchProducts(searchKeyWord);
    emit(products);
  }
}
