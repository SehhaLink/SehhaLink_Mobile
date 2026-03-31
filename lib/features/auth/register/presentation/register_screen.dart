import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/helpers/extensions.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';
import 'package:sehhalink/features/auth/register/presentation/widgets/register_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

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
            color: AppColors.backgroundSoft, // ✅ soft gra card
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
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create Account",
              style: TextStyle(
                color: AppColors.textPrimary, // ✅
                fontWeight: FontWeightHelper.bold,
                fontSize: 24.sp,
              ),
            ),
            verticalSpace(8),
            Text(
              "Join SehhaLink to manage your health and your loved ones with smart insights.",
              style: TextStyle(
                color: AppColors.textSecondary, 
                fontSize: 14.sp,
                fontWeight: FontWeightHelper.regular,
              ),
            ),
            verticalSpace(24),
            RegisterForm(formKey: _formKey),
          ],
        ),
      ),
    );
  }
}