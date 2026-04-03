import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/features/privacy_and_security/presentation/widgets/action_button.dart';
import 'package:sehhalink/features/privacy_and_security/presentation/widgets/info_box.dart';
import 'package:sehhalink/features/privacy_and_security/presentation/widgets/password_field.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key, required this.isLoading, this.onSubmit});

  final bool isLoading;
  final void Function(String current, String newPass)? onSubmit;

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _currentCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  String? _validationError;

  @override
  void dispose() {
    _currentCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (widget.onSubmit == null) return;
    if (_currentCtrl.text.isEmpty ||
        _newCtrl.text.isEmpty ||
        _confirmCtrl.text.isEmpty) {
      setState(() => _validationError = 'privacy.error_fill_all'.tr());
      return;
    }
    if (_newCtrl.text != _confirmCtrl.text) {
      setState(() => _validationError = 'privacy.error_password_mismatch'.tr());
      return;
    }
    if (_newCtrl.text.length < 8) {
      setState(() => _validationError = 'privacy.error_password_short'.tr());
      return;
    }
    setState(() => _validationError = null);
    widget.onSubmit!(_currentCtrl.text, _newCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onSubmit != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isEnabled)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            margin: EdgeInsets.only(bottom: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F4FF),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: const Color(0xFFB0C4F8), width: 0.5),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 16.sp,
                  color: const Color(0xFF3B5BDB),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'privacy.feature_under_development'.tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF3B5BDB),
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

        InfoBox(
          color: const Color(0xFFE8F4F8),
          textColor: AppColors.primaryBlue,
          message: 'privacy.password_hint'.tr(),
        ),
        verticalSpace(14),
        PasswordField(
          label: 'privacy.current_password'.tr(),
          controller: _currentCtrl,
          obscure: _obscureCurrent,
          onToggle: () => setState(() => _obscureCurrent = !_obscureCurrent),
        ),
        verticalSpace(10),
        PasswordField(
          label: 'privacy.new_password'.tr(),
          controller: _newCtrl,
          obscure: _obscureNew,
          onToggle: () => setState(() => _obscureNew = !_obscureNew),
        ),
        verticalSpace(10),
        PasswordField(
          label: 'privacy.confirm_password'.tr(),
          controller: _confirmCtrl,
          obscure: _obscureConfirm,
          onToggle: () => setState(() => _obscureConfirm = !_obscureConfirm),
        ),
        if (_validationError != null) ...[
          verticalSpace(8),
          Text(
            _validationError!,
            style: TextStyle(fontSize: 12.sp, color: const Color(0xFFEF4444)),
          ),
        ],
        verticalSpace(14),
        ActionButton(
          label: 'privacy.update_password'.tr(),
          isLoading: widget.isLoading,
          color: AppColors.primaryBlue,
          enabled: isEnabled,
          onTap: _submit,
        ),
      ],
    );
  }
}
