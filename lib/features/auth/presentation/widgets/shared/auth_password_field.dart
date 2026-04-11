import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/widgets/app_text_form_field.dart';

class AuthPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;
  final Color backgroundColor;
  final Color focusedBorderColor;
  final Color enabledBorderColor;
  final Color iconColor;

  const AuthPasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.backgroundColor = AppColors.backgroundSoft,
    this.focusedBorderColor = AppColors.primaryBlue,
    this.enabledBorderColor = AppColors.borderLight,
    this.iconColor = AppColors.iconGray,
  });

  @override
  State<AuthPasswordField> createState() => _AuthPasswordFieldState();
}

class _AuthPasswordFieldState extends State<AuthPasswordField> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      controller: widget.controller,
      hintText: widget.hintText,
      borderRadius: 14.r,
      backgroundColor: widget.backgroundColor,
      enabledBorderColor: widget.enabledBorderColor,
      focusedBorderColor: widget.focusedBorderColor,
      textStyle: TextStyle(
        color: widget.backgroundColor == AppColors.backgroundSoft
            ? AppColors.textPrimary
            : AppColors.textWhite,
        fontSize: 14.sp,
      ),
      obscureText: !_isVisible,
      label: Icon(Icons.lock_outline_rounded, color: widget.iconColor, size: 20),
      suffixIcon: IconButton(
        icon: Icon(
          _isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: widget.iconColor,
          size: 20,
        ),
        onPressed: () => setState(() => _isVisible = !_isVisible),
      ),
      validator: widget.validator,
    );
  }
}