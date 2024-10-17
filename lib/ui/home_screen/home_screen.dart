import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixabay_image_setu/common/common.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pixabay_image_setu/res/res.dart';

import 'home_screen_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  late HomeScreenBloc _homeScreenBloc;

  @override
  void initState() {
    super.initState();
    _homeScreenBloc = context.read<HomeScreenBloc>();
    _scrollController.addListener(_onScroll);

    // Load the first page
    _homeScreenBloc.add(LoadImage(page: 1));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _homeScreenBloc.add(LoadNextPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Define screen size breakpoints
    final isExtraSmallScreen = size.width < 300;
    final isSmallScreen = size.width < 600;
    final isMediumScreen = size.width >= 600 && size.width < 1024;
    final isLargeScreen = size.width >= 1024;

    // Calculate crossAxisCount based on screen size (media query logic)
    int crossAxisCount;
    double childAspectRatio;

    if (isExtraSmallScreen) {
      crossAxisCount = 1; // 2 columns for small screens
      childAspectRatio = 1.2; // Adjust height
    } else if (isSmallScreen) {
      crossAxisCount = 2; // 2 columns for small screens
      childAspectRatio = 1; // Adjust height
    } else if (isMediumScreen) {
      crossAxisCount = 4; // 3 columns for medium screens
      childAspectRatio = 0.8; // Adjust height
    } else if (isLargeScreen) {
      crossAxisCount = 6; // 4 columns for large screens
      childAspectRatio = 0.9; // Adjust height
    } else {
      crossAxisCount = 2; // Default for unknown cases
      childAspectRatio = 1.0;
    }

    return BaseScreen(
      enableAppBar: true,
      isSafeAreaOnTop: true,
      homeAppBar: false,
      isAppShadowEffect: false,
      title: 'Home',
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
          builder: (context, state) {
            // Show loader while loading the first page
            if (state is LoadingImages) {
              return const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            }
            // When images are loaded, show them in GridView
            else if (state is LoadedImages) {
              return GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount, // Responsive grid columns
                  childAspectRatio: childAspectRatio, // Responsive aspect ratio
                ),
                itemCount: state.images.length + (state.hasReachedMax ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index == state.images.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final image = state.images[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0), // Add some spacing
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          // Rounded corners
                          child: GestureDetector(
                            onTap: () {
                              _showBigImage(
                                context: context,
                                itemImage: image.previewURL ?? "",
                                imgWidth: double.parse(
                                    image.webformatWidth.toString()),
                                imgHeight: double.parse(
                                    image.webformatHeight.toString()),
                              );
                            },
                            child: CachedNetworkImage(
                              imageUrl: image.webformatURL ?? '',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: size.height * 0.3,
                              fadeInDuration: const Duration(milliseconds: 200),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: double.infinity,
                                // Make it take full width
                                height: size.height * 0.3,
                                decoration: BoxDecoration(
                                  // shape: BoxShape.circle,

                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Image.asset(
                                AppImages.imgNoImage,
                                width: size.width,
                                height: 200.h,
                                fit: BoxFit.fill,
                              ),
                              errorWidget: (context, url, error) {
                                return Image.asset(
                                  AppImages.imgNoImage,
                                  width: double.infinity,
                                  // Make it take full width
                                  height: size.height * 0.3,
                                  fit: BoxFit.fill,
                                );
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            // Semi-transparent background
                            padding: const EdgeInsets.all(4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  image.tags ?? 'No Tags',
                                  overflow: TextOverflow.ellipsis,
                                  // Display the image name (tags)
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // Space between text and icons
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      formatCount(image.likes!),
                                      // Formatted likes
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.visibility,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      formatCount(image.views!),
                                      // Formatted views
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            // Handle error state
            else if (state is ErrorImages) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }

  // Method to format numbers into a readable string
  String formatCount(int count) {
    if (count >= 1000000000) {
      // Billions
      return '${(count / 1000000000).toStringAsFixed(1)}B';
    } else if (count >= 1000000) {
      // Millions
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      // Thousands
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString(); // For counts below 1000
  }

  void _showBigImage({
    required BuildContext context,
    required String itemImage,
    required double imgWidth,
    required double imgHeight,
  }) {
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: false,
      builder: (context) {
        return SafeArea(
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Image.network(
                    itemImage,
                    fit: BoxFit.fitHeight,
                    width: imgWidth,
                    height: imgHeight,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 10, // Added padding from the right
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: AppColors.greyDark.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
