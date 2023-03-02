package com.example.project;

import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;

import java.util.List;

public class group_9 {
    public static Bitmap Intensity_level_slicing(Bitmap originalImage,int minIntensity,
    int maxIntensity) {
        // Get the width and height of the image
        int width = originalImage.getWidth();
        int height = originalImage.getHeight();

// Create a new Bitmap object to store the result
        Bitmap resultImage = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);

// Define the intensity levels for slicing
        // Loop through each pixel in the image and perform intensity level slicing
        for (int x = 0; x < width; x++) {
            for (int y = 0; y < height; y++) {
                // Get the color of the current pixel
                int pixel = originalImage.getPixel(x, y);

                // Extract the red, green, and blue color components from the pixel
                int red = Color.red(pixel);
                int green = Color.green(pixel);
                int blue = Color.blue(pixel);

                // Calculate the intensity of the pixel using the formula (0.299*R + 0.587*G + 0.114*B)
                int intensity = (int) (0.299 * red + 0.587 * green + 0.114 * blue);

                // Check if the intensity is within the specified range
                if (intensity >= minIntensity && intensity <= maxIntensity) {
                    // If the intensity is within the range, set the pixel to white
                    resultImage.setPixel(x, y, Color.WHITE);
                } else {
                    // If the intensity is outside the range, set the pixel to black
                    resultImage.setPixel(x, y, Color.BLACK);
                }
            }
        }

        return resultImage;
    }

    ////
    public static Bitmap bitplaneSlicing(Bitmap image) {
        Bitmap inputImage = image;

// Create a blank output image with the same dimensions as the input image
        Bitmap outputImage = Bitmap.createBitmap(inputImage.getWidth(), inputImage.getHeight(), inputImage.getConfig());

// Choose the bit plane to slice (0 to 7 for 8-bit color depth)
        int bitPlane = 4;

// Loop through each pixel in the input image and extract the bit at the chosen bit plane
        for (int y = 0; y < inputImage.getHeight(); y++) {
            for (int x = 0; x < inputImage.getWidth(); x++) {
                // Get the color of the pixel at position (x, y)
                int inputColor = inputImage.getPixel(x, y);

                // Extract the color component at the chosen bit plane
                int bitValue = ((inputColor >> (7 - bitPlane)) & 1) * 255;

                // Create a new color with the same value in all color components
                int outputColor = Color.rgb(bitValue, bitValue, bitValue);

                // Set the color of the pixel in the output image at position (x, y)
                outputImage.setPixel(x, y, outputColor);
            }
        }

        return outputImage;
    }


///
public static Bitmap bitplaneSlicing1(Bitmap image) {
    int width = image.getWidth();
    int height = image.getHeight();
    int[] pixels = new int[width * height];
    image.getPixels(pixels, 0, width, 0, 0, width, height);
    Bitmap[] bitmaps = new Bitmap[8];

    // Extract each bitplane
    for (int i = 0; i < 8; i++) {
        int[] bitplanePixels = new int[width * height];
        for (int j = 0; j < pixels.length; j++) {
            int pixel = pixels[j];
            int bit = getBitAtPosition(Color.red(pixel), i);
            int gray = bit * 255;
            bitplanePixels[j] = Color.rgb(gray, gray, gray);
        }
        bitmaps[i] = Bitmap.createBitmap(width, height, Bitmap.Config.RGB_565);
        bitmaps[i].setPixels(bitplanePixels, 0, width, 0, 0, width, height);
    }

    Bitmap a=createGridImage(bitmaps,3);
    return a;
}

    private static int getBitAtPosition(int number, int position) {
        return (number >> position) & 1;
    }


    public static Bitmap createGridImage(Bitmap[] bitmapArray, int columns) {
        int rows = (int) Math.ceil((double) bitmapArray.length / columns);
        int width = bitmapArray[0].getWidth();
        int height = bitmapArray[0].getHeight();
        int gridWidth = columns * width;
        int gridHeight = rows * height;
        Bitmap gridImage = Bitmap.createBitmap(gridWidth, gridHeight, Bitmap.Config.ARGB_8888);

        Canvas canvas = new Canvas(gridImage);

        int row = 0;
        int column = 0;
        for (Bitmap bitmap : bitmapArray) {
            canvas.drawBitmap(bitmap, column * width, row * height, null);
            column++;
            if (column == columns) {
                column = 0;
                row++;
            }
        }

        return gridImage;
    }


    public static Bitmap reconstructImageWithList(Bitmap[] bitplanes,int bitPlane) {
        int width = bitplanes[0].getWidth();
    int height = bitplanes[0].getHeight();

    Bitmap combined = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);

    for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
            int pixel = 0;
            for (int i = 0; i < bitPlane; i++) {
                int bit = ((bitplanes[i].getPixel(x, y) & 0xFF) >> (7 - i)) & 0x01;
                pixel |= (bit << i);
            }
            int alpha = 0xFF;
            int color = (alpha << 24) | (pixel << 16) | (pixel << 8) | pixel;
            combined.setPixel(x, y, color);
        }
    }
    
        return combined;
    }
        
    public static Bitmap bitplaneSlicingMerge(Bitmap image,int bitPlane) {
        int width = image.getWidth();
        int height = image.getHeight();
        int[] pixels = new int[width * height];
        image.getPixels(pixels, 0, width, 0, 0, width, height);
        Bitmap[] bitmaps = new Bitmap[8];
    
        // Extract each bitplane
        for (int i = 0; i < 8; i++) {
            int[] bitplanePixels = new int[width * height];
            for (int j = 0; j < pixels.length; j++) {
                int pixel = pixels[j];
                int bit = getBitAtPosition(Color.red(pixel), i);
                int gray = bit * 255;
                bitplanePixels[j] = Color.rgb(gray, gray, gray);
            }
            bitmaps[i] = Bitmap.createBitmap(width, height, Bitmap.Config.RGB_565);
            bitmaps[i].setPixels(bitplanePixels, 0, width, 0, 0, width, height);
        }
        
        Bitmap a=reconstructImageWithList(bitmaps,bitPlane);
        return a;

    }

}
