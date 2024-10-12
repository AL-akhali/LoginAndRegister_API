import 'dart:convert';
import 'package:ecommerce/modules/auth_screens/auth_cubit/auth_states.dart';
import 'package:ecommerce/shared/network/local_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AuthCubit extends Cubit<AuthStates>{
  AuthCubit() : super(AuthInitialState());

  void register({
    required String name,
    required String email,
    required String phone,
    required String password,
  })
  async{
    emit(RegisterLoadingState());
    Response response = await http.post(
      Uri.parse("https://student.valuxapps.com/api/register"),
      headers:
      {
        'lang' : "ar"
      },
      body:
        {
          'name' : name,
          'email' : email,
          'phone' : phone,
          'password' : password,
        }
    ) ;
    var responseBody = jsonDecode(response.body);
    if(responseBody['status'] == true)
    {
      print(responseBody);
      emit(RegisterSuccessState());
    }
    else
      {
        print(responseBody);
        emit(FailedToRegisterState(message: responseBody['message']));
      }
  }

  void login({
    required String email,
    required String password,
  })
  async
  {
    emit(LoginLoadingState());
    try {
      Response response = await http.post(
          Uri.parse("https://student.valuxapps.com/api/login"),
          body: {
            'email': email,
            'password': password,
          }
      );
      if(response.statusCode == 200)
        {
          var data = jsonDecode(response.body);
          if(data['status']==true)
            {
              debugPrint('User Login success and his Data is :$data');
              await CacheNetwork.InsertToCache(key: "token", value: data['data']['token']);
              emit(LoginSuccessState());
            }
          else
            {
              debugPrint('Failed to login , reason is :${data['message']}');
              emit(FailedToLoginState(message:data['message'] ));
            }
        }
    }
    catch(e){
      emit(FailedToLoginState(message:e.toString()));
    }
  }
}
