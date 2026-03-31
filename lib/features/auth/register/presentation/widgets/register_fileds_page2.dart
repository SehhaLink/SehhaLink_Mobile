// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';
import 'package:sehhalink/core/widgets/app_text_form_field.dart';

class RegisterFieldsPage2 extends StatelessWidget {
  final TextEditingController phoneNumberController;
  final TextEditingController ageController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onToggleConfirmPassword;

  const RegisterFieldsPage2({
    super.key,
    required this.phoneNumberController,
    required this.ageController,
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
        _buildLabel("Phone Number"),
        verticalSpace(8),
        AppTextFormField(
          controller: phoneNumberController,
          hintText: "+1 (555) 000-0000",
          borderRadius: 14.r,
          backgroundColor: AppColors.backgroundSoft,
          enabledBorderColor: AppColors.borderLight,
          focusedBorderColor: AppColors.primaryBlue,
          textStyle: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
          keyboardType: TextInputType.phone,
          label: Icon(Icons.phone_outlined, color: AppColors.iconGray, size: 20),
          validator: (val) => val == null || val.isEmpty ? "Enter your phone number" : null,
        ),
        verticalSpace(16),

        _buildLabel("Age"),
        verticalSpace(8),
        AppTextFormField(
          controller: ageController,
          hintText: "25",
          borderRadius: 14.r,
          backgroundColor: AppColors.backgroundSoft,
          enabledBorderColor: AppColors.borderLight,
          focusedBorderColor: AppColors.primaryBlue,
          textStyle: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
          keyboardType: TextInputType.number,
          label: Icon(Icons.cake_outlined, color: AppColors.iconGray, size: 20),
          validator: (val) {
            if (val == null || val.isEmpty) return "Enter your age";
            final age = int.tryParse(val);
            if (age == null || age < 1 || age > 120) return "Enter a valid age";
            return null;
          },
        ),
        verticalSpace(16),

        _buildLabel("Password"),
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
              ? "Password must be at least 6 characters"
              : null,
        ),
        verticalSpace(16),

        _buildLabel("Confirm Password"),
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
            if (val == null || val.length < 6) return "Password must be at least 6 characters";
            if (val != passwordController.text) return "Passwords do not match";
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