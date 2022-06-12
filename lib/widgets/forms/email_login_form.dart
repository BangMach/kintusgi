import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:kintsugi/models/email_login_change_model.dart';
import 'package:kintsugi/services/auth.dart';
import 'package:kintsugi/widgets/custom/form_submit_button.dart';
import 'package:kintsugi/widgets/custom/show_exception_alert_dialog.dart';
import 'package:provider/provider.dart';

class EmailLoginForm extends StatefulWidget {
  EmailLoginForm({
    Key key,
    @required this.model,
  }) : super(key: key);

  final EmailLoginChangeModel model;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<EmailLoginChangeModel>(
      create: (_) => EmailLoginChangeModel(auth: auth),
      child: Consumer<EmailLoginChangeModel>(
        builder: (_, model, __) => EmailLoginForm(model: model),
      ),
    );
  }

  @override
  _EmailLoginFormState createState() => _EmailLoginFormState();
}

class _EmailLoginFormState extends State<EmailLoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  EmailLoginChangeModel get model => widget.model;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    try {
      await model.submit();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Login failed',
        exception: e,
      );
    }
  }

  void _emailEditingComplete() {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;

    FocusScope.of(context).requestFocus(newFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildForm(),
      ),
    );
  }

  List<Widget> _buildForm() {
    return [
      _buildEmailTextField(),
      SizedBox(height: 8.0),
      _buildPasswordTextField(),
      SizedBox(height: 16.0),
      FormSubmitButton(
        text: model.primaryButtonText,
        onPressed: model.canSubmit ? submit : null,
        isLoading: model.isLoading,
      ),
      SizedBox(height: 8.0),
      TextButton(
        child: Text(model.secondaryButtonText),
        onPressed: model.isLoading ? null : model.toggleFormType,
      ),
    ];
  }

  TextField _buildEmailTextField() {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        errorText: model.showEmailErrorText,
        enabled: !model.isLoading,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: model.updateEmail,
      onEditingComplete: () => _emailEditingComplete(),
    );
  }

  TextField _buildPasswordTextField() {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: model.showPasswordErrorText,
        enabled: !model.isLoading,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: model.updatePassword,
      onEditingComplete: submit,
    );
  }
}
