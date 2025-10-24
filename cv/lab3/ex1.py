import numpy as np
import cv2

path1 = r"/Users/new/Desktop/course4labs/cv/lab3/3-1.jpg"
path2 = r"/Users/new/Desktop/course4labs/cv/lab3/3-2.jpg"
path3 = r"/Users/new/Desktop/course4labs/cv/lab3/3-3.jpg"
path4 = r"/Users/new/Desktop/course4labs/cv/lab3/3-4.PNG"
path5 = r"/Users/new/Desktop/course4labs/cv/lab3/3-5.jpg"


def show_img_and_wait(image, win_name, lifetime=0):
    cv2.imshow(win_name, image)
    cv2.waitKey(lifetime)


for path in [path1, path2]:
    image = cv2.imread(path, cv2.IMREAD_GRAYSCALE)
    show_img_and_wait(image, "windowww")
    sobelx = cv2.Sobel(image, ddepth=-1, dx=1, dy=0, ksize=5)  # Градиент по X #scale = 1 -  масштаб
    sobely = cv2.Sobel(image, ddepth=-1, dx=0, dy=1, ksize=5)  # Градиент по Y #delta = 0 -  смещение. # btype - border type
    laplace = cv2.Laplacian(image, ddepth=-1, ksize=5)
    show_img_and_wait(sobelx, "sobelx")
    show_img_and_wait(sobely, "sobely")
    show_img_and_wait(laplace, "laplace")
    cv2.destroyAllWindows()
