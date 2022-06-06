import 'package:flutter/material.dart';

class FormValidation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormVadidationState();
  }
}

class FormVadidationState extends State<FormValidation> {
  final _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Name is require';
        }
        return null;
      },
      // onSaved: (value) {
      //   _name =;
      // },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Tên Đăng Nhập',
      ),
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is require';
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Nhập mật khẩu',
      ),
    );
  }

  Widget _buildPasswordAgain() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is require';
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Xác nhận mật Khẩu',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Form(
          key: _formKey,
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            padding: const EdgeInsets.all(20),
            children: <Widget>[
              _buildName(),
              const SizedBox(height: 50),
              _buildPassword(),
              const SizedBox(height: 50),
              _buildPasswordAgain(),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () => {
                  Navigator.push(_formKey.currentContext,
                      MaterialPageRoute(builder: (context) {
                    return MyApp();
                  }))
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    height: 1.5,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
