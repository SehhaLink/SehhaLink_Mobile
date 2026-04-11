import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehhalink/core/helpers/extensions.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';
import 'package:sehhalink/features/auth/data/model/reset_password_model.dart';
import 'package:sehhalink/features/auth/presentation/logic/auth_cubit.dart';
import 'package:sehhalink/features/auth/presentation/logic/auth_state.dart';
import 'package:sehhalink/features/auth/presentation/widgets/forget_password_widgets/forget_password_email_section.dart';
import 'package:sehhalink/features/auth/presentation/widgets/forget_password_widgets/forget_password_header_icon.dart';
import 'package:sehhalink/features/auth/presentation/widgets/forget_password_widgets/forget_password_reset_section.dart';

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
      backgroundColor: AppColors.backgroundMain,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundMain,
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
              color: AppColors.primaryBlue,
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
                  color: AppColors.primaryBlue,
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
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.forgetPasswordEmailSent) {
            setState(() => _showResetFields = true);
          } else if (state.status == AuthStatus.resetPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('forgot_password.password_reset_success'.tr()),
                backgroundColor: Colors.green,
              ),
            );
            context.pop();
          } else if (state.status == AuthStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? ''),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.status == AuthStatus.loading;

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
                            context.read<AuthCubit>().resetPassword(
                              ResetPasswordModel(
                                email: context.read<AuthCubit>().state.userEmail ?? '',
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
                            context.read<AuthCubit>().forgetPassword(
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
                      'forgot_password.remember_password'.tr(),
                      style: TextStyle(
                        color: AppColors.textLight,
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.regular,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Text(
                        'forgot_password.login_link'.tr(),
                        style: TextStyle(
                          color: AppColors.primaryBlue,
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