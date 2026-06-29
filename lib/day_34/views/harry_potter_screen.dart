import 'package:flutter/material.dart';
import 'package:lanscare_app/day_34/models/harry_potter_models.dart';
import 'package:lanscare_app/day_34/service/api_services.dart';
import 'package:lanscare_app/day_34/service/dio.dart';
import 'package:lanscare_app/day_34/views/biodata_screen.dart';

class HarryPotterScreen extends StatefulWidget {
  const HarryPotterScreen({super.key});
  // Map<String, dynamic> _getHouseTheme() {
  //   'primary': const Color(0xFF740001); // Scarlet
  //         'secondary': const Color(0xFFD3A625); // Gold
  //         'accent': const Color(0xFFEEBA30);
  //         'background': const Color(0xFF1A0B0C),
  // }

  // _getHouseTheme(color){
  //   switch (color) {
  //     case "primary":
  //       return const Color(0xFF740001);
  //     case "secondary":
  //       return const Color(0xFFD3A625);

  //       break;
  //     default:
  //   }
  // }

  @override
  State<HarryPotterScreen> createState() => _HarryPotterScreenState();
}

class _HarryPotterScreenState extends State<HarryPotterScreen> {
  late final ApiService _apiService;
  late Future<List<HarryPotterModels>> _postsFuture;

  @override
  void initState() {
    super.initState();
    final dio = createDioClient();
    _apiService = ApiService(dio);
    _postsFuture = _apiService.getAllCharacter();
  }

  void _refreshPosts() {
    setState(() {
      _postsFuture = _apiService.getAllCharacter();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final theme = _getHouseTheme();
    // final backgroundColor = theme['background'] as Color;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Harry Potter',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: BackgroundColor.background),
        ),

        // iconTheme: const IconThemeData(color: Colors.white),
      ), // AppBar
      body: Container(
        decoration: BoxDecoration(gradient: BackgroundColor.background),

        child: FutureBuilder<List<HarryPotterModels>>(
          future: _postsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(
                        'Gagal memuat data:\n${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ), // Text
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _refreshPosts,
                        child: const Text('Coba Lagi'),
                      ), // ElevatedButton
                    ],
                  ), // Column
                ), // Padding
              ); // Center
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Tidak ada data post.'));
            }

            final posts = snapshot.data!;

            return RefreshIndicator(
              onRefresh: () async => _refreshPosts(),
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  void navigateToDetail() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BiodataScreen(character: post),
                      ),
                    );
                  }

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ), // EdgeInsets.symmetric
                    color: const Color.fromARGB(255, 0, 0, 0),
                    child: ListTile(
                      onTap: navigateToDetail,
                      leading: post.image.isNotEmpty
                          ? Hero(
                              tag: 'avatar-${post.id}',
                              child: CircleAvatar(
                                child: ClipOval(
                                  child: Image.network(
                                    post.image,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                              Icons.person,
                                              color: Colors.white,
                                            ),
                                  ),
                                ),
                              ),
                            )
                          : null,
                      title: Text(
                        post.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ), // Text
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (post.dateOfBirth != null &&
                              post.dateOfBirth!.isNotEmpty)
                            Text(
                              post.dateOfBirth!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white54),
                            ),
                        ],
                      ), // Text
                      trailing: IconButton(
                        onPressed: navigateToDetail,
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ), // ListTile
                  ); // Card
                },
              ), // ListView.builder
            ); // RefreshIndicator
          },
        ),
      ), // FutureBuilder
    ); // Scaffold
  }
}

class BackgroundColor {
  static Gradient background = const LinearGradient(
    colors: [
      Color(0xFF740001), // Scarlet
      Color(0xFF1A0B0C),
    ],
    begin: AlignmentGeometry.topLeft,
    end: AlignmentGeometry.bottomRight,
  );
}
