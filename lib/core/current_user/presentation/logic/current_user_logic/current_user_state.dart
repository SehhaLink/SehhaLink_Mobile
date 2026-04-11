import 'package:equatable/equatable.dart';
import 'package:sehhalink/core/current_user/domain/entity/user.dart';

class CurrentUserState extends Equatable {
  final User? user;
  final bool isLoading;
  final bool isUpdating;
  final bool isUpdatingImage;
  final String? error;

  const CurrentUserState({
    this.user,
    this.isLoading = false,
    this.isUpdating = false,
    this.isUpdatingImage = false,
    this.error,
  });

  CurrentUserState copyWith({
    User? user,
    bool? isLoading,
    bool? isUpdating,
    bool? isUpdatingImage,
    String? error,
  }) {
    return CurrentUserState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isUpdating: isUpdating ?? this.isUpdating,
      isUpdatingImage: isUpdatingImage ?? this.isUpdatingImage,
      error: error,
    );
  }

  @override
  List<Object?> get props => [user, isLoading, isUpdating, isUpdatingImage, error];
}