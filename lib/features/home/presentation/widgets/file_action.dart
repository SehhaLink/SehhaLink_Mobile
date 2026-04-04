import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/features/home/domain/entities/upload_file_item.dart';

class FileAction extends StatelessWidget {
  const FileAction({
    super.key,
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
