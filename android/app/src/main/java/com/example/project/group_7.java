//package com.example.project;
//
// Todo Note: Code may error hai
//
//import android.graphics.Bitmap;
//import android.graphics.Color;
//
//public class group_7 {
//    public static Bitmap grayscaleMorphology(Bitmap input, int kernelSize, boolean isErosion, int operationType) {
//        int width = input.getWidth();
//        int height = input.getHeight();
//        int[] pixels = new int[width * height];
//        input.getPixels(pixels, 0, width, 0, 0, width, height);
//
//        Bitmap output = new int[width * height];
//
//        int halfKernel = kernelSize / 2;
//        for (int y = halfKernel; y < height - halfKernel; y++) {
//            for (int x = halfKernel; x < width - halfKernel; x++) {
//                int minOrMax = isErosion ? 255 : 0;
//                for (int ky = -halfKernel; ky <= halfKernel; ky++) {
//                    for (int kx = -halfKernel; kx <= halfKernel; kx++) {
//                        int pixel = pixels[(y + ky) * width + x + kx];
//                        int gray = (int) (Color.red(pixel) * 0.299 + Color.green(pixel) * 0.587 + Color.blue(pixel) * 0.114);
//                        if (isErosion) {
//                            if (gray < minOrMax) {
//                                minOrMax = gray;
//                            }
//                        } else {
//                            if (gray > minOrMax) {
//                                minOrMax = gray;
//                            }
//                        }
//                    }
//                }
//                output[y * width + x] = Color.rgb(minOrMax, minOrMax, minOrMax);
//            }
//        }
//
//        if (operationType == 1) { // Opening
//            output = grayscaleMorphology(Bitmap.createBitmap(output, width, height, Bitmap.Config.ARGB_8888), kernelSize, !isErosion, 0);
//            output = grayscaleMorphology(Bitmap.createBitmap(output, width, height, Bitmap.Config.ARGB_8888), kernelSize, isErosion, 0);
//        } else if (operationType == 2) { // Closing
//            output = grayscaleMorphology(Bitmap.createBitmap(output, width, height, Bitmap.Config.ARGB_8888), kernelSize, isErosion, 0);
//            output = grayscaleMorphology(Bitmap.createBitmap(output, width, height, Bitmap.Config.ARGB_8888), kernelSize, !isErosion, 0);
//        }
//
//        Bitmap result = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
//        result.setPixels(output, 0, width, 0, 0, width, height);
//        return result;
//    }
//
//}
