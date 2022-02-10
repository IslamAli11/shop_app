import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/network/endpiont.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit(): super(InitialSearchState());

static  SearchCubit get(context)=> BlocProvider.of(context);
  SearchModel? model;
void searchData(String? text){

  emit(LoadingSearchState());
  DioHelper.postData(
      url:SEARCH,
      token: token,
      data:{
        'text':text,
      }
  ).then((value) {
    model = SearchModel.fromJson(value.data);
    emit(SuccessSearchState());

  }).catchError((error){
    emit(ErrorSearchState());
  });

}


}