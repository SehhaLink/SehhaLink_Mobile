import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';
import 'package:sehhalink/core/widgets/app_text_form_field.dart';
import 'package:sehhalink/features/auth/presentation/widgets/shared/auth_password_field.dart';
import 'package:sehhalink/features/auth/presentation/widgets/shared/auth_submit_button.dart';

class ForgetPasswordResetSection extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'forgot_password.reset_title'.tr(),
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: 26.sp,
            fontWeight: FontWeightHelper.bold,
          ),
        ),
        verticalSpace(10),
        Text(
          'forgot_password.reset_description'.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textLight, fontSize: 14.sp),
        ),
        verticalSpace(32),
        Form(
          key: formKey,
          child: Column(
            children: [
              // ─── OTP Field ────────────────────────────────
              AppTextFormField(
                controller: otpController,
                borderRadius: 14.r,
                backgroundColor: AppColors.backgroundCard,
                focusedBorderColor: AppColors.primaryBlue.withOpacity(0.6),
                enabledBorderColor: Colors.white.withOpacity(0.08),
                textStyle:
                    TextStyle(color: AppColors.textWhite, fontSize: 14.sp),
                hintText: 'forgot_password.otp_hint'.tr(),
                keyboardType: TextInputType.number,
                suffixIcon: Icon(Icons.pin_rounded,
                    color: AppColors.textLight, size: 20.sp),
                validator: (val) => val == null || val.isEmpty
                    ? 'validation.enter_otp'.tr()
                    : null,
              ),
              verticalSpace(16),

              // ─── New Password ─────────────────────────────
              AuthPasswordField(
                controller: newPasswordController,
                hintText: 'forgot_password.new_password_hint'.tr(),
                backgroundColor: AppColors.backgroundCard,
                focusedBorderColor: AppColors.primaryBlue.withOpacity(0.6),
                enabledBorderColor: Colors.white.withOpacity(0.08),
                iconColor: AppColors.textLight,
                validator: (val) => val == null || val.length < 6
                    ? 'validation.min_6_chars'.tr()
                    : null,
              ),
              verticalSpace(16),

              // ─── Confirm Password ─────────────────────────
              AuthPasswordField(
                controller: confirmPasswordController,
                hintText: 'forgot_password.confirm_password_hint'.tr(),
                backgroundColor: AppColors.backgroundCard,
                focusedBorderColor: AppColors.primaryBlue.withOpacity(0.6),
                enabledBorderColor: Colors.white.withOpacity(0.08),
                iconColor: AppColors.textLight,
                validator: (val) => val != newPasswordController.text
                    ? 'validation.passwords_no_match_short'.tr()
                    : null,
              ),
            ],
          ),
        ),
        verticalSpace(24),
        AuthSubmitButton(
          isLoading: isLoading,
          onPressed: () {
            if (formKey.currentState!.validate()) onSubmit();
          },
          label: 'forgot_password.reset_button'.tr(),
          icon: Icons.check_rounded,
        ),
      ],
    );
  }
}