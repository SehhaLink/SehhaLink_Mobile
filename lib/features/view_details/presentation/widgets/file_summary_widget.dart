import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';

class FileSummaryWidget extends StatefulWidget {
  final String summary;
  const FileSummaryWidget({super.key, required this.summary});

  @override
  State<FileSummaryWidget> createState() => _FileSummaryWidgetState();
}

class _FileSummaryWidgetState extends State<FileSummaryWidget> {
  bool _expanded = false;
  static const int _summaryLimit = 120;

  @override
  Widget build(BuildContext context) {
    final isLong = widget.summary.length > _summaryLimit;
    final displayedSummary = (!_expanded && isLong)
        ? '${widget.summary.substring(0, _summaryLimit)}...'
        : widget.summary;

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
          displayedSummary,
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