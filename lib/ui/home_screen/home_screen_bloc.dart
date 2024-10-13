import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pixabay_image_setu/model/api/api.dart';
import 'package:pixabay_image_setu/repository/repository.dart';

part 'home_screen_event.dart';

part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final UtilsRepository _utilsRepository;
  int currentPage = 1;

  HomeScreenBloc(this._utilsRepository) : super(HomeScreenInitial()) {
    on<LoadImage>(_onLoadImage);
    on<LoadNextPage>(_onLoadNextPage);
  }

  // Load the first page
  Future<void> _onLoadImage(
      LoadImage event, Emitter<HomeScreenState> emit) async {
    emit(LoadingImages());
    try {
      final imageMainModel =
          await _utilsRepository.fetchPixabayImages('photo', event.page);
      final images = imageMainModel.hits ?? [];

      emit(LoadedImages(
        images: images,
        currentPage: event.page,
        hasReachedMax: images.isEmpty,
      ));
    } catch (e) {
      emit(ErrorImages('Failed to load images: ${e.toString()}'));
    }
  }

  // Load the next page when scrolled down
  Future<void> _onLoadNextPage(
      LoadNextPage event, Emitter<HomeScreenState> emit) async {
    final currentState = state;
    if (currentState is LoadedImages && !currentState.hasReachedMax) {
      try {
        final nextPage = currentState.currentPage + 1;
        final imageMainModel =
            await _utilsRepository.fetchPixabayImages('photo', nextPage);
        final nextImages = imageMainModel.hits ?? [];

        emit(currentState.copyWith(
          images: currentState.images + nextImages,
          currentPage: nextPage,
          hasReachedMax: nextImages.isEmpty,
        ));
      } catch (e) {
        emit(ErrorImages('Failed to load more images: ${e.toString()}'));
      }
    }
  }
}
