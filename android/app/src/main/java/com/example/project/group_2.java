package com.example.project;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.Matrix;
import android.graphics.Canvas;

public class group_2 {
    public static Bitmap imageRotate(Bitmap inputImage, float angle)  {
        double rads = Math.toRadians(angle);
        double sin = Math.abs(Math.sin(rads));
        double cos = Math.abs(Math.cos(rads));
        int width = inputImage.getWidth();
        int height = inputImage.getHeight();
        Matrix matrix = new Matrix();
    
        matrix.setValues(new float[]{
                (float)cos,(float)sin,0f,
                -(float)sin,(float)cos,0f,
                0f,0f,1f
        });
        Bitmap rotatedBitmap = Bitmap.createBitmap(inputImage, 0, 0, width, height, matrix, true);
        return rotatedBitmap;
    }

    public static Bitmap shearImage(Bitmap inputImage, double shearFactor) {
        int width = inputImage.getWidth();
        int height = inputImage.getHeight();
    
        Matrix matrix = new Matrix();
        matrix.setValues(new float[]{
                1, (float)shearFactor, 0,
                0, 1, 0,
                0, 0, 1
        });
    
        Bitmap outputImage = Bitmap.createBitmap(width, height, inputImage.getConfig());
        Canvas canvas = new Canvas(outputImage);
        canvas.drawBitmap(inputImage, matrix, null);
    
        return outputImage;
    }
    
    
    public static Bitmap scaleImage(Bitmap inputImage, double scaleFactor) {
        int width = inputImage.getWidth();
        int height = inputImage.getHeight();
        int newWidth = (int) Math.round(width * scaleFactor);
        int newHeight = (int) Math.round(height * scaleFactor);
        Matrix matrix = new Matrix();
        matrix.setValues(new float[]{
                (float) scaleFactor, 0f, 0f,
                0f, (float) scaleFactor, 0f,
                0f, 0f, 1f
        });
        Bitmap outputImage = Bitmap.createBitmap(inputImage, 0, 0, newWidth, newHeight, matrix, true);
    
        return outputImage;
    }
    
    
}
