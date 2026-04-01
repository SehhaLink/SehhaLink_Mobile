import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/current_user/presentation/logic/current_user_cubit.dart';
import 'package:sehhalink/core/current_user/presentation/logic/current_user_state.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';
import 'package:sehhalink/features/view_details/presentation/widgets/file_card.dart';

class ViewDetailsScreen extends StatefulWidget {
  const ViewDetailsScreen({super.key});

  @override
  State<ViewDetailsScreen> createState() => _ViewDetailsScreenState();
}

class _ViewDetailsScreenState extends State<ViewDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CurrentUserCubit>().loadFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      appBar: AppBar(
        title: Text(
          'view_details.title'.tr(),
          style: TextStyle(
            fontWeight: FontWeightHelper.bold,
            fontSize: 18.sp,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.backgroundMain,
        foregroundColor: AppColors.textPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Divider(
            height: 1.h,
            thickness: 1,
            color: AppColors.borderLight,
          ),
        ),
      ),
      body: BlocBuilder<CurrentUserCubit, CurrentUserState>(
        builder: (context, state) {
          if (state.isLoadingFiles) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryBlue),
            );
          }
          if (state.error != null) {
            return _ErrorView(error: state.error!);
          }
          if (state.files.isEmpty) {
            return const _EmptyView();
          }
          return _FilesList(files: state.files);
        },
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String error;
  const _ErrorView({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48.sp, color: Colors.redAccent),
          verticalSpace(12),
          Text(
            error,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
          ),
          verticalSpace(16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: AppColors.textWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            onPressed: () => context.read<CurrentUserCubit>().loadFiles(),
            child: Text('view_details.retry'.tr()),
          ),
        ],
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder_open, size: 72.sp, color: AppColors.textLight),
          verticalSpace(16),
          Text(
            'view_details.no_files_title'.tr(),
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.textSecondary,
              fontWeight: FontWeightHelper.medium,
            ),
          ),
          verticalSpace(8),
          Text(
            'view_details.no_files_subtitle'.tr(),
            style: TextStyle(fontSize: 13.sp, color: AppColors.textLight),
          ),
        ],
      ),
    );
  }
}

class _FilesList extends StatelessWidget {
  final List files;
  const _FilesList({required this.files});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      itemCount: files.length,
      separatorBuilder: (_, _) =>
          Divider(height: 36.h, thickness: 1, color: AppColors.borderLight),
      itemBuilder: (context, index) {
        return FileCard(file: files[index]);
      },
    );
  }
}
