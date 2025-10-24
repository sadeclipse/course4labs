import cv2
import numpy as np

# for mac
path5 = "/Users/new/Desktop/course4labs/cv/lab1/1_5.jpg"
# for winf
# path5 = r"C:\Users\user\Desktop\course4labs\cv\lab1\1_5.jpg"

image = cv2.imread(path5, cv2.IMREAD_COLOR)
median = cv2.medianBlur(image, 63)

cv2.imshow("original", image)
cv2.waitKey(0)
cv2.destroyAllWindows()

cv2.imshow("median", median)
cv2.waitKey(0)
cv2.destroyAllWindows()
