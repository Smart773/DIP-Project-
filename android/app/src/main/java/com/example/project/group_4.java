package com.example.project;
//// Todo Note: code work kr rha hai but black Screen day rha

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
//
public class group_4 {
    public static Bitmap applyGammaCorrection(Bitmap inputBitmap, double gammaValue) {
        // Get the width and height of the input bitmap
        int width = inputBitmap.getWidth();
        int height = inputBitmap.getHeight();
    
        // Create a new 2D array to store the corrected pixel values
        int[][] correctedPixels = new int[width][height];
    
        // Normalize the pixel values to the range of 0.0 to 1.0
        for (int x = 0; x < width; x++) {
            for (int y = 0; y < height; y++) {
                int pixelValue = inputBitmap.getPixel(x, y) & 0xff; // Get the grayscale value of the pixel
                double normalizedValue = pixelValue / 255.0; // Normalize to the range of 0.0 to 1.0
                double correctedValue = 255.0 * Math.pow(normalizedValue, gammaValue); // Apply the gamma correction formula
                int correctedPixel = (int) Math.round(correctedValue); // Convert back to the range of 0 to 255
                correctedPixels[x][y] = Color.rgb(correctedPixel, correctedPixel, correctedPixel); // Store the corrected pixel value
            }
        }
    
        // Create a new Bitmap object from the corrected pixel values
        Bitmap outputBitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
        for (int x = 0; x < width; x++) {
            for (int y = 0; y < height; y++) {
                outputBitmap.setPixel(x, y, correctedPixels[x][y]);
            }
        }
    
        // Return the corrected bitmap
        return outputBitmap;
    }
    


}




