import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

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

  void submitForm() {
    _formkey.currentState!.save();
    final isValid = _formkey.currentState!.validate();
    if(!isValid){
      return;
    }
  }
  Auth? authmode;
  @override
  Widget build(BuildContext context) {
    authmode ??= ModalRoute.of(context)!.settings.arguments as Auth;
    return Scaffold(
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
                    child: ClipPath(
                      clipper: WaveClipperTwo(flip: true),
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
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                    child: Form(
                      key: _formkey,
                      child: Column(
                      children: [
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
                        ),
                        if(authmode == Auth.signup)
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
                          onPressed: submitForm, child: authmode == Auth.login ? const Text('Login') : const Text('Signup')),
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
                    )),
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