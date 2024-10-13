part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenEvent {}

class LoadImage extends HomeScreenEvent {
  final int page;
  LoadImage({this.page = 1});
}

class LoadNextPage extends HomeScreenEvent {}
