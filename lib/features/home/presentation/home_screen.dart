import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/current_user/presentation/logic/current_user_cubit.dart';
import 'package:sehhalink/core/current_user/presentation/logic/current_user_state.dart';
import 'package:sehhalink/core/dependency_Injection/get_it.dart';
import 'package:sehhalink/core/dependency_Injection/home_screen_di.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';
import 'package:sehhalink/features/home/presentation/logic/home_cubit.dart';
import 'package:sehhalink/features/home/presentation/logic/home_state.dart';
import 'package:sehhalink/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:sehhalink/features/home/presentation/widgets/drop_zoon.dart';
import 'package:sehhalink/features/home/presentation/widgets/upload_progress.dart';
import 'package:sehhalink/features/home/presentation/widgets/upload_summery_card.dart';
import 'package:sehhalink/features/view_details/presentation/view_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    homeScreenDi();
    return BlocProvider(
      create: (_) => getIt<HomeCubit>(),
      child: BlocBuilder<CurrentUserCubit, CurrentUserState>(
        builder: (context, userState) {
          final user = userState.user;
          return Scaffold(
            backgroundColor: AppColors.backgroundMain,
            appBar: CustomAppBar(
              name: user?.fullName ?? '',
              profileImagePath: user?.profileImage,
            ),
            body: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                final cubit = context.read<HomeCubit>();

                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UploadSummaryCard(
                        totalReports: state.doneCount,
                        lastUpload: () {
                          final label = state.lastUploadLabel;
                          if (label == null) return 'home.no_uploads_yet'.tr();
                          if (label == 'home.today' || label == 'home.yesterday') {
                            return label.tr();
                          }
                          return label;
                        }(),
                        onViewDetails: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<CurrentUserCubit>(),
                                child: const ViewDetailsScreen(),
                              ),
                            ),
                          );
                        },
                      ),
                      verticalSpace(24),
                      _SectionTitle(title: 'home.upload_report_section'.tr()),
                      verticalSpace(12),
                      DropZone(
                        isDragging: state.isDragging,
                        onDragEnter: cubit.onDragEnter,
                        onDragExit: cubit.onDragExit,
                        onTap: cubit.pickAndUpload,
                      ),
                      verticalSpace(24),
                      if (state.hasFiles) ...[
                        _SectionTitle(title: 'home.upload_progress_section'.tr()),
                        verticalSpace(12),
                        ...state.files.asMap().entries.map(
                          (entry) => Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: FileProgressCard(
                              file: entry.value,
                              onCancel: () => cubit.cancelUpload(entry.key),
                              onRetry: () => cubit.retryUpload(entry.key),
                            ),
                          ),
                        ),
                      ],
                      if (state.errorMessage != null)
                        _ErrorBanner(message: state.errorMessage!),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.semiBold,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final displayMessage = message == 'home.file_path_unavailable'
        ? message.tr()
        : message;
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFEE2E2),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFEF4444).withOpacity(0.4)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: Color(0xFFEF4444),
            size: 18,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              displayMessage,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFFEF4444),
                fontWeight: FontWeightHelper.medium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
