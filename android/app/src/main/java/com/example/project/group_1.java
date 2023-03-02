package com.example.project;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Matrix;
import android.graphics.Paint;
public class group_1 {
    public static Bitmap scaleImageBilinear(Bitmap inputImage, double scale) {
        int newWidth = (int) (inputImage.getWidth() * scale);
        int newHeight = (int) (inputImage.getHeight() * scale);
        Bitmap outputImage = Bitmap.createBitmap(newWidth, newHeight, Bitmap.Config.ARGB_8888);
    
        for (int y = 0; y < newHeight; y++) {
            for (int x = 0; x < newWidth; x++) {
                double gx = (double) x * inputImage.getWidth() / newWidth;
                double gy = (double) y * inputImage.getHeight() / newHeight;
                int gxi = (int) gx;
                int gyi = (int) gy;
                int rgb = Color.red(inputImage.getPixel(gxi, gyi));
                double fx = gx - gxi;
                double fy = gy - gyi;
    
                int rgb1 = Color.red(inputImage.getPixel(gxi, gyi));
                int rgb2 = Color.red(inputImage.getPixel(Math.min(gxi + 1, inputImage.getWidth() - 1), gyi));
                int rgb3 = Color.red(inputImage.getPixel(gxi, Math.min(gyi + 1, inputImage.getHeight() - 1)));
                int rgb4 = Color.red(inputImage.getPixel(Math.min(gxi + 1, inputImage.getWidth() - 1), Math.min(gyi + 1, inputImage.getHeight() - 1)));
    
                int rgb12 = (int) (rgb1 * (1 - fx) + rgb2 * fx);
                int rgb34 = (int) (rgb3 * (1 - fx) + rgb4 * fx);
                int finalRgb = (int) (rgb12 * (1 - fy) + rgb34 * fy);
    
                outputImage.setPixel(x, y, Color.rgb(finalRgb, finalRgb, finalRgb));
            }
        }
    
        return outputImage;
    }
    
    public static Bitmap scaleImageNN(Bitmap inputImage, double scale) {
        int newWidth = (int) Math.round(inputImage.getWidth() * scale);
        int newHeight = (int) Math.round(inputImage.getHeight() * scale);
    
        Bitmap outputImage = Bitmap.createBitmap(newWidth, newHeight, Bitmap.Config.ARGB_8888);
        double widthRatio = (double) inputImage.getWidth() / newWidth;
        double heightRatio = (double) inputImage.getHeight() / newHeight;
        int[] pixels = new int[inputImage.getWidth() * inputImage.getHeight()];
        inputImage.getPixels(pixels, 0, inputImage.getWidth(), 0, 0, inputImage.getWidth(), inputImage.getHeight());
        int[] outputPixels = new int[newWidth * newHeight];
        for (int y = 0; y < newHeight; y++) {
            for (int x = 0; x < newWidth; x++) {
                int srcX = (int) Math.round(x * widthRatio);
                int srcY = (int) Math.round(y * heightRatio);
                if (srcX >= inputImage.getWidth()) {
                    srcX = inputImage.getWidth() - 1;
                }
                if (srcY >= inputImage.getHeight()) {
                    srcY = inputImage.getHeight() - 1;
                }
                outputPixels[x + y * newWidth] = pixels[srcX + srcY * inputImage.getWidth()];
            }
        }
        outputImage.setPixels(outputPixels, 0, newWidth, 0, 0, newWidth, newHeight);
        return outputImage;
    }
    
}
