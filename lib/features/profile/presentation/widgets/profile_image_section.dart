import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sehhalink/core/current_user/presentation/logic/current_user_logic/current_user_cubit.dart';
import 'package:sehhalink/core/current_user/presentation/logic/current_user_logic/current_user_state.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/features/profile/presentation/widgets/image_source_bottom_sheet.dart';

class ProfileImageSection extends StatelessWidget {
  const ProfileImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserCubit, CurrentUserState>(
      builder: (context, state) {
        final profileImage = state.user?.profileImage;

        return Stack(
          alignment: Alignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: 96.w,
                  height: 96.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.textWhite, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(child: _buildProfileImage(profileImage)),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: state.isUpdatingImage
                        ? null
                        : () => ImageSourceBottomSheet.show(context),
                    child: Container(
                      padding: EdgeInsets.all(7.w),
                      decoration: BoxDecoration(
                        color: AppColors.accentOrange,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.textWhite,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        size: 15.sp,
                        color: AppColors.textWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            if (state.isUpdatingImage)
              ClipOval(
                child: SizedBox(
                  width: 96.w,
                  height: 96.w,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade200,
                    child: Container(color: Colors.grey.shade400),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildProfileImage(String? profileImage) {
    if (profileImage == null || profileImage.isEmpty) {
      return _defaultAvatar();
    }

    if (profileImage.startsWith('http://') ||
        profileImage.startsWith('https://')) {
      return Image.network(
        profileImage,
        key: ValueKey(profileImage),
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _defaultAvatar(),
        loadingBuilder: (_, child, progress) {
          if (progress == null) return child;
          return _shimmerAvatar();
        },
      );
    }

    final file = File(profileImage);
    return FutureBuilder<bool>(
      future: file.exists(),
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return Image.file(
            file,
            key: ValueKey(profileImage),
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => _defaultAvatar(),
          );
        }
        return _defaultAvatar();
      },
    );
  }

  Widget _shimmerAvatar() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(color: Colors.grey.shade300),
    );
  }

  Widget _defaultAvatar() {
    return Container(
      color: AppColors.backgroundCard,
      child: const Icon(
        Icons.person_rounded,
        size: 48,
        color: AppColors.textSecondary,
      ),
    );
  }
}
