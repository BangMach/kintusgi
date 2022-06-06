import 'package:flutter/material.dart';
import 'package:kintsugi/widgets/common/custom_elevated_button.dart';

class FormSubmitButton extends CustomElevatedButton {
  FormSubmitButton({
    @required String text,
    @required VoidCallback onPressed,
    bool isLoading: false,
  }) : super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 20.0,
                width: 20.0,
              ),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 20.0,
                child: Opacity(
                  opacity: isLoading ? 1.0 : 0.0,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          height: 40.0,
          color: onPressed != null ? Colors.indigo : null,
          borderRadius: 4.0,
          onPressed: onPressed,
        );
}
