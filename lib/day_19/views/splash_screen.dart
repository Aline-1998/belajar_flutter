import 'package:belajar_flutter/day_19/database/preference_handler.dart';
import 'package:belajar_flutter/extension/navigator.dart';
import 'package:belajar_flutter/lanscare_dart/db.dart';
import 'package:belajar_flutter/lanscare_dart/login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 5));
    if (!mounted) return;
    if (PreferenceHandler.isLogin) {
      context.pushAndRemoveAll(DashBoard());
    } else {
      context.pushAndRemoveAll(LansCareApp1());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LansCare',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFF7F4ED),
      ),
      home: OnboardingScreen(),
    );
  }
}

class AppColors {
  static const primary = Color(0xFF0F8B8D);
  static const cream = Color(0xFFF7F4ED);
  static const mint = Color(0xFFDFF6F0);
}

class OnboardingModel {
  final String title;
  final String description;
  final IconData icon;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  final _formKey = GlobalKey<FormState>();

  // class OnboardingScreen extends StatefulWidget {
  //   final _formKey = GlobalKey<FormState>();

  //   @override
  //   State<OnboardingScreen> createState() => _OnboardingScreenState();
  // }

  // class _OnboardingScreenState extends State<OnboardingScreen> {
  //   final PageController _controller = PageController();

  int currentIndex = 0;

  final List<OnboardingModel> items = [
    OnboardingModel(
      title: 'Sehat Bersama,\nBahagia Selalu',
      description:
          'LansCare membantu lansia memantau kesehatan, jadwal posyandu, dan pengingat penting setiap hari.',
      icon: Icons.favorite,
    ),
    OnboardingModel(
      title: 'Pantau Kesehatan\nLebih Mudah',
      description:
          'Catat tekanan darah, gula darah, berat badan, dan denyut nadi kapan saja.',
      icon: Icons.monitor_heart,
    ),
    OnboardingModel(
      title: 'Jadwal & Pengingat\nTidak Terlewat',
      description:
          'Dapatkan pengingat jadwal posyandu dan minum obat tepat waktu.',
      icon: Icons.notifications_active,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: items.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final item = items[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),

                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            color: AppColors.mint,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Icon(
                            item.icon,
                            size: 70,
                            color: AppColors.primary,
                          ),
                        ),

                        const SizedBox(height: 50),

                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            height: 1.3,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            height: 1.6,
                          ),
                        ),

                        const Spacer(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            items.length,
                            (dotIndex) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: currentIndex == dotIndex ? 24 : 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: currentIndex == dotIndex
                                    ? AppColors.primary
                                    : Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        SizedBox(
                          width: double.infinity,
                          height: 58,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              elevation: 0,
                            ),
                            // onPressed: () {
                            //   if (currentIndex == items.length - 1) {
                            //     context.pushReplacement(LansCareApp1());
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(
                            //         content: Text('Masuk ke halaman login'),
                            //       ),
                            //     );
                            //   } else {
                            //     _controller.nextPage(
                            //       duration: const Duration(milliseconds: 400),
                            //       curve: Curves.easeInOut,
                            //     );
                            //   }
                            // },
                            onPressed: () {
                              // if (_formKey.currentState!.validate()) {
                              //   print("berhasil login");
                              //   // context.pushReplacement(LansCareApp1());
                              // } else {
                              //   print("eror");
                              // }
                              // if (currentIndex == items.length - 1) {
                              //   // ScaffoldMessenger.of(context).showSnackBar(
                              //   //   const SnackBar(
                              //   //     content: Text('Masuk ke halaman login'),
                              //   //   ),
                              //   // );
                              //   setState(() {
                              //     index++;
                              //     print(index);
                              //   });
                              // } else {
                              // _controller.nextPage(
                              //   duration: const Duration(milliseconds: 400),
                              //   curve: Curves.easeInOut,
                              // );

                              if (currentIndex == items.length - 1) {
                                context.pushReplacement(LansCareApp1());
                              } else {
                                _controller.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                              // }
                            },
                            child: Text(
                              currentIndex == items.length - 1
                                  ? 'Mulai Sekarang'
                                  : 'Selanjutnya',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
