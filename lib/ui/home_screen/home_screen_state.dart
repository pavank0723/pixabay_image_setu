part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenState {}

final class HomeScreenInitial extends HomeScreenState {}

class LoadingImages extends HomeScreenState {}

class LoadedImages extends HomeScreenState {
  final List<Hits> images;
  final int currentPage;
  final bool hasReachedMax;

  LoadedImages({
    required this.images,
    required this.currentPage,
    required this.hasReachedMax,
  });

  LoadedImages copyWith({
    List<Hits>? images,
    int? currentPage,
    bool? hasReachedMax,
  }) {
    return LoadedImages(
      images: images ?? this.images,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class ErrorImages extends HomeScreenState {
  final String message;

  ErrorImages(this.message);
}
