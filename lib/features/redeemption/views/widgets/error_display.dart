import 'package:flutter/material.dart';

class ErrorDisplay extends StatelessWidget {
  final IconData icon;
  final String message;
  final VoidCallback onRetry;
  final Color iconColor;

  const ErrorDisplay({
    super.key,
    required this.icon,
    required this.message,
    required this.onRetry,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: iconColor),
          const SizedBox(height: 16),
          Text(message),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}