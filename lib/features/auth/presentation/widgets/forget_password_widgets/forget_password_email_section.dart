// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';
import 'package:sehhalink/core/widgets/app_text_form_field.dart';
import 'package:sehhalink/features/auth/presentation/widgets/shared/auth_submit_button.dart';

class ForgetPasswordEmailSection extends StatelessWidget {
  final bool isLoading;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final VoidCallback onSubmit;

  const ForgetPasswordEmailSection({
    super.key,
    required this.isLoading,
    required this.formKey,
    required this.emailController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'forgot_password.title'.tr(),
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: 26.sp,
            fontWeight: FontWeightHelper.bold,
          ),
        ),
        verticalSpace(10),
        Text(
          'forgot_password.description'.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textLight, fontSize: 14.sp),
        ),
        verticalSpace(32),
        Form(
          key: formKey,
          child: AppTextFormField(
            controller: emailController,
            borderRadius: 14.r,
            backgroundColor: AppColors.backgroundCard,
            focusedBorderColor: AppColors.primaryBlue.withOpacity(0.6),
            enabledBorderColor: Colors.white.withOpacity(0.08),
            textStyle: TextStyle(color: AppColors.textWhite, fontSize: 14.sp),
            hintText: 'forgot_password.email_hint'.tr(),
            suffixIcon: Icon(
              Icons.alternate_email_rounded,
              color: AppColors.textLight,
              size: 20.sp,
            ),
            validator: (val) => val == null || !val.contains('@')
                ? 'validation.enter_valid_email'.tr()
                : null,
          ),
        ),
        verticalSpace(24),
        AuthSubmitButton(
          isLoading: isLoading,
          onPressed: () {
            if (formKey.currentState!.validate()) onSubmit();
          },
          label: 'forgot_password.send_otp'.tr(),
          icon: Icons.arrow_forward_rounded,
        ),
      ],
    );
  }
}