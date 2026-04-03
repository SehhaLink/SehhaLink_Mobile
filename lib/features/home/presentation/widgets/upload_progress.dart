// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';
import 'package:sehhalink/features/home/domain/entities/upload_file_item.dart';

class FileProgressCard extends StatelessWidget {
  const FileProgressCard({
    super.key,
    required this.file,
    this.onCancel,
    this.onRetry,
    this.onRemove,
  });

  final UploadedFileItem file;
  final VoidCallback? onCancel;
  final VoidCallback? onRetry;
  final VoidCallback? onRemove;

  Color get _statusColor {
    switch (file.status) {
      case UploadStatus.done:
        return AppColors.successGreen;
      case UploadStatus.failed:
        return const Color(0xFFEF4444);
      case UploadStatus.uploading:
        return AppColors.primaryBlue;
    }
  }

  IconData get _fileIcon {
    final ext = file.name.split('.').last.toLowerCase();
    if (ext == 'pdf') return Icons.picture_as_pdf_outlined;
    if (['jpg', 'jpeg', 'png'].contains(ext)) return Icons.image_outlined;
    return Icons.insert_drive_file_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F4F8),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(_fileIcon, color: AppColors.primaryBlue, size: 22.sp),
          ),
          horizontalSpace(12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        file.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeightHelper.semiBold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    horizontalSpace(8),
                    _StatusBadge(status: file.status),
                  ],
                ),
                verticalSpace(6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: LinearProgressIndicator(
                    value: file.progress,
                    minHeight: 4.h,
                    backgroundColor: AppColors.backgroundSoft,
                    valueColor: AlwaysStoppedAnimation<Color>(_statusColor),
                  ),
                ),
                verticalSpace(4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      file.size,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeightHelper.regular,
                      ),
                    ),
                    Text(
                      '${(file.progress * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: _statusColor,
                        fontWeight: FontWeightHelper.semiBold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          horizontalSpace(10),
          _FileAction(
            status: file.status,
            onCancel: onCancel,
            onRetry: onRetry,
            onRemove: onRemove,
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final UploadStatus status;

  @override
  Widget build(BuildContext context) {
    late Color bg;
    late Color fg;
    late String label;

    switch (status) {
      case UploadStatus.done:
        bg = const Color(0xFFDCFCE7);
        fg = AppColors.successGreen;
        label = 'home.status_done'.tr();
        break;
      case UploadStatus.failed:
        bg = const Color(0xFFFEE2E2);
        fg = const Color(0xFFEF4444);
        label = 'home.status_failed'.tr();
        break;
      case UploadStatus.uploading:
        bg = const Color(0xFFE8F4F8);
        fg = AppColors.primaryBlue;
        label = 'home.status_uploading'.tr();
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeightHelper.semiBold,
          color: fg,
        ),
      ),
    );
  }
}

class _FileAction extends StatelessWidget {
  const _FileAction({
    required this.status,
    this.onCancel,
    this.onRetry,
    this.onRemove,
  });

  final UploadStatus status;
  final VoidCallback? onCancel;
  final VoidCallback? onRetry;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case UploadStatus.uploading:
        return GestureDetector(
          onTap: onCancel,
          child: Icon(
            Icons.close_rounded,
            color: AppColors.textSecondary,
            size: 20.sp,
          ),
        );
      case UploadStatus.done:
        return Icon(
          Icons.check_circle_rounded,
          color: AppColors.successGreen,
          size: 22.sp,
        );
      case UploadStatus.failed:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: onRetry,
              child: Icon(
                Icons.refresh_rounded,
                color: const Color(0xFFEF4444),
                size: 22.sp,
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: onRemove,
              child: Icon(
                Icons.close_rounded,
                color: AppColors.textSecondary,
                size: 20.sp,
              ),
            ),
          ],
        );
    }
  }
}
