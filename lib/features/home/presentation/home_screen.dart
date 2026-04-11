import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/current_user/presentation/logic/current_user_logic/current_user_cubit.dart';
import 'package:sehhalink/core/current_user/presentation/logic/current_user_logic/current_user_state.dart';
import 'package:sehhalink/core/current_user/presentation/logic/file_logic/files_cubit.dart';
import 'package:sehhalink/core/current_user/presentation/logic/file_logic/files_state.dart';
import 'package:sehhalink/core/dependency_Injection/get_it.dart';
import 'package:sehhalink/core/dependency_Injection/home_screen_di.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/features/home/data/helpers/format_last_upload.dart';
import 'package:sehhalink/features/home/presentation/logic/home_cubit.dart';
import 'package:sehhalink/features/home/presentation/logic/home_state.dart';
import 'package:sehhalink/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:sehhalink/features/home/presentation/widgets/drop_zoon.dart';
import 'package:sehhalink/features/home/presentation/widgets/error_banner.dart';
import 'package:sehhalink/features/home/presentation/widgets/general_summary_card.dart';
import 'package:sehhalink/features/home/presentation/widgets/home_shimmer.dart';
import 'package:sehhalink/features/home/presentation/widgets/section_title.dart';
import 'package:sehhalink/features/home/presentation/widgets/upload_progress.dart';
import 'package:sehhalink/features/home/presentation/widgets/upload_summary_card.dart';
import 'package:sehhalink/features/view_details/presentation/view_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    homeScreenDi();
    return BlocProvider(
      create: (_) => getIt<HomeCubit>(),
      child: BlocBuilder<CurrentUserCubit, CurrentUserState>(
        buildWhen: (prev, curr) =>
            prev.user?.fullName != curr.user?.fullName ||
            prev.user?.profileImage != curr.user?.profileImage,
        builder: (context, userState) {
          return Scaffold(
            backgroundColor: AppColors.backgroundMain,
            appBar: CustomAppBar(
              name: userState.user?.fullName ?? '',
              profileImagePath: userState.user?.profileImage,
            ),
            body: BlocBuilder<FilesCubit, FilesState>(
              builder: (context, filesState) {
                if (filesState.isLoadingFiles) return const HomeShimmer();

                return BlocListener<HomeCubit, HomeState>(
                  listenWhen: (prev, curr) =>
                      prev.files.length != curr.files.length &&
                      curr.files.any((f) => f.isStored),
                  listener: (context, state) {
                    context.read<FilesCubit>().loadFiles();
                  },
                  child: BlocBuilder<HomeCubit, HomeState>(
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
                            BlocBuilder<FilesCubit, FilesState>(
                              buildWhen: (prev, curr) =>
                                  prev.files.length != curr.files.length,
                              builder: (context, filesState) {
                                final files = filesState.files;
                                final lastUpload = files
                                    // ignore: unnecessary_null_comparison
                                    .where((f) => f.uploadedAt != null)
                                    .map((f) => f.uploadedAt)
                                    .fold<DateTime?>(
                                      null,
                                      (prev, curr) =>
                                          prev == null || curr.isAfter(prev)
                                          ? curr
                                          : prev,
                                    );

                                return UploadSummaryCard(
                                  totalReports: files.length,
                                  lastUpload: formatLastUpload(lastUpload),
                                  onViewDetails: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BlocProvider.value(
                                          value: context
                                              .read<
                                                FilesCubit
                                              >(), 
                                          child: const ViewDetailsScreen(),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            verticalSpace(24),
                            GeneralSummaryCard(
                              summary: state.generalSummary,
                              isLoading: state.isGeneralSummaryLoading,
                              isFromCache: state.isSummaryFromCache,
                              onExpand: cubit.loadGeneralSummary,
                              onRefresh: () =>
                                  cubit.loadGeneralSummary(forceRefresh: true),
                            ),
                            verticalSpace(16),
                            SectionTitle(
                              title: 'home.upload_report_section'.tr(),
                            ),
                            verticalSpace(12),
                            DropZone(
                              isDragging: state.isDragging,
                              onDragEnter: cubit.onDragEnter,
                              onDragExit: cubit.onDragExit,
                              onTap: cubit.pickAndUpload,
                            ),
                            verticalSpace(24),
                            if (state.hasFiles) ...[
                              SectionTitle(
                                title: 'home.upload_progress_section'.tr(),
                              ),
                              verticalSpace(12),
                              ...state.files.asMap().entries.map(
                                (entry) => Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: FileProgressCard(
                                    file: entry.value,
                                    onCancel: () =>
                                        cubit.cancelUpload(entry.key),
                                    onRetry: () => cubit.retryUpload(entry.key),
                                    onRemove: () => cubit.removeFile(entry.key),
                                  ),
                                ),
                              ),
                            ],
                            if (state.errorMessage != null)
                              ErrorBanner(message: state.errorMessage!),
                          ],
                        ),
                      );
                    },
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
