import 'package:flutter/foundation.dart';
import 'package:kintsugi/models/email_login_model.dart';
import 'package:kintsugi/services/auth.dart';
import 'package:kintsugi/utils/validators.dart';

class EmailLoginChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  EmailLoginChangeModel({
    @required this.auth,
    this.email = '',
    this.password = '',
    this.formType = EmailLoginFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
  });

  final AuthBase auth;

  String email;
  String password;
  EmailLoginFormType formType;
  bool isLoading;
  bool submitted;

  String get primaryButtonText {
    return formType == EmailLoginFormType.signIn
        ? 'Login'
        : 'Create an account';
  }

  String get secondaryButtonText {
    return formType == EmailLoginFormType.signIn
        ? 'Don\'t have an account? Register'
        : 'Already have an account? Login';
  }

  bool get canSubmit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  String get showEmailErrorText {
    final showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? invalidEmailErrorText : null;
  }

  String get showPasswordErrorText {
    final showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  void toggleFormType() {
    final _formType = this.formType == EmailLoginFormType.signIn
        ? EmailLoginFormType.signUp
        : EmailLoginFormType.signIn;

    updateWith(
      email: '',
      password: '',
      formType: _formType,
      isLoading: false,
      submitted: false,
    );
  }

  void updateEmail(String email) => updateWith(email: email);

  void updatePassword(String password) => updateWith(password: password);

  Future<void> submit() async {
    updateWith(
      submitted: true,
      isLoading: true,
    );
    try {
      if (formType == EmailLoginFormType.signIn) {
        await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void updateWith({
    String email,
    String password,
    EmailLoginFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }
}
