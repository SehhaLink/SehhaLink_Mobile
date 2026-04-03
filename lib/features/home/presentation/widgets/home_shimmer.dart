// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sehhalink/core/helpers/spacing.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Upload Summary Card ──────────────────────────────
          _ShimmerBox(
            width: double.infinity,
            height: 170.h,
            radius: 16.r,
          ),

          verticalSpace(24),

          // ─── General Summary Card ─────────────────────────────
          _ShimmerBox(
            width: double.infinity,
            height: 68.h,
            radius: 16.r,
          ),

          verticalSpace(16),

          // ─── Section Title ────────────────────────────────────
          _ShimmerBox(width: 120.w, height: 16.h, radius: 6.r),

          verticalSpace(12),

          // ─── Drop Zone ────────────────────────────────────────
          _ShimmerBox(
            width: double.infinity,
            height: 220.h,
            radius: 16.r,
          ),
        ],
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({
    required this.width,
    required this.height,
    required this.radius,
  });

  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE8EEF1),
      highlightColor: const Color(0xFFF5F8FA),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFFE8EEF1),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}