// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehhalink/core/helpers/extensions.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/routing/routes.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';
import 'package:sehhalink/core/widgets/app_button.dart';
import 'package:sehhalink/core/widgets/app_text_form_field.dart';
import 'package:sehhalink/features/auth/login/data/models/login_request_body.dart';
import 'package:sehhalink/features/auth/login/presentation/logic/login_cubit.dart';
import 'package:sehhalink/features/auth/login/presentation/logic/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundMain,
        elevation: 0,
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Sehha",
                style: TextStyle(
                  color: AppColors.primaryBlue,
                  fontSize: 18.sp,
                  fontWeight: FontWeightHelper.bold,
                ),
              ),
              TextSpan(
                text: "Link",
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18.sp,
                  fontWeight: FontWeightHelper.bold,
                ),
              ),
            ],
          ),
        ),
        leading: Container(
          margin: EdgeInsets.only(left: 16.w),
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: AppColors.backgroundSoft,
            borderRadius: BorderRadius.circular(36.r),
          ),
          child: IconButton(
            onPressed: () => context.pop(),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primaryBlue,
              size: 18,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace(16),

              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.primaryBlue.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.health_and_safety_outlined,
                  color: AppColors.primaryBlue,
                  size: 30.sp,
                ),
              ),
              verticalSpace(20),

              Text(
                'login.welcome_back'.tr(),
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24.sp,
                  fontWeight: FontWeightHelper.bold,
                ),
              ),
              verticalSpace(8),
              Text(
                'login.subtitle'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14.sp,
                  fontWeight: FontWeightHelper.regular,
                  height: 1.5,
                ),
              ),
              verticalSpace(36),

              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'login.email_label'.tr(),
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14.sp,
                    fontWeight: FontWeightHelper.semiBold,
                  ),
                ),
              ),
              verticalSpace(8),
              AppTextFormField(
                controller: _emailController,
                hintText: 'login.email_hint'.tr(),
                borderRadius: 14.r,
                backgroundColor: AppColors.backgroundSoft,
                enabledBorderColor: AppColors.borderLight,
                focusedBorderColor: AppColors.primaryBlue,
                textStyle: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14.sp,
                ),
                keyboardType: TextInputType.emailAddress,
                label: Icon(
                  Icons.email_outlined,
                  color: AppColors.textLight,
                  size: 20,
                ),
                validator: (val) => val == null || !val.contains('@')
                    ? 'validation.enter_valid_email'.tr()
                    : null,
              ),
              verticalSpace(16),

              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'login.password_label'.tr(),
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14.sp,
                    fontWeight: FontWeightHelper.semiBold,
                  ),
                ),
              ),
              verticalSpace(8),
              AppTextFormField(
                controller: _passwordController,
                hintText: "••••••••",
                borderRadius: 14.r,
                backgroundColor: AppColors.backgroundSoft,
                enabledBorderColor: AppColors.borderLight,
                focusedBorderColor: AppColors.primaryBlue,
                textStyle: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14.sp,
                ),
                obscureText: _obscurePassword,
                label: Icon(
                  Icons.lock_outline_rounded,
                  color: AppColors.textLight,
                  size: 20,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.textLight,
                    size: 20,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
                validator: (val) => val == null || val.length < 6
                    ? 'validation.password_min_chars'.tr()
                    : null,
              ),
              verticalSpace(8),

              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () {
                    context.pushNamed(Routes.forgetPasswordScreen);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'login.forgot_password'.tr(),
                    style: TextStyle(
                      color: AppColors.primaryBlue,
                      fontSize: 13.sp,
                      fontWeight: FontWeightHelper.semiBold,
                    ),
                  ),
                ),
              ),
              verticalSpace(28),

              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginLoaded) {
                    context.pushReplacmentNamed(Routes.navigationScreen);
                  }
                  if (state is LoginFailuer) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errMessage),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    buttonHeight: 56.h,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<LoginCubit>().login(
                          LoginRequestBody(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                      }
                    },
                    backgroundColor: AppColors.primaryBlue,
                    radius: 16.r,
                    child: state is LoginLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'login.log_in_button'.tr(),
                            style: TextStyle(
                              color: AppColors.textWhite,
                              fontSize: 16.sp,
                              fontWeight: FontWeightHelper.semiBold,
                            ),
                          ),
                  );
                },
              ),
              verticalSpace(24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'login.no_account'.tr(),
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14.sp,
                      fontWeight: FontWeightHelper.regular,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.pushNamed(Routes.registerScreen),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'login.create_account'.tr(),
                      style: TextStyle(
                        color: AppColors.primaryBlue,
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.semiBold,
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(16),
            ],
          ),
        ),
      ),
    );
  }
}
