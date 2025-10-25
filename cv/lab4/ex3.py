import cv2
import numpy as np
from paths import *


def show_and_wait(image, winname="windowww"):
    cv2.namedWindow(winname, cv2.WINDOW_NORMAL)
    cv2.imshow(winname, image)
    cv2.waitKey(0)
    cv2.destroyAllWindows()


def find_circle(path, canvas):
    pic = cv2.imread(path, cv2.IMREAD_COLOR)
    pic_g = cv2.imread(path, cv2.IMREAD_GRAYSCALE)
    pic_f = cv2.GaussianBlur(255 - pic_g, (3, 3), sigmaX=2)
    a = pic.shape[0]
    circles = cv2.HoughCircles(
        image=pic_f,
        method=cv2.HOUGH_GRADIENT,
        dp=1,  ## разрешение аккумулятора
        minDist=a // 20,  ## минимальное расстояние между окружностями(центрами)
        param1=240,  ## верхний трешхолд детектора Кенни (нижний берется как 1/2 от верхнего)
        param2=70,  ## порог аккумулятора
        minRadius=a // 100,  ## минимальный и максимальный радиус
        maxRadius=0,
    )
    circles = np.reshape(circles, shape=(-1, 3))
    biggest_circle = circles[np.argmax(circles[:, 2])]
    center = int(biggest_circle[0]), int(biggest_circle[1])
    radius = int(biggest_circle[2])
    cv2.circle(canvas, center, radius, (255, 255, 255), 3)
    show_and_wait(winname="result with a circled sign", image=canvas)
    show_and_wait(winname="original", image=pic_g)


def create_black(image):
    img = np.zeros_like(image)
    return img


def init(path):
    image = cv2.imread(path, cv2.IMREAD_GRAYSCALE)
    show_and_wait(winname="sourcePic", image=image)
    blurred = cv2.GaussianBlur(src=image, ksize=(3, 3), sigmaX=3, sigmaY=3)
    edges = cv2.Canny(blurred, 100, 200, apertureSize=3, L2gradient=True)
    return image, edges


def main():
    for path in [path2, path5, path4]:
        image, edges = init(path)
        show_and_wait(winname="edges", image=edges)
        black = create_black(image)
        find_circle(path=path, canvas=black)


if __name__ == "__main__":
    main()
