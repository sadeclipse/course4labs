import cv2
import numpy as np
from paths import *


image = cv2.imread(path4_1)
cv2.imshow("window", image)
cv2.waitKey()

image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
# Применение Гауссова размытия для уменьшения шума и улучшения обнаружения границ
blurred = cv2.GaussianBlur(image, (5, 5), 0)
# Обнаружение границ с помощью детектора границ Canny
edges = cv2.Canny(blurred, 50, 150, apertureSize=3)

lines = cv2.HoughLines(
    edges, 1, np.pi / 180, 200
)  # по сути рисуем черными линиями поверх белых, так что они пропадают с изображения
for line in lines:
    rho, theta = line[0]
    a = np.cos(theta)
    b = np.sin(theta)
    x0 = a * rho  ##находим точку пересечения перпендикуляра и самой линии
    y0 = b * rho  ## если вектор перпендикуляра (a,b) то вектор прямой - (-b, a)
    x1 = int(
        x0 + 1000 * (-b)
    )  ## откладваем от точки пересечения 1000 пикселей по прв одно навправление
    y1 = int(y0 + 1000 * (a))
    x2 = int(x0 - 1000 * (-b))  ## откладываем 1000 пикселей в другое направление
    y2 = int(y0 - 1000 * (a))
    cv2.line(
        edges, (x1, y1), (x2, y2), (0, 0, 0), 2
    )  ## рисуем прямую по этим двум точкам

# Отображение результата
cv2.imshow("only numbers", edges)
cv2.waitKey(0)
cv2.destroyAllWindows()
