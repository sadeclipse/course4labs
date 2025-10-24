import cv2
import numpy as np

# for mac
path4 = "/Users/new/Desktop/course4labs/cv/lab1/1_4.PNG"
# for win
# path4 = r"C:\Users\user\Desktop\course4labs\cv\lab1\1_4.PNG"

image = cv2.imread(path4, cv2.IMREAD_COLOR)
blurredImage = cv2.blur(image, (3, 3))
boxFilteredImageN = cv2.boxFilter(image, -1, (7, 7), normalize=True)
gaussianBlurred = cv2.GaussianBlur(image, (15, 15), 0)
median = cv2.medianBlur(image, 17)
bi = cv2.bilateralFilter(image, 100, 100, 100)

cv2.imshow("original", image)
cv2.moveWindow("original", 0, 0)
cv2.waitKey(0)
cv2.destroyAllWindows()

cv2.imshow("blurred", blurredImage)
cv2.moveWindow("blurred", 0, 0)
cv2.waitKey(0)
cv2.destroyAllWindows()

cv2.imshow("boxedFiltered", boxFilteredImageN)
cv2.moveWindow("boxedFiltered", 0, 0)
cv2.waitKey(0)
cv2.destroyAllWindows()

cv2.imshow("gaussian", gaussianBlurred)
cv2.moveWindow("gaussian", 0, 0)
cv2.waitKey(0)
cv2.destroyAllWindows()

cv2.imshow("median", median)
cv2.moveWindow("median", 0, 0)
cv2.waitKey(0)
cv2.destroyAllWindows()

cv2.imshow("bilateral", bi)
cv2.moveWindow("bilateral", 0, 0)
cv2.waitKey(0)
cv2.destroyAllWindows()
