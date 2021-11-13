import 'package:flutter/material.dart';
import 'package:hoblist/helpers/db_helpers.dart';
import 'package:hoblist/httpexception.dart';
import 'package:hoblist/model/user.dart';

class Authprovider extends ChangeNotifier {
  User? _user;

  User get getuser {
    return _user!;
  }


  Future<void> login(String email , String password) async {
    try{
      final existingUsers = await DBhelpers.fetchuser('User', email, password);
      if(existingUsers.isEmpty){
        throw HttpException('Invalid username or password');
      }
      _user = User(
        id: existingUsers[0]['id'], 
        name: existingUsers[0]['name'], 
        email: existingUsers[0]['email'], 
        phoneNumber: existingUsers[0]['phone_number'], 
        profession: existingUsers[0]['profession']);
      notifyListeners();
    }
    catch(error){
      throw error;
    }
  }

  Future<void> signUp(User user, String password) async {
    try {
      await DBhelpers.insert('User', {
        'id' : user.id,
        'name' : user.name,
        'email' : user.email,
        'phone_number' : user.phoneNumber,
        'profession' : user.profession,
        'password' : password
      });
      _user = User(
        id: user.id, 
        name: user.name, 
        email: user.email, 
        phoneNumber: user.phoneNumber, 
        profession: user.profession);
      notifyListeners();
    }
    catch(error){
      throw error;
    }
  }
}