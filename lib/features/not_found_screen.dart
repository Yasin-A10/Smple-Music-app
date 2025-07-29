import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:music_app/core/constants/colors.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'صفحه مورد نظر پیدا نشد!',
          style: TextStyle(color: AppColors.green),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 350,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/Residences/Not-Found.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/home'),
                child: const Text('خانه'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
