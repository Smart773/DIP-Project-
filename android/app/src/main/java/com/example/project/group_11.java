package com.example.project;
import android.graphics.Bitmap;
import android.graphics.Color;
import java.util.ArrayList;
import java.util.Collections;

public class group_11 {
    
    public static Bitmap applyFilter(Bitmap bitmap) {
        
        float[][] kernel = {{-1, -1, -1},
                  {-1,  8, -1},
                  {-1, -1, -1}};
        int width = bitmap.getWidth();
        int height = bitmap.getHeight();
        Bitmap output = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);

        int kernelSize = kernel.length;
        int kernelRadius = kernelSize / 2;

        int[] pixels = new int[width * height];
        int[] outputPixels = new int[width * height];
        bitmap.getPixels(pixels, 0, width, 0, 0, width, height);

        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                float red = 0.0f;
                float green = 0.0f;
                float blue = 0.0f;
                float alpha = 0.0f;
                float weightSum = 0.0f;

                for (int ky = 0; ky < kernelSize; ky++) {
                    int iy = y + ky - kernelRadius;
                    if (iy < 0 || iy >= height) {
                        continue;
                    }

                    for (int kx = 0; kx < kernelSize; kx++) {
                        int ix = x + kx - kernelRadius;
                        if (ix < 0 || ix >= width) {
                            continue;
                        }

                        int pixel = pixels[iy * width + ix];
                        float kernelValue = kernel[ky][kx];
                        red += Color.red(pixel) * kernelValue;
                        green += Color.green(pixel) * kernelValue;
                        blue += Color.blue(pixel) * kernelValue;
                        alpha += Color.alpha(pixel) * kernelValue;
                        weightSum += kernelValue;
                    }
                }

                red /= weightSum;
                green /= weightSum;
                blue /= weightSum;
                alpha /= weightSum;

                int outputPixel = Color.argb((int) alpha, (int) red, (int) green, (int) blue);
                outputPixels[y * width + x] = outputPixel;
            }
        }

        output.setPixels(outputPixels, 0, width, 0, 0, width, height);
        return output;
 }

 private static int getMedian(ArrayList<Integer> list) {
    Collections.sort(list);
    int size = list.size();
    if (size % 2 == 0) {
        return (list.get(size / 2) + list.get(size / 2 - 1)) / 2;
    } else {
        return list.get(size / 2);
    }
}

public static Bitmap applyMedianFilter(Bitmap bitmap) {
    int filterSize=3;
    int width = bitmap.getWidth();
    int height = bitmap.getHeight();
    int[] pixels = new int[width * height];
    bitmap.getPixels(pixels, 0, width, 0, 0, width, height);
    Bitmap filteredBitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
    int padding = filterSize / 2;
    ArrayList<Integer> windowPixels = new ArrayList<>();
    int pixelIndex;
    for (int row = padding; row < height - padding; row++) {
        for (int col = padding; col < width - padding; col++) {
            windowPixels.clear();
            for (int i = -padding; i <= padding; i++) {
                for (int j = -padding; j <= padding; j++) {
                    pixelIndex = (row + i) * width + col + j;
                    windowPixels.add(Color.red(pixels[pixelIndex]));
                }
            }
            int median = getMedian(windowPixels);
            pixelIndex = row * width + col;
            int alpha = Color.alpha(pixels[pixelIndex]);
            int red = median;
            int green = median;
            int blue = median;
            int filteredPixel = Color.argb(alpha, red, green, blue);
            filteredBitmap.setPixel(col, row, filteredPixel);
        }
    }
    return filteredBitmap;
}

}
