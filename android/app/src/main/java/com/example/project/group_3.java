package com.example.project;

import android.graphics.Bitmap;
import android.graphics.Color;


public class group_3 {
   
    public static Bitmap addImages(Bitmap bitmap1, Bitmap bitmap2) {
        int width = Math.min(bitmap1.getWidth(), bitmap2.getWidth());
        int height = Math.min(bitmap1.getHeight(), bitmap2.getHeight());
        Bitmap result = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
        for (int x = 0; x < width; x++) {
            for (int y = 0; y < height; y++) {
                int pixel1 = bitmap1.getPixel(x, y);
                int pixel2 = bitmap2.getPixel(x, y);
                int redResult = Math.min(255, Color.red(pixel1) + Color.red(pixel2));
                int greenResult = Math.min(255, Color.green(pixel1) + Color.green(pixel2));
                int blueResult = Math.min(255, Color.blue(pixel1) + Color.blue(pixel2));
                int alpha = Color.alpha(pixel1);
                int resultPixel = Color.argb(alpha, redResult, greenResult, blueResult);
                result.setPixel(x, y, resultPixel);
            }
        }
        return result;
    }
    
   
    public static Bitmap subtractImages(Bitmap bitmap1, Bitmap bitmap2) {
        int width = Math.min(bitmap1.getWidth(), bitmap2.getWidth());
        int height = Math.min(bitmap1.getHeight(), bitmap2.getHeight());
        Bitmap result = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
        for (int x = 0; x < width; x++) {
            for (int y = 0; y < height; y++) {
                int pixel1 = bitmap1.getPixel(x, y);
                int pixel2 = bitmap2.getPixel(x, y);
                int redResult = Math.max(0, Color.red(pixel1) - Color.red(pixel2));
                int greenResult = Math.max(0, Color.green(pixel1) - Color.green(pixel2));
                int blueResult = Math.max(0, Color.blue(pixel1) - Color.blue(pixel2));
                int alpha = Color.alpha(pixel1);
                int resultPixel = Color.argb(alpha, redResult, greenResult, blueResult);
                result.setPixel(x, y, resultPixel);
            }
        }
        return result;
    }
    
    
    public static Bitmap multiplyImages(Bitmap bitmap1, Bitmap bitmap2) {
        int width = Math.min(bitmap1.getWidth(), bitmap2.getWidth());
        int height = Math.min(bitmap1.getHeight(), bitmap2.getHeight());
        Bitmap result = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
        for (int x = 0; x < width; x++) {
            for (int y = 0; y < height; y++) {
                int pixel1 = bitmap1.getPixel(x, y);
                int pixel2 = bitmap2.getPixel(x, y);
                int redResult = (int) (((float) Color.red(pixel1) / 255) * ((float) Color.red(pixel2) / 255) * 255);
                int greenResult = (int) (((float) Color.green(pixel1) / 255) * ((float) Color.green(pixel2) / 255) * 255);
                int blueResult = (int) (((float) Color.blue(pixel1) / 255) * ((float) Color.blue(pixel2) / 255) * 255);
                int alpha = Color.alpha(pixel1);
                int resultPixel = Color.argb(alpha, redResult, greenResult, blueResult);
                result.setPixel(x, y, resultPixel);
            }
        }
        return result;
    }


    public static Bitmap divideImages(Bitmap bitmap1, Bitmap bitmap2) {
        int width = Math.min(bitmap1.getWidth(), bitmap2.getWidth());
        int height = Math.min(bitmap1.getHeight(), bitmap2.getHeight());
        Bitmap result = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
        for (int x = 0; x < width; x++) {
            for (int y = 0; y < height; y++) {
                int pixel1 = bitmap1.getPixel(x, y);
                int pixel2 = bitmap2.getPixel(x, y);
                int redResult = 0;
                int greenResult = 0;
                int blueResult = 0;
                int alpha = Color.alpha(pixel1);
                if (Color.red(pixel2) != 0) {
                    redResult = (Color.red(pixel1) / Color.red(pixel2)) * 255;
                }
                if (Color.green(pixel2) != 0) {
                    greenResult = (Color.green(pixel1) / Color.green(pixel2)) * 255;
                }
                if (Color.blue(pixel2) != 0) {
                    blueResult = (Color.blue(pixel1) / Color.blue(pixel2)) * 255;
                }
                int resultPixel = Color.argb(alpha, redResult, greenResult, blueResult);
                result.setPixel(x, y, resultPixel);
            }
        }
        return result;
    }

}
