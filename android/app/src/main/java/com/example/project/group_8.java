package com.example.project;
import android.graphics.Bitmap;

public class group_8 {


    public static Bitmap equalizeHistogram(Bitmap input, int lowIn, int highIn, int lowOut, int highOut) {
        int[] histogram = new int[256];
        int[] mapping = new int[256];

        int width = input.getWidth();
        int height = input.getHeight();
        int pixelCount = width * height;

        Bitmap output = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);

        // Step 1: Compute histogram
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                int pixel = input.getPixel(x, y);
                int red = (pixel >> 16) & 0xff;
                histogram[red]++;
            }
        }

        // Step 2: Compute mapping
        float scale = (float) (highOut - lowOut) / pixelCount;
        float inScale = (float) (highIn - lowIn) / pixelCount;
        float sum = 0.0f;
        for (int i = 0; i < 256; i++) {
            sum += histogram[i];
            mapping[i] = (int) (lowOut+sum * scale + 0.5f);
        }
        // Step 3: Map pixels to new values
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                int pixel = input.getPixel(x, y);
                int alpha = (pixel >> 24) & 0xff;
                int red = (pixel >> 16) & 0xff;
                int green = (pixel >> 8) & 0xff;
                int blue = pixel & 0xff;
                red = mapping[red];
                green = mapping[green];
                blue = mapping[blue];
                output.setPixel(x, y, (alpha << 24) | (red << 16) | (green << 8) | blue);
            }
        }

        return output;
    }}



