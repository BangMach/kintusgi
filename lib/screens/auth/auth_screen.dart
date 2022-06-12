import 'package:flutter/material.dart';
import 'package:kintsugi/widgets/forms/email_login_form.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({
    Key key,
    @required this.isLoading,
  }) : super(key: key);

  final bool isLoading;

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => AuthScreen(
          isLoading: isLoading.value,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _buildBackground(),
          _buildBody(context),
        ],
      ),
    );
  }

  Container _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFCF8BF3),
            Color(0xFFFDB99B),
            Color(0xFFFF5F6D),
          ],
        ),
      ),
    );
  }

  Padding _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ChangeNotifierProvider(
            create: (_) => ValueNotifier<bool>(false),
            child: Consumer<ValueNotifier<bool>>(
              builder: (_, showForm, __) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/core/circular-logo.png',
                    height: 240,
                  ),
                  SizedBox(height: 20),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: EmailLoginForm.create(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
