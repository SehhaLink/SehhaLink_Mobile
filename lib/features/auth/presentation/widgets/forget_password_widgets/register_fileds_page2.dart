import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';
import 'package:sehhalink/core/widgets/app_text_form_field.dart';
import 'package:sehhalink/features/auth/presentation/widgets/shared/auth_password_field.dart';

class RegisterFieldsPage2 extends StatelessWidget {
  final TextEditingController phoneNumberController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const RegisterFieldsPage2({
    super.key,
    required this.phoneNumberController,
    required this.passwordController,
    required this.confirmPasswordController,
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
        AuthPasswordField(
          controller: passwordController,
          hintText: '••••••••',
          validator: (val) => val == null || val.length < 6
              ? 'validation.password_min_chars'.tr()
              : null,
        ),
        verticalSpace(16),

        _buildLabel('register.confirm_password_label'.tr()),
        verticalSpace(8),
        AuthPasswordField(
          controller: confirmPasswordController,
          hintText: '••••••••',
          validator: (val) {
            if (val == null || val.length < 6) {
              return 'validation.password_min_chars'.tr();
            }
            if (val != passwordController.text) {
              return 'validation.passwords_no_match'.tr();
            }
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