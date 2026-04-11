import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_filex/open_filex.dart';
import 'package:sehhalink/core/current_user/domain/entity/user_file.dart';
import 'package:sehhalink/core/current_user/presentation/logic/file_logic/files_cubit.dart';
import 'package:sehhalink/core/current_user/presentation/logic/file_logic/files_state.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';
import 'package:sehhalink/features/view_details/presentation/widgets/delete_file_dialog.dart';
import 'package:sehhalink/features/view_details/presentation/widgets/file_icon_widget.dart';
import 'package:sehhalink/features/view_details/presentation/widgets/file_summary_widget.dart';

class FileCard extends StatefulWidget {
  final UserFile file;
  const FileCard({super.key, required this.file});

  @override
  State<FileCard> createState() => _FileCardState();
}

class _FileCardState extends State<FileCard> {
  bool get _isImage {
    final type = widget.file.fileType.toLowerCase();
    return type == 'image' ||
        type == 'png' ||
        type == 'jpg' ||
        type == 'jpeg' ||
        type == 'webp';
  }

  Future<void> _openFile() async {
    final path = widget.file.filePath;
    final file = File(path);

    if (!await file.exists()) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('view_details.file_not_found'.tr()),
            backgroundColor: AppColors.primaryBlue,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        );
      }
      return;
    }

    if (_isImage) {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                _ImageViewerScreen(path: path, fileName: widget.file.fileName),
          ),
        );
      }
    } else {
      await OpenFilex.open(path);
    }
  }

  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => DeleteFileDialog(fileName: widget.file.fileName),
    );
    if (confirmed == true && mounted) {
      context.read<FilesCubit>().deleteFile(widget.file.fileId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: _openFile,
          borderRadius: BorderRadius.circular(14.r),
          child: Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: AppColors.backgroundSoft,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: AppColors.borderLight, width: 1),
            ),
            child: Row(
              children: [
                FileIconWidget(file: widget.file, isImage: _isImage),
                horizontalSpace(14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.file.fileName,
                        style: TextStyle(
                          fontWeight: FontWeightHelper.semiBold,
                          fontSize: 14.sp,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      verticalSpace(4),
                      Text(
                        widget.file.uploadedAt.toIso8601String(),
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: AppColors.textLight,
                        ),
                      ),
                    ],
                  ),
                ),
                horizontalSpace(8),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.open_in_new_rounded,
                        size: 13.sp,
                        color: AppColors.primaryBlue,
                      ),
                      horizontalSpace(4),
                      Text(
                        'view_details.open'.tr(),
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeightHelper.semiBold,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                horizontalSpace(8),
                GestureDetector(
                  onTap: _confirmDelete,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      size: 18.sp,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        verticalSpace(12),

        BlocBuilder<FilesCubit, FilesState>(
          builder: (context, state) {
            final isLoading = state.loadingSummaries.contains(
              widget.file.fileId,
            );
            return FileSummaryWidget(
              fileId: widget.file.fileId,
              summary: widget.file.summary,
              isLoading: isLoading,
            );
          },
        ),
      ],
    );
  }
}

class _ImageViewerScreen extends StatelessWidget {
  final String path;
  final String fileName;

  const _ImageViewerScreen({required this.path, required this.fileName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: AppColors.textWhite,
        title: Text(
          fileName,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeightHelper.medium,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: Image.file(
            File(path),
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => Center(
              child: Text(
                'view_details.cannot_load_image'.tr(),
                style: TextStyle(color: AppColors.textWhite, fontSize: 14.sp),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
