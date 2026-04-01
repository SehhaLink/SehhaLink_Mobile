import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/current_user/domain/entity/user_file.dart';
import 'package:sehhalink/core/theme/app_colors.dart';

class FileIconWidget extends StatelessWidget {
  final UserFile file;
  final bool isImage;

  const FileIconWidget({super.key, required this.file, required this.isImage});

  @override
  Widget build(BuildContext context) {
    if (isImage) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Image.file(
          File(file.filePath),
          width: 52.w,
          height: 52.w,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) =>
              _iconBox(Icons.image_rounded, AppColors.primaryBlue),
        ),
      );
    }

    final type = file.fileType.toLowerCase();
    if (type == 'pdf') return _iconBox(Icons.picture_as_pdf_rounded, Colors.redAccent);
    if (type == 'doc' || type == 'docx') return _iconBox(Icons.description_rounded, AppColors.primaryBlue);
    if (type == 'xls' || type == 'xlsx') return _iconBox(Icons.table_chart_rounded, AppColors.successGreen);
    return _iconBox(Icons.insert_drive_file_rounded, AppColors.accentOrange);
  }

  Widget _iconBox(IconData icon, Color color) {
    return Container(
      width: 52.w,
      height: 52.w,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(icon, color: color, size: 26.sp),
    );
  }
}