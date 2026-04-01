import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehhalink/core/helpers/extensions.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/routing/routes.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/widgets/app_button.dart';
import 'package:sehhalink/features/auth/register/data/models/register_request_body.dart';
import 'package:sehhalink/features/auth/register/presentation/logic/register_cubit.dart';
import 'package:sehhalink/features/auth/register/presentation/logic/register_state.dart';
import 'package:sehhalink/features/auth/register/presentation/widgets/register_fileds_page1.dart';
import 'package:sehhalink/features/auth/register/presentation/widgets/register_fileds_page2.dart';

class RegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const RegisterForm({super.key, required this.formKey});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final PageController _pageController = PageController();
  final _page1Key = GlobalKey<FormState>();
  final _page2Key = GlobalKey<FormState>();
  int _currentPage = 0;

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final ageController = TextEditingController();

  DateTime? _selectedDate;
  String? _selectedGender;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _nextPage() {
    if (_page1Key.currentState!.validate()) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentPage = 1);
    }
  }

  void _prevPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() => _currentPage = 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildProgressIndicator(),
        verticalSpace(24),

        SizedBox(
          height: 420.h,
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Form(
                key: _page1Key,
                child: RegisterFieldsPage1(
                  fullNameController: fullNameController,
                  emailController: emailController,
                  selectedDate: _selectedDate,
                  selectedGender: _selectedGender,
                  onDateSelected: (date) =>
                      setState(() => _selectedDate = date),
                  onGenderSelected: (gender) =>
                      setState(() => _selectedGender = gender),
                ),
              ),
              Form(
                key: _page2Key,
                child: RegisterFieldsPage2(
                  phoneNumberController: phoneNumberController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
                  obscurePassword: _obscurePassword,
                  obscureConfirmPassword: _obscureConfirmPassword,
                  onTogglePassword: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  onToggleConfirmPassword: () => setState(
                    () => _obscureConfirmPassword = !_obscureConfirmPassword,
                  ),
                ),
              ),
            ],
          ),
        ),

        verticalSpace(24),
        _buildButtons(context),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      children: List.generate(2, (index) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            height: 4.h,
            decoration: BoxDecoration(
              color: index <= _currentPage
                  ? AppColors.primaryBlue
                  : AppColors.borderLight,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildButtons(BuildContext context) {
    if (_currentPage == 0) {
      return AppButton(
        buttonHeight: 56.h,
        onPressed: _nextPage,
        backgroundColor: AppColors.primaryBlue,
        radius: 16.r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'register.next_button'.tr(),
              style: TextStyle(color: AppColors.textWhite, fontSize: 16.sp),
            ),
            SizedBox(width: 8.w),
            Icon(Icons.arrow_forward, color: AppColors.textWhite, size: 20),
          ],
        ),
      );
    }

    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) context.pushNamed(Routes.loginScreen);
        if (state is RegisterError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
      },
      builder: (context, state) {
        return Row(
          children: [
            OutlinedButton(
              onPressed: _prevPage,
              style: OutlinedButton.styleFrom(
                minimumSize: Size(56.w, 56.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                side: BorderSide(color: AppColors.primaryBlue),
              ),
              child: Icon(Icons.arrow_back, color: AppColors.primaryBlue),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: AppButton(
                buttonHeight: 56.h,
                onPressed: () {
                  if (_page2Key.currentState!.validate()) {
                    context.read<RegisterCubit>().register(
                      RegisterRequestBody(
                        fullName: fullNameController.text,
                        email: emailController.text,
                        phoneNumber: phoneNumberController.text,
                        password: passwordController.text,
                        confirmPassword: confirmPasswordController.text,
                        birthDate: _selectedDate != null
                            ? "${_selectedDate!.year.toString().padLeft(4, '0')}-"
                                  "${_selectedDate!.month.toString().padLeft(2, '0')}-"
                                  "${_selectedDate!.day.toString().padLeft(2, '0')}"
                            : null,
                        gender: _selectedGender,
                      ),
                    );
                  }
                },
                backgroundColor: AppColors.primaryBlue,
                radius: 16.r,
                child: state is RegisterLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'register.sign_up_button'.tr(),
                        style: TextStyle(
                          color: AppColors.textWhite,
                          fontSize: 16.sp,
                        ),
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
