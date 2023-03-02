// package com.example.project;

// import android.graphics.Bitmap;
// import android.graphics.Canvas;
// import android.graphics.ColorFilter;
// import android.graphics.ColorMatrix;
// import android.graphics.ColorMatrixColorFilter;
// import android.graphics.Paint;
// import android.graphics.Point;

// import java.util.ArrayList;
// import java.util.List;

// public class ImageRegistration {

//     // Preprocessing step: convert the input images to grayscale
//     public static Bitmap toGray(Bitmap input) {
//         Bitmap output = Bitmap.createBitmap(input.getWidth(), input.getHeight(), Bitmap.Config.RGB_565);
//         Canvas canvas = new Canvas(output);
//         ColorMatrix colorMatrix = new ColorMatrix();
//         colorMatrix.setSaturation(0);
//         Paint paint = new Paint();
//         ColorFilter filter = new ColorMatrixColorFilter(colorMatrix);
//         paint.setColorFilter(filter);
//         canvas.drawBitmap(input, 0, 0, paint);
//         return output;
//     }

//     // Feature extraction step: detect corners using the Harris corner detection algorithm
//     public static List<Point> detectCorners(Bitmap input) {
//         Mat image = new Mat();
//         Utils.bitmapToMat(input, image);
//         Mat gray = new Mat();
//         Imgproc.cvtColor(image, gray, Imgproc.COLOR_BGR2GRAY);
//         Mat corners = new Mat();
//         Imgproc.cornerHarris(gray, corners, 2, 3, 0.04);
//         List<Point> cornerPoints = new ArrayList<>();
//         for (int i = 0; i < corners.rows(); i++) {
//             for (int j = 0; j < corners.cols(); j++) {
//                 double[] values = corners.get(i, j);
//                 if (values[0] > threshold) {
//                     cornerPoints.add(new Point(j, i));
//                 }
//             }
//         }
//         return cornerPoints;
//     }

//     // Feature matching step: match the feature points using the Euclidean distance
//     public static List<Point> matchFeatures(List<Point> points1, List<Point> points2) {
//         List<Point> matchedPoints = new ArrayList<>();
//         for (Point p1 : points1) {
//             Point bestMatch = null;
//             double minDist = Double.MAX_VALUE;
//             for (Point p2 : points2) {
//                 double dist = Math.sqrt(Math.pow(p1.x - p2.x, 2) + Math.pow(p1.y - p2.y, 2));
//                 if (dist < minDist) {
//                     minDist = dist;
//                     bestMatch = p2;
//                 }
//             }
//             if (bestMatch != null) {
//                 matchedPoints.add(bestMatch);
//             }
//         }
//         return matchedPoints;
//     }

//     // Transformation estimation step: compute the transformation matrix using the Least-Squares algorithm
//     public static Mat computeTransformationMatrix(List<Point> points1, List<Point> points2) {
//         Mat A = new Mat(points1.size(), 6, CvType.CV_64FC1);
//         Mat B = new Mat(points2.size(), 2, CvType.CV_64FC1);
//         for (int i = 0; i < points1.size(); i++)
