import cv2
import numpy as np

# for mac
path3 = "/Users/new/Desktop/course4labs/cv/lab1/1_3.png"
# for win
# path3 = r"C:\Users\user\Desktop\course4labs\cv\lab1\1_3.png"


# Загрузка изображения в градациях серого
image = cv2.imread(path3, cv2.IMREAD_GRAYSCALE)

# Определение порога
threshold_value = 120

# Ручной метод
# Пороговое преобразование до нуля
_, tozero = cv2.threshold(image, threshold_value, 255, cv2.THRESH_BINARY)

# Отображение результатов
cv2.namedWindow("Original", cv2.WINDOW_FULLSCREEN)
cv2.moveWindow("Original", 0, 0)
cv2.imshow("Original", image)
cv2.waitKey(0)
cv2.destroyAllWindows()

cv2.namedWindow("Threshold", cv2.WINDOW_FULLSCREEN)
cv2.moveWindow("Threshold", 0, 0)
cv2.imshow("Threshold", tozero)
cv2.waitKey(0)
cv2.destroyAllWindows()

# Автоматический метод подбора порогового значения
# метод Отсу
tr1, otsu = cv2.threshold(image, threshold_value, 255, cv2.THRESH_OTSU)
# Метод треугольника
tr2, triangle = cv2.threshold(image, threshold_value, 255, cv2.THRESH_TRIANGLE)
cv2.imshow("Original", image)
cv2.moveWindow("Original", 0, 0)
cv2.waitKey(0)
cv2.destroyAllWindows()
cv2.imshow("otsu", otsu)
cv2.moveWindow("otsu", 0, 0)
cv2.waitKey(0)
cv2.destroyAllWindows()
cv2.imshow("triangle", triangle)
cv2.moveWindow("triangle", 0, 0)
cv2.waitKey(0)
cv2.destroyAllWindows()

# Adaptive method
adaptive_thresh = cv2.adaptiveThreshold(
    image,
    max_val=255,
    adaptive_method=cv2.ADAPTIVE_THRESH_MEAN_C,
    type=cv2.THRESH_BINARY_INV,
    blockSize=11,
    C=23,
)
cv2.imshow("Adaptive Threshold", adaptive_thresh)
cv2.moveWindow("Adaptive Threshold", 0, 0)
cv2.waitKey(0)
cv2.destroyAllWindows()
