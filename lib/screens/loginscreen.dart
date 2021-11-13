import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:hoblist/hextocolor.dart';
import 'package:hoblist/httpexception.dart';
import 'package:hoblist/model/user.dart';
import 'package:hoblist/provider/authprovider.dart';
import 'package:hoblist/screens/mainscreen.dart';
import 'package:provider/provider.dart';

enum Auth {
  login,
  signup
}

class Loginscreen extends StatefulWidget{
  const Loginscreen({Key? key}) : super(key: key);

  static const routename = '/loginscreen';
  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _formkey = GlobalKey<FormState>();
  final FocusNode _namefocusnode =  FocusNode();
  final FocusNode _emailfocusnode = FocusNode();
  final FocusNode _phonefocusnode = FocusNode();
  final FocusNode _professionfocusnode = FocusNode();
  final FocusNode _passwordfocusnode = FocusNode();
  final TextEditingController _passwordcontroller = TextEditingController();
  User _user = User(
    id: DateTime.now().toString(), 
    name: '', 
    email: '', 
    phoneNumber: '', 
    profession: '');
  String? errormessage;
  bool isLoading = false;

  Future<void> submitForm() async{
    _formkey.currentState!.save();
    final isValid = _formkey.currentState!.validate();
    if(!isValid){
      return;
    }
    setState(() {
        isLoading = true;
      });
    try{
      if(authmode == Auth.login){
        await Provider.of<Authprovider>(context, listen: false).login(_user.email!, _passwordcontroller.text);
      }
      else {
        await Provider.of<Authprovider>(context, listen: false).signUp(_user, _passwordcontroller.text);
      }
      Navigator.of(context).pushNamed(Mainscreen.routename);
    }
    on HttpException catch(error){
      errormessage = error.message;
    }
    catch(error){
      final extractederror = error.toString();
      if(extractederror.contains('UNIQUE')){
        errormessage = 'Email already used';
      }
      else{
        errormessage = 'An error occurred. try again';
      }
    }
    setState(() {
      isLoading = false;
    });
  }
  Auth? authmode;
  @override
  Widget build(BuildContext context) {
    authmode ??= ModalRoute.of(context)!.settings.arguments as Auth;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraint){
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      color: Colors.blue,
                      padding: const EdgeInsets.only(top: 30, left: 15, bottom: 70),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(authmode == Auth.login ? 'Welcome' : 'Create', style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24
                          ),),
                          Text(authmode == Auth.login ? 'Back' : 'Account', style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24
                          ),)
                        ],
                      )
                    ),
                  ),
                  ClipPath(
                    clipper: WaveClipperTwo(flip: true, reverse: true),
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
                      child: Form(
                        key: _formkey,
                        child: Container(
                          padding: const EdgeInsets.only(top: 50),
                          child: Column(
                          children: [
                            if(errormessage != null)
                            Container(
                              constraints: const BoxConstraints(
                                  minHeight: 25, minWidth: double.infinity),
                              decoration: BoxDecoration(
                                color: hextocolor('#faeef5')
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.close, color: hextocolor('#f2b6ba'),),
                                    const SizedBox(width: 10,),
                                    Flexible(
                                      child: Text('$errormessage',
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false, 
                                      style: TextStyle(
                                        color: hextocolor('#f2b6ba'),
                                        fontWeight: FontWeight.bold
                                  ),),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if(authmode == Auth.signup)
                            TextFormField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              focusNode: _namefocusnode,
                              onFieldSubmitted: (value){
                                if(authmode == Auth.login){
                                  FocusScope.of(context).requestFocus(_passwordfocusnode);
                                }
                                else if(authmode == Auth.signup){
                                  FocusScope.of(context).requestFocus(_emailfocusnode);
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Name',
                              ),
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'field cannot be empty';
                                }
                                return null;
                              },
                              onSaved: (value){
                                _user = User(
                                  id: _user.id, 
                                  name: value, 
                                  email: _user.email, 
                                  phoneNumber: _user.phoneNumber, 
                                  profession: _user.profession);
                              },
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              focusNode: _emailfocusnode,
                              onFieldSubmitted: (value){
                                FocusScope.of(context).requestFocus(_phonefocusnode);
                              },
                              decoration: const InputDecoration(
                                hintText: 'Email',
                              ),
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'field cannot be empty';
                                }
                                return null;
                              },
                              onSaved: (value){
                                _user = User(
                                  id: _user.id, 
                                  name: _user.name, 
                                  email: value,
                                  phoneNumber: _user.phoneNumber, 
                                  profession: _user.profession);
                              },
                            ),
                            if(authmode == Auth.signup)
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                focusNode: _phonefocusnode,
                                onFieldSubmitted: (value){
                                FocusScope.of(context).requestFocus(_professionfocusnode);
                              },
                                decoration: const InputDecoration(
                                hintText: 'Phone number',
                              ),
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'field cannot be empty';
                                }
                                return null;
                              },
                              onSaved: (value){
                                _user = User(
                                  id: _user.id, 
                                  name: _user.name, 
                                  email: _user.email,
                                  phoneNumber: value, 
                                  profession: _user.profession);
                              },
                            ),
                            if(authmode == Auth.signup)
                            TextFormField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              focusNode: _professionfocusnode,
                              onFieldSubmitted: (value){
                                FocusScope.of(context).requestFocus(_passwordfocusnode);
                              },
                              decoration: const InputDecoration(
                                hintText: 'Profession',
                              ),
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'field cannot be empty';
                                }
                                return null;
                              },
                              onSaved: (value){
                                _user = User(
                                  id: _user.id, 
                                  name: _user.name,
                                  email: _user.email, 
                                  phoneNumber: _user.phoneNumber, 
                                  profession: value);
                              },
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              focusNode: _passwordfocusnode,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                              ),
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'field cannot be empty';
                                }
                                return null;
                              },
                              controller: _passwordcontroller,
                            ),
                            const SizedBox(height: 8,),
                            if(authmode == Auth.login)
                            const Align(
                              alignment: Alignment.topRight,
                              child: Text('Forget Password?')),
                            const SizedBox(height: 10,),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                minimumSize: const Size(100, 40)
                              ),
                              onPressed: submitForm, child: isLoading ? const SizedBox(
                                  child: CircularProgressIndicator(color: Colors.white), 
                                  height: 30,
                                  width: 30,) 
                                  : authmode == Auth.login ? const Text('Login') : const Text('Signup')),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                authmode == Auth.login ? const Text('Don\'t have an account?') : const Text('Already have an account?'),
                                TextButton(onPressed: (){
                                  if(authmode == Auth.login){
                                    setState(() {
                                      authmode = Auth.signup;
                                      _formkey.currentState!.reset();
                                      FocusScope.of(context).unfocus();
                                    });
                                  }
                                  else{
                                    setState(() {
                                      authmode = Auth.login;
                                      _formkey.currentState!.reset();
                                      FocusScope.of(context).unfocus();
                                    });
                                  }
                                }, child: authmode == Auth.login ? const Text('Signup') : const Text('Login'))
                              ],
                            )
                          ],
                      ),
                        )),
                    ),
                  )
                ],
                  ),
              ),
            ),
          );
        },
        
      ),
    );
  }
}