import 'package:kintsugi/utils/validators.dart';

enum EmailLoginFormType { signIn, signUp }

class EmailLoginModel with EmailAndPasswordValidators {
  EmailLoginModel({
    this.email = '',
    this.password = '',
    this.formType = EmailLoginFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
  });

  final String email;
  final String password;
  final EmailLoginFormType formType;
  final bool isLoading;
  final bool submitted;

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

  EmailLoginModel copyWith({
    String email,
    String password,
    EmailLoginFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    return EmailLoginModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }
}
