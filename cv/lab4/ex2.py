import cv2
import numpy as np
from paths import *

path1 = r"/Users/new/Desktop/course4labs/cv/lab2/2-1.jpg"


def dist(point: list):
    return ((point[0] - point[2]) ** 2 + (point[1] - point[3]) ** 2) ** (1 / 2)


def create_black(image):
    img = np.zeros_like(image)
    return img


def init(path):
    image = cv2.imread(path, cv2.IMREAD_GRAYSCALE)
    show_and_wait(winname="sourcePic", image=image)
    # clear from isnides given image
    clear_img = cv2.morphologyEx(
        image, op=cv2.MORPH_CLOSE, kernel=np.ones((3, 3), dtype=np.uint8), iterations=1
    )
    image_reverse = 255 - clear_img
    show_and_wait(winname="reversePic", image=image_reverse)
    blurred = cv2.medianBlur(image_reverse, ksize=3)
    edges = cv2.Canny(blurred, 100, 200, apertureSize=3, L2gradient=True)
    return image, edges


def draw_longest_line(edges, image):
    lines = cv2.HoughLinesP(
        edges, rho=1, theta=np.pi / 360, threshold=80, minLineLength=30, maxLineGap=15
    )
    lines = np.reshape(lines, shape=(11, 4))
    black = create_black(image)
    mapped_lines = list(map(lambda line: dist(line), lines))
    x1, y1, x2, y2 = lines[np.argmax(mapped_lines)]
    cv2.line(black, (x1, y1), (x2, y2), (255, 255, 255), 2)
    return black


def show_and_wait(image, winname="windowww"):
    cv2.imshow(winname, image)
    cv2.waitKey(0)
    cv2.destroyAllWindows()


def find_biggest_circle(path, canvas):
    pic = cv2.imread(path, cv2.IMREAD_COLOR)
    pic_g = cv2.imread(path, cv2.IMREAD_GRAYSCALE)
    pic_f = cv2.GaussianBlur(255 - pic_g, (3, 3), sigmaX=1)
    a = pic.shape[0]
    circles = cv2.HoughCircles(
        image=pic_f,
        method=cv2.HOUGH_GRADIENT,
        dp=1,  ## разрешение аккумулятора
        minDist=a // 20,  ## минимальное расстояние между окружностями(центрами)
        param1=120,  ## верхний трешхолд детектора Кенни (нижний берется как 1/2 от верхнего)
        param2=80,  ## порог аккумулятора
        minRadius=a // 100,  ## минимальный и максимальный радиус
        maxRadius=0,
    )
    circles = np.reshape(circles, shape=(-1, 3))
    biggest_circle = circles[np.argmax(circles[:, 2])]
    center = int(biggest_circle[0]), int(biggest_circle[1])
    radius = int(biggest_circle[2])
    cv2.circle(canvas, center, radius, (255, 255, 255), 3)
    show_and_wait(winname="result", image=canvas)
    show_and_wait(winname="original", image=pic_g)


def main():
    image, edges = init(path1)
    black = draw_longest_line(edges, image)
    show_and_wait(black, "longest line")
    find_biggest_circle(path1, canvas=black)


if __name__ == "__main__":
    main()
