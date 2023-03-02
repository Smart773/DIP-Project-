package com.example.project;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.ColorMatrix;
import android.graphics.ColorMatrixColorFilter;
import android.graphics.Paint;

import java.io.ByteArrayOutputStream;
import androidx.annotation.NonNull;
import java.util.Map;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.embedding.android.FlutterActivity;
public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "samples.flutter.dev/battery";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            // This method is invoked on the main thread.
                            // TODO
                            if (call.method.equals("getImage8")) {
                                Map<String, Object> arguments = call.arguments();
                                byte[] imageData = (byte[]) arguments.get("data");
                                int value1 = (int) arguments.get("value1");
                                int value2 = (int) arguments.get("value2");
                                int value3 = (int) arguments.get("value3");
                                int value4 = (int) arguments.get("value4");
                                Bitmap unProcessImage = bytesToBitmap(imageData);
                                Bitmap processedImage=group_8.equalizeHistogram(unProcessImage,value1,value2,value3,value4);
                                imageData = bitmapToBytes(processedImage);
                                result.success(imageData);
                            }

                            if (call.method.equals("getImage6")) {
                                Map<String, Object> arguments = call.arguments();
                                byte[] imageData = (byte[]) arguments.get("data1");
                                byte[] imageData2 = (byte[]) arguments.get("data2");
                                Bitmap unProcessImage1 = bytesToBitmap(imageData);
                                Bitmap unProcessImage2 = bytesToBitmap(imageData2);
                                Bitmap processedImage=group_6.registerImage(unProcessImage1,unProcessImage2);
                                imageData = bitmapToBytes(processedImage);

                                result.success(imageData);
                            }

                            if (call.method.equals("getImage4")) {
                                Map<String, Object> arguments = call.arguments();
                                byte[] imageData = (byte[]) arguments.get("data");
                                
                                // byte[] imageData = (byte[]) arguments.get("data1");
                                double value = (double) arguments.get("value");
                                Bitmap unProcessImage = bytesToBitmap(imageData);
                                Bitmap processedImage=group_4.applyGammaCorrection(unProcessImage,value);
                                imageData = bitmapToBytes(processedImage);
                                result.success(imageData);
                            }

                            if (call.method.equals("getImage1_2")) {
                                Map<String, Object> arguments = call.arguments();
                                byte[] imageData = (byte[]) arguments.get("data");
                                double value = (double) arguments.get("value");
                                Bitmap unProcessImage = bytesToBitmap(imageData);
                                Bitmap processedImage=group_1.scaleImageNN(unProcessImage,value);
                                imageData = bitmapToBytes(processedImage);
                                result.success(imageData);
                            }

                            if (call.method.equals("getImage1_1")) {
                                Map<String, Object> arguments = call.arguments();
                                byte[] imageData = (byte[]) arguments.get("data");
                                double value = (double) arguments.get("value");
                                Bitmap unProcessImage = bytesToBitmap(imageData);
                                Bitmap processedImage=group_1.scaleImageBilinear(unProcessImage,value);
                                imageData = bitmapToBytes(processedImage);
                                result.success(imageData);
                            }

                            if (call.method.equals("getImage2_1")) {
                                Map<String, Object> arguments = call.arguments();
                                byte[] imageData = (byte[]) arguments.get("data");
                                int value = (int) arguments.get("value");
                                Bitmap unProcessImage = bytesToBitmap(imageData);
                               
                                Bitmap processedImage=group_2.imageRotate(unProcessImage,value);
                                imageData = bitmapToBytes(processedImage);
                                result.success(imageData);
                            }
                            if (call.method.equals("getImage2_2")) {
                                Map<String, Object> arguments = call.arguments();
                                byte[] imageData = (byte[]) arguments.get("data");
                                double value = (double) arguments.get("value");
                                Bitmap unProcessImage = bytesToBitmap(imageData);
                                Bitmap processedImage=group_2.shearImage(unProcessImage,value);
                                imageData = bitmapToBytes(processedImage);
                                result.success(imageData);
                            }
                            if (call.method.equals("getImage2_3")) {
                                Map<String, Object> arguments = call.arguments();
                                byte[] imageData = (byte[]) arguments.get("data");
                                double value = (double) arguments.get("value");
                                Bitmap unProcessImage = bytesToBitmap(imageData);
                                Bitmap processedImage=group_2.scaleImage(unProcessImage,value);
                                imageData = bitmapToBytes(processedImage);
                                result.success(imageData);
                            }

                            
                            if (call.method.equals("getImage3_1")) {
                                Map<String, Object> arguments = call.arguments();
                                byte[] imageData = (byte[]) arguments.get("data1");
                                byte[] imageData2 = (byte[]) arguments.get("data2");
                                Bitmap unProcessImage1 = bytesToBitmap(imageData);
                                Bitmap unProcessImage2 = bytesToBitmap(imageData2);
                                Bitmap processedImage=group_3.addImages(unProcessImage1,unProcessImage2);
                                imageData = bitmapToBytes(processedImage);

                                result.success(imageData);
                            }

                            if(call.method.equals("getImage3_2")){
                                Map<String, Object> arguments = call.arguments();
                                byte[] imageData = (byte[]) arguments.get("data1");
                                byte[] imageData2 = (byte[]) arguments.get("data2");
                                Bitmap unProcessImage1 = bytesToBitmap(imageData);
                                Bitmap unProcessImage2 = bytesToBitmap(imageData2);
                                Bitmap processedImage=group_3.subtractImages(unProcessImage1,unProcessImage2);
                                imageData = bitmapToBytes(processedImage);

                                result.success(imageData);
                            }

                            if (call.method.equals("getImage3_3")) {
                                Map<String, Object> arguments = call.arguments();
                                byte[] imageData = (byte[]) arguments.get("data1");
                                byte[] imageData2 = (byte[]) arguments.get("data2");
                                Bitmap unProcessImage1 = bytesToBitmap(imageData);
                                Bitmap unProcessImage2 = bytesToBitmap(imageData2);
                                Bitmap processedImage=group_3.multiplyImages(unProcessImage1,unProcessImage2);
                                imageData = bitmapToBytes(processedImage);

                                result.success(imageData);
                            }

                            if (call.method.equals("getImage3_4")) {
                                Map<String, Object> arguments = call.arguments();
                                byte[] imageData = (byte[]) arguments.get("data1");
                                byte[] imageData2 = (byte[]) arguments.get("data2");
                                Bitmap unProcessImage1 = bytesToBitmap(imageData);
                                Bitmap unProcessImage2 = bytesToBitmap(imageData2);
                                Bitmap processedImage=group_3.divideImages(unProcessImage1,unProcessImage2);
                                imageData = bitmapToBytes(processedImage);

                                result.success(imageData);
                            }


                            if (call.method.equals("getImage9_2")) {
                                Map<String, Object> arguments = call.arguments();
                                byte[] imageData = (byte[]) arguments.get("data");
                                Bitmap unProcessImage = bytesToBitmap(imageData);
                                Bitmap processedImage=group_9.bitplaneSlicing1(unProcessImage);
                                imageData = bitmapToBytes(processedImage);
                                result.success(imageData);
                            }
                          
                            if (call.method.equals("getImage9_3")) {
                                Map<String, Object> arguments = call.arguments();
                                byte[] imageData = (byte[]) arguments.get("data");
                                int value = (int) arguments.get("value");
                                Bitmap unProcessImage = bytesToBitmap(imageData);
                                Bitmap processedImage=group_9.bitplaneSlicingMerge(unProcessImage,value);
                                imageData = bitmapToBytes(processedImage);
                                result.success(imageData);
                            }

                            if (call.method.equals("getImage9_1")) {
                                Map<String, Object> arguments = call.arguments();
                                byte[] imageData = (byte[]) arguments.get("data");
                                int value1 = (int) arguments.get("value1");
                                int value2 = (int) arguments.get("value2");
                                Bitmap unProcessImage = bytesToBitmap(imageData);
                                Bitmap processedImage=group_9.Intensity_level_slicing(unProcessImage,value1,value2);
                                imageData = bitmapToBytes(processedImage);
                                result.success(imageData);
                            }

                            if (call.method.equals("getImage11_1")) {
                                Map<String, Object> arguments = call.arguments();
                                byte[] imageData = (byte[]) arguments.get("data");
                                Bitmap unProcessImage = bytesToBitmap(imageData);
                                Bitmap processedImage=group_11.applyFilter(unProcessImage);
                                imageData = bitmapToBytes(processedImage);
                                result.success(imageData);
                            }

                            if (call.method.equals("getImage11_2")) {
                                Map<String, Object> arguments = call.arguments();
                                byte[] imageData = (byte[]) arguments.get("data");
                                Bitmap unProcessImage = bytesToBitmap(imageData);
                                Bitmap processedImage=group_11.applyMedianFilter(unProcessImage);
                                imageData = bitmapToBytes(processedImage);
                                result.success(imageData);
                            }
                        }
                );
    }


    ///////////////////////////////Group 8////////////////////////////////////////

    //    /////////////////////////////Group 9 ///////////////////////////////////////////
    /////////////////////////////////////////////////////////////////
//    ///////////////////////////////////////////

    public static byte[] bitmapToBytes(Bitmap bitmap) {

        ByteArrayOutputStream stream = new ByteArrayOutputStream();
        bitmap.compress(Bitmap.CompressFormat.JPEG, 100, stream);
        return stream.toByteArray();
    }

    public static Bitmap bytesToBitmap(byte[] bytes) {
        return BitmapFactory.decodeByteArray(bytes, 0, bytes.length);
    }


    ///////////////////////////////

}