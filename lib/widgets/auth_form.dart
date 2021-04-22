import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Function _submitAuthForm;
  const AuthForm(
    this._submitAuthForm, {
    Key key,
  }) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _formKey = GlobalKey<FormState>();
  var _formData = {
    'email': '',
    'username': '',
    'password': '',
  };
  var _isLogin = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _onSave() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState.save();

    print(_formData);
    widget._submitAuthForm(_formData, _isLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        key: ValueKey('email'),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'must enter a valid email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _formData['email'] = value;
                        },
                      ),
                      if (!_isLogin)
                        TextFormField(
                          key: ValueKey('username'),
                          decoration: InputDecoration(labelText: 'Username'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'must not be empty';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _formData['username'] = value;
                          },
                        ),
                      TextFormField(
                        key: ValueKey('password'),
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value.length < 6) {
                            return 'must be bigger than 6';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _formData['password'] = value;
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: Theme.of(context).buttonTheme.shape),
                        child: Text(_isLogin ? 'Login' : 'Signup'),
                        onPressed: () {
                          _onSave();
                        },
                      ),
                      TextButton(
                        child: Text(_isLogin
                            ? 'Create new account'
                            : 'Already have an account'),
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                      )
                    ],
                  ),
                ))),
      ),
    );
  }
}