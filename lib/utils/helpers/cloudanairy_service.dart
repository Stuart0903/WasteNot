import 'dart:io';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CloudinaryService {
  late final Cloudinary cloudinary;

  // Initialize with your Cloudinary credentials
  CloudinaryService() {
    cloudinary = Cloudinary.full(
      apiKey: '727234567487989',
      apiSecret: 'HDmD8MoUU59Lr5w2LRM-zeedtBU',
      cloudName: 'dgnekncbv',
    );
  }

  // Upload an image file and return the URL
  Future<String> uploadImage(File imageFile, {String folder = 'user_profile_images'}) async {
    try {
      final response = await cloudinary.uploadResource(
        CloudinaryUploadResource(
          filePath: imageFile.path,
          resourceType: CloudinaryResourceType.image,
          folder: folder,
          fileName: 'img_${DateTime.now().millisecondsSinceEpoch}', // Optional: create custom filename
          progressCallback: (count, total) {
            // Optional: track upload progress
            print('Progress: $count/$total');
          },
        ),
      );

      if (response.isSuccessful) {
        return response.secureUrl!;
      } else {
        throw Exception('Failed to upload image: ${response.error}');
      }
    } catch (e) {
      print('Error uploading to Cloudinary: $e');
      throw e;
    }
  }


}