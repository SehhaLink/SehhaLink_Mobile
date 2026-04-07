// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';

class GeneralSummaryCard extends StatefulWidget {
  const GeneralSummaryCard({
    super.key,
    required this.summary,
    required this.isLoading,
    required this.onExpand,
    required this.onRefresh,
    required this.isFromCache,
  });

  final String? summary;
  final bool isLoading;
  final VoidCallback onExpand;
  final VoidCallback onRefresh;
  final bool isFromCache;

  @override
  State<GeneralSummaryCard> createState() => _GeneralSummaryCardState();
}

class _GeneralSummaryCardState extends State<GeneralSummaryCard> {
  bool _isExpanded = false;

  void _toggle() {
    if (!_isExpanded && widget.summary == null) {
      widget.onExpand();
    }
    setState(() => _isExpanded = !_isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.primaryBlue.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: _toggle,
            borderRadius: BorderRadius.circular(16.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F4F8),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.auto_awesome_outlined,
                      color: AppColors.primaryBlue,
                      size: 18.sp,
                    ),
                  ),
                  horizontalSpace(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'home.general_summary_title'.tr(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeightHelper.semiBold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        verticalSpace(2),
                        Text(
                          'home.general_summary_sub'.tr(),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.25 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.primaryBlue,
                      size: 22.sp,
                    ),
                  ),
                  if (_isExpanded &&
                      widget.summary != null &&
                      !widget.isLoading)
                    GestureDetector(
                      onTap: widget.onRefresh,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Icon(
                          Icons.refresh_rounded,
                          color: AppColors.primaryBlue,
                          size: 20.sp,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: _isExpanded
                ? Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7FBFD),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16.r),
                        bottomRight: Radius.circular(16.r),
                      ),
                      border: Border(
                        top: BorderSide(
                          color: AppColors.primaryBlue.withOpacity(0.1),
                          width: 0.5,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.all(16.r),
                    child: widget.isLoading
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              child: SizedBox(
                                width: 20.r,
                                height: 20.r,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.primaryBlue,
                                ),
                              ),
                            ),
                          )
                        : widget.summary != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (widget.isFromCache) ...[
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 8.h,
                                  ),
                                  margin: EdgeInsets.only(bottom: 12.h),
                                  decoration: BoxDecoration(
                                    color: AppColors.accentOrange.withOpacity(
                                      0.08,
                                    ),
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: AppColors.accentOrange.withOpacity(
                                        0.35,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.wifi_off_rounded,
                                        size: 14.sp,
                                        color: AppColors.accentOrange,
                                      ),
                                      horizontalSpace(8),
                                      Expanded(
                                        child: Text(
                                          'home.summary_cached_hint'.tr(),
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: AppColors.accentOrange,
                                            fontWeight: FontWeightHelper.medium,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              Text(
                                widget.summary!,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: AppColors.textPrimary,
                                  height: 1.7,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            'home.general_summary_empty'.tr(),
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: AppColors.textSecondary,
                              height: 1.7,
                            ),
                          ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
