// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';
import 'package:sehhalink/core/widgets/app_text_form_field.dart';

class RegisterFieldsPage1 extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final DateTime? selectedDate;
  final String? selectedGender;
  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<String> onGenderSelected;

  const RegisterFieldsPage1({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.selectedDate,
    required this.selectedGender,
    required this.onDateSelected,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Full Name"),
        verticalSpace(8),
        AppTextFormField(
          controller: fullNameController,
          hintText: "John Doe",
          borderRadius: 14.r,
          backgroundColor: AppColors.backgroundSoft,
          enabledBorderColor: AppColors.borderLight,
          focusedBorderColor: AppColors.primaryBlue,
          textStyle: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
          label: Icon(
            Icons.person_outline_rounded,
            color: AppColors.iconGray,
            size: 20,
          ),
          validator: (val) =>
              val == null || val.isEmpty ? "Enter your full name" : null,
        ),
        verticalSpace(16),

        _buildLabel("Email Address"),
        verticalSpace(8),
        AppTextFormField(
          controller: emailController,
          hintText: "name@example.com",
          borderRadius: 14.r,
          backgroundColor: AppColors.backgroundSoft,
          enabledBorderColor: AppColors.borderLight,
          focusedBorderColor: AppColors.primaryBlue,
          textStyle: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
          keyboardType: TextInputType.emailAddress,
          label: Icon(
            Icons.email_outlined,
            color: AppColors.iconGray,
            size: 20,
          ),
          validator: (val) =>
              val == null || !val.contains('@') ? "Enter a valid email" : null,
        ),
        verticalSpace(16),

        _buildLabel("Birth Date"),
        verticalSpace(8),
        GestureDetector(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime(2000),
              barrierColor: AppColors.primaryBlue,
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: AppColors.primaryBlue,
                      onPrimary: AppColors.textWhite,
                      onSurface: AppColors.textPrimary,
                    ),
                    dialogBackgroundColor: AppColors.backgroundSoft,
                  ),
                  child: child!,
                );
              },
            );
            if (picked != null) onDateSelected(picked);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AppColors.backgroundSoft,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.iconGray,
                  size: 20,
                ),
                SizedBox(width: 12.w),
                Text(
                  selectedDate != null
                      ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                      : "Select your birth date",
                  style: TextStyle(
                    color: selectedDate != null
                        ? AppColors.textPrimary
                        : AppColors.iconGray,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
        verticalSpace(16),

        _buildLabel("Gender"),
        verticalSpace(8),
        Row(
          children: ['Male', 'Female'].map((gender) {
            final isSelected = selectedGender == gender;
            return Expanded(
              child: GestureDetector(
                onTap: () => onGenderSelected(gender),
                child: Container(
                  margin: EdgeInsets.only(right: gender == 'Male' ? 8.w : 0),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryBlue
                        : AppColors.backgroundSoft,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryBlue
                          : AppColors.borderLight,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        gender == 'Male' ? Icons.male : Icons.female,
                        color: isSelected ? Colors.white : AppColors.iconGray,
                        size: 20,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        gender,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : AppColors.textPrimary,
                          fontSize: 14.sp,
                          fontWeight: FontWeightHelper.semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
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
