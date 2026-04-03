import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/current_user/presentation/logic/current_user_cubit.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';

class FileSummaryWidget extends StatefulWidget {
  final String fileId;
  final String? summary; // nullable دلوقتي
  final bool isLoading;

  const FileSummaryWidget({
    super.key,
    required this.fileId,
    required this.summary,
    required this.isLoading,
  });

  @override
  State<FileSummaryWidget> createState() => _FileSummaryWidgetState();
}

class _FileSummaryWidgetState extends State<FileSummaryWidget> {
  bool _expanded = false;
  static const int _summaryLimit = 120;

  @override
  Widget build(BuildContext context) {
    // لو loading
    if (widget.isLoading) {
      return _SummaryLoadingWidget();
    }

    // لو مفيش summary — اعرض الزرار
    if (widget.summary == null || widget.summary!.isEmpty) {
      return _GetSummaryButton(fileId: widget.fileId);
    }

    // عرض الـ summary
    final isLong = widget.summary!.length > _summaryLimit;
    final displayed = (!_expanded && isLong)
        ? '${widget.summary!.substring(0, _summaryLimit)}...'
        : widget.summary!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 3.w,
              height: 14.h,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            horizontalSpace(8),
            Text(
              'Summary',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeightHelper.semiBold,
                color: AppColors.primaryBlue,
              ),
            ),
          ],
        ),
        verticalSpace(8),
        Text(
          displayed,
          style: TextStyle(
            fontSize: 13.sp,
            color: AppColors.textSecondary,
            height: 1.6,
            fontWeight: FontWeightHelper.regular,
          ),
        ),
        if (isLong) ...[
          verticalSpace(8),
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Row(
              children: [
                Text(
                  _expanded ? 'View less' : 'View more',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeightHelper.semiBold,
                    color: AppColors.primaryBlue,
                  ),
                ),
                horizontalSpace(4),
                Icon(
                  _expanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 16.sp,
                  color: AppColors.primaryBlue,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _GetSummaryButton extends StatelessWidget {
  final String fileId;
  const _GetSummaryButton({required this.fileId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<CurrentUserCubit>().summarizeFile(fileId),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.primaryBlue.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: AppColors.primaryBlue.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.auto_awesome_rounded,
              size: 15.sp,
              color: AppColors.primaryBlue,
            ),
            horizontalSpace(8),
            Text(
              'Get AI Summary',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeightHelper.semiBold,
                color: AppColors.primaryBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 14.sp,
          height: 14.sp,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primaryBlue,
          ),
        ),
        horizontalSpace(10),
        Text(
          'Generating summary...',
          style: TextStyle(
            fontSize: 13.sp,
            color: AppColors.textSecondary,
            fontWeight: FontWeightHelper.regular,
          ),
        ),
      ],
    );
  }
}
