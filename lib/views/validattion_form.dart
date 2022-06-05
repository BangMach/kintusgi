import 'package:flutter/material.dart';

import '../main2.dart';

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
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter your username',
      ),
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is require';
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter your email',
      ),
    );
  }

  Widget _buildText() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Job is require';
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter your Job',
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
              _buildEmail(),
              const SizedBox(height: 50),
              _buildText(),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () => {

                  Navigator.push(_formKey.currentContext, MaterialPageRoute(builder: (context){
                    return MyApp();
                  }))
                },
                child: const Text(
                  "NextPage",
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
