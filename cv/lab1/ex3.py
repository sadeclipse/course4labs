import cv2
import numpy as np

# for mac
path2 = "/Users/new/Desktop/course4labs/cv/lab1/1_2.jpg"
# for win
#path2 = r"C:\Users\user\Desktop\course4labs\cv\lab1\1_2.jpg"

threshold_value = 160

image = cv2.imread(path2, cv2.IMREAD_GRAYSCALE)
cv2.namedWindow("original", cv2.WINDOW_NORMAL)
cv2.moveWindow("original", 0, 0)
cv2.imshow("original", image)
cv2.waitKey(0)
cv2.destroyAllWindows()

_, crosswalk = cv2.threshold(image, threshold_value, 255, cv2.THRESH_BINARY)
cv2.namedWindow("bin", cv2.WINDOW_NORMAL)
cv2.moveWindow("bin", 0, 0)
cv2.imshow("bin", crosswalk)

cv2.waitKey(0)
cv2.destroyAllWindows()
