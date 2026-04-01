// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';
import 'package:sehhalink/core/widgets/app_text_form_field.dart';

class RegisterFieldsPage2 extends StatelessWidget {
  final TextEditingController phoneNumberController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onToggleConfirmPassword;

  const RegisterFieldsPage2({
    super.key,
    required this.phoneNumberController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.onTogglePassword,
    required this.onToggleConfirmPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('register.phone_label'.tr()),
        verticalSpace(8),
        AppTextFormField(
          controller: phoneNumberController,
          hintText: 'register.phone_hint'.tr(),
          borderRadius: 14.r,
          backgroundColor: AppColors.backgroundSoft,
          enabledBorderColor: AppColors.borderLight,
          focusedBorderColor: AppColors.primaryBlue,
          textStyle: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
          keyboardType: TextInputType.phone,
          label: Icon(Icons.phone_outlined, color: AppColors.iconGray, size: 20),
          validator: (val) => val == null || val.isEmpty
              ? 'validation.enter_phone'.tr()
              : null,
        ),
        verticalSpace(16),

        _buildLabel('register.password_label'.tr()),
        verticalSpace(8),
        AppTextFormField(
          controller: passwordController,
          hintText: "••••••••",
          borderRadius: 14.r,
          backgroundColor: AppColors.backgroundSoft,
          enabledBorderColor: AppColors.borderLight,
          focusedBorderColor: AppColors.primaryBlue,
          textStyle: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
          obscureText: obscurePassword,
          label: Icon(Icons.lock_outline_rounded, color: AppColors.iconGray, size: 20),
          suffixIcon: IconButton(
            icon: Icon(
              obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: AppColors.iconGray,
              size: 20,
            ),
            onPressed: onTogglePassword,
          ),
          validator: (val) => val == null || val.length < 6
              ? 'validation.password_min_chars'.tr()
              : null,
        ),
        verticalSpace(16),

        _buildLabel('register.confirm_password_label'.tr()),
        verticalSpace(8),
        AppTextFormField(
          controller: confirmPasswordController,
          hintText: "••••••••",
          borderRadius: 14.r,
          backgroundColor: AppColors.backgroundSoft,
          enabledBorderColor: AppColors.borderLight,
          focusedBorderColor: AppColors.primaryBlue,
          textStyle: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
          obscureText: obscureConfirmPassword,
          label: Icon(Icons.lock_outline_rounded, color: AppColors.iconGray, size: 20),
          suffixIcon: IconButton(
            icon: Icon(
              obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: AppColors.iconGray,
              size: 20,
            ),
            onPressed: onToggleConfirmPassword,
          ),
          validator: (val) {
            if (val == null || val.length < 6) return 'validation.password_min_chars'.tr();
            if (val != passwordController.text) return 'validation.passwords_no_match'.tr();
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.semiBold,
      ),
    );
  }
}