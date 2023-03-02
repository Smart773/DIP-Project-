// package com.example.project;
// import android.graphics.Bitmap;
// import android.graphics.Color;

// public class HitOrMissTransform {

//     public static Bitmap hitOrMissTransform(Bitmap inputImg, int[][] structElem) {
//         int width = inputImg.getWidth();
//         int height = inputImg.getHeight();
//         Bitmap outputImg = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);

//         // Iterate over each pixel in the input image
//         for (int i = 0; i < height; i++) {
//             for (int j = 0; j < width; j++) {

//                 // Check if the current pixel matches the structuring element
//                 boolean matches = true;
//                 for (int k = 0; k < 3; k++) {
//                     for (int l = 0; l < 3; l++) {
//                         int x = j + l - 1;
//                         int y = i + k - 1;
//                         if (x < 0 || x >= width || y < 0 || y >= height) {
//                             continue;
//                         }
//                         int inputPixel = inputImg.getPixel(x, y);
//                         int inputColor = Color.red(inputPixel);
//                         if (structElem[k][l] == 1 && inputColor != 0) {
//                             matches = false;
//                             break;
//                         }
//                         if (structElem[k][l] == 0 && inputColor != 255) {
//                             matches = false;
//                             break;
//                         }
//                     }
//                     if (!matches) {
//                         break;
//                     }
//                 }

//                 // Set the output pixel value based on the match result
//                 int outputPixel = Color.BLACK;
//                 if (matches) {
//                     outputPixel = Color.WHITE;
//                 }
//                 outputImg.setPixel(j, i, outputPixel);
//             }
//         }

//         return outputImg;
//     }
// }

