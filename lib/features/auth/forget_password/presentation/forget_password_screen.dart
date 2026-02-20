// forget_password_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehhalink/core/helpers/extensions.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';
import 'package:sehhalink/features/auth/forget_password/data/models/reset_password_model.dart';
import 'package:sehhalink/features/auth/forget_password/presentation/logic/forget_password_cubit.dart';
import 'package:sehhalink/features/auth/forget_password/presentation/logic/forget_password_state.dart';
import 'package:sehhalink/features/auth/forget_password/presentation/widgets/forget_password_email_section.dart';
import 'package:sehhalink/features/auth/forget_password/presentation/widgets/forget_password_header_icon.dart';
import 'package:sehhalink/features/auth/forget_password/presentation/widgets/forget_password_reset_section.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ForgetPasswordView();
  }
}

class _ForgetPasswordView extends StatefulWidget {
  const _ForgetPasswordView();

  @override
  State<_ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<_ForgetPasswordView> {
  final _emailFormKey = GlobalKey<FormState>();
  final _resetFormKey = GlobalKey<FormState>();

  // ── Controllers in UI ──
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _showResetFields = false;

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.only(left: 16.w),
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: AppColors.backgroundCard,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: IconButton(
            onPressed: () => context.pop(),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primaryCyan,
              size: 18,
            ),
          ),
        ),
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Sehha",
                style: TextStyle(
                  color: AppColors.primaryCyan,
                  fontSize: 18.sp,
                  fontWeight: FontWeightHelper.bold,
                ),
              ),
              TextSpan(
                text: "Link",
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 18.sp,
                  fontWeight: FontWeightHelper.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ForgetPasswordSuccess) {
            setState(() => _showResetFields = true);
          } else if (state is ForgetPasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.redAccent,
              ),
            );
          } else if (state is ResetPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password reset successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            context.pop();
          } else if (state is ResetPasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading =
              state is ForgetPasswordLoading || state is ResetPasswordLoading;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              children: [
                const ForgetPasswordHeaderIcon(),
                verticalSpace(32),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.15),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  ),
                  child: _showResetFields
                      ? ForgetPasswordResetSection(
                          key: const ValueKey('reset'),
                          isLoading: isLoading,
                          formKey: _resetFormKey,
                          otpController: _otpController,
                          newPasswordController: _newPasswordController,
                          confirmPasswordController: _confirmPasswordController,
                          onSubmit: () {
                            context.read<ForgetPasswordCubit>().resetPassword(
                              ResetPasswordModel(
                                email: context
                                    .read<ForgetPasswordCubit>()
                                    .userEmail,
                                otp: _otpController.text,
                                newPassword: _newPasswordController.text,
                                confirmNewPassword:
                                    _confirmPasswordController.text,
                              ),
                            );
                          },
                        )
                      : ForgetPasswordEmailSection(
                          key: const ValueKey('email'),
                          isLoading: isLoading,
                          formKey: _emailFormKey,
                          emailController: _emailController,
                          onSubmit: () {
                            context.read<ForgetPasswordCubit>().forgetPassword(
                              _emailController.text,
                            );
                          },
                        ),
                ),
                verticalSpace(32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Remember Password? ",
                      style: TextStyle(
                        color: AppColors.textGrayLight,
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.regular,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: AppColors.primaryCyan,
                          fontSize: 14.sp,
                          fontWeight: FontWeightHelper.semiBold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
