// register_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehhalink/core/helpers/extensions.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/routing/routes.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';
import 'package:sehhalink/core/widgets/app_button.dart';
import 'package:sehhalink/features/auth/register/data/models/register_request_body.dart';
import 'package:sehhalink/features/auth/register/presentation/logic/register_cubit.dart';
import 'package:sehhalink/features/auth/register/presentation/logic/register_state.dart';
import 'package:sehhalink/features/auth/register/presentation/widgets/caregiver_checkbox.dart';
import 'package:sehhalink/features/auth/register/presentation/widgets/register_fields.dart';

class RegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const RegisterForm({super.key, required this.formKey});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isCaregiver = false;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Fields ──
          RegisterFields(
            fullNameController: fullNameController,
            emailController: emailController,
            phoneNumberController: phoneNumberController,
            passwordController: passwordController,
            obscurePassword: _obscurePassword,
            onTogglePassword: () =>
                setState(() => _obscurePassword = !_obscurePassword),
          ),
          verticalSpace(20),

          CaregiverCheckbox(
            isCaregiver: _isCaregiver,
            onTap: () => setState(() => _isCaregiver = !_isCaregiver),
          ),
          verticalSpace(28),

          // ── Sign Up Button ──
          BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                context.pushNamed(Routes.loginScreen);
              }
              if (state is RegisterError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              }
            },
            builder: (context, state) {
              return AppButton(
                buttonHeight: 56.h,
                onPressed: () {
                  if (widget.formKey.currentState!.validate()) {
                    context.read<RegisterCubit>().register(
                          RegisterRequestBody(
                            email: emailController.text,
                            phoneNumber: phoneNumberController.text,
                            password: passwordController.text,
                            fullName: fullNameController.text,
                          ),
                        );
                  }
                },
                backgroundColor: AppColors.primaryBlue,
                radius: 16.r,
                child: state is RegisterLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign Up",
                            style: TextStyle(
                              color: AppColors.textWhite,
                              fontSize: 16.sp,
                              fontWeight: FontWeightHelper.semiBold,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(Icons.arrow_forward,
                              color: AppColors.textWhite, size: 20),
                        ],
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
