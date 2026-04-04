import 'package:easy_localization/easy_localization.dart';

String formatLastUpload(DateTime? lastUploadTime) {
  if (lastUploadTime == null) return 'home.no_uploads_yet'.tr();
  final diff = DateTime.now().difference(lastUploadTime);
  if (diff.inDays == 0) return 'home.today'.tr();
  if (diff.inDays == 1) return 'home.yesterday'.tr();
  return '${lastUploadTime.day}/${lastUploadTime.month}/${lastUploadTime.year}';
}