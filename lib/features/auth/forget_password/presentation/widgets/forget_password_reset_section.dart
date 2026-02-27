// forget_password_reset_section.dart
// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';
import 'package:sehhalink/core/widgets/app_button.dart';
import 'package:sehhalink/core/widgets/app_text_form_field.dart';

class ForgetPasswordResetSection extends StatefulWidget {
  final bool isLoading;
  final GlobalKey<FormState> formKey;
  final TextEditingController otpController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onSubmit;

  const ForgetPasswordResetSection({
    super.key,
    required this.isLoading,
    required this.formKey,
    required this.otpController,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.onSubmit,
  });

  @override
  State<ForgetPasswordResetSection> createState() =>
      _ForgetPasswordResetSectionState();
}

class _ForgetPasswordResetSectionState
    extends State<ForgetPasswordResetSection> {
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Reset Password",
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: 26.sp,
            fontWeight: FontWeightHelper.bold,
          ),
        ),
        verticalSpace(10),
        Text(
          "Enter the OTP sent to your email\nand set your new password.",
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textLight, fontSize: 14.sp),
        ),
        verticalSpace(32),
        Form(
          key: widget.formKey,
          child: Column(
            children: [
              // OTP
              AppTextFormField(
                controller: widget.otpController,
                borderRadius: 14.r,
                backgroundColor: AppColors.backgroundCard,
                focusedBorderColor: AppColors.primaryBlue.withOpacity(0.6),
                enabledBorderColor: Colors.white.withOpacity(0.08),
                textStyle: TextStyle(color: AppColors.textWhite, fontSize: 14.sp),
                hintText: "123456",
                keyboardType: TextInputType.number,
                suffixIcon: Icon(Icons.pin_rounded,
                    color: AppColors.textLight, size: 20.sp),
                validator: (val) =>
                    val == null || val.isEmpty ? "Enter OTP" : null,
              ),
              verticalSpace(16),

              // New Password
              AppTextFormField(
                controller: widget.newPasswordController,
                borderRadius: 14.r,
                backgroundColor: AppColors.backgroundCard,
                focusedBorderColor: AppColors.primaryBlue.withOpacity(0.6),
                enabledBorderColor: Colors.white.withOpacity(0.08),
                textStyle: TextStyle(color: AppColors.textWhite, fontSize: 14.sp),
                hintText: "New Password",
                obscureText: !_isNewPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isNewPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.textLight,
                    size: 20,
                  ),
                  onPressed: () => setState(
                      () => _isNewPasswordVisible = !_isNewPasswordVisible),
                ),
                validator: (val) => val == null || val.length < 6
                    ? "Min 6 characters"
                    : null,
              ),
              verticalSpace(16),

              // Confirm Password
              AppTextFormField(
                controller: widget.confirmPasswordController,
                borderRadius: 14.r,
                backgroundColor: AppColors.backgroundCard,
                focusedBorderColor: AppColors.primaryBlue.withOpacity(0.6),
                enabledBorderColor: Colors.white.withOpacity(0.08),
                textStyle: TextStyle(color: AppColors.textWhite, fontSize: 14.sp),
                hintText: "Confirm Password",
                obscureText: !_isConfirmPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.textLight,
                    size: 20,
                  ),
                  onPressed: () => setState(() =>
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                ),
                validator: (val) => val != widget.newPasswordController.text
                    ? "Passwords don't match"
                    : null,
              ),
            ],
          ),
        ),
        verticalSpace(24),
        AppButton(
          onPressed: widget.isLoading
              ? null
              : () {
                  if (widget.formKey.currentState!.validate()) widget.onSubmit();
                },
          backgroundColor: AppColors.primaryBlue,
          radius: 16.r,
          buttonHeight: 56.h,
          child: widget.isLoading
              ? SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: const CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Reset Password",
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 16.sp,
                        fontWeight: FontWeightHelper.semiBold,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(Icons.check_rounded, color: Colors.white, size: 20.sp),
                  ],
                ),
        ),
      ],
    );
  }
}