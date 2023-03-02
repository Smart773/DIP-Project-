package com.example.project;

import android.graphics.Bitmap;

public class group_6 {
    public static Bitmap registerImage(Bitmap img1, Bitmap img2) {
        int img1Width = img1.getWidth();
        int img1Height = img1.getHeight();
        int img2Width = img2.getWidth();
        int img2Height = img2.getHeight();
        int width = Math.max(img1Width, img2Width);
        int height = Math.max(img1Height, img2Height);
        Bitmap newImg = Bitmap.createBitmap(width, height, img1.getConfig());
        for (int y = 0; y < Math.min(img1Height, img2Height); y++) {
            for (int x = 0; x < Math.min(img1Width, img2Width); x++) {
                int img1X = x;
                int img1Y = y;
                int img2X = x;
                int img2Y = y;
                if (img1Width < img2Width) {
                    img1X = Math.round((float) x * img1Width / img2Width);
                } else if (img2Width < img1Width) {
                    img2X = Math.round((float) x * img2Width / img1Width);
                }
                if (img1Height < img2Height) {
                    img1Y = Math.round((float) y * img1Height / img2Height);
                } else if (img2Height < img1Height) {
                    img2Y = Math.round((float) y * img2Height / img1Height);
                }
                int color1 = img1.getPixel(img1X, img1Y);
                int color2 = img2.getPixel(img2X, img2Y);
                int red = (getRed(color1) + getRed(color2)) / 2;
                int green = (getGreen(color1) + getGreen(color2)) / 2;
                int blue = (getBlue(color1) + getBlue(color2)) / 2;
                int newColor = (red << 16) | (green << 8) | blue | 0xff000000;
                newImg.setPixel(x, y, newColor);
            }
        }
        return newImg;
    }
    

    private static int getBlue(int color1) {
        return color1  & 0xff;
    }

    private static int getGreen(int color1) {
        return (color1 >> 8) & 0xff;
    }

    private static int getRed(int color1) {
        return (color1 >> 16) & 0xff;
    }

}
