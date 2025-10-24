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


## clear edges
image = cv2.imread(path4, cv2.IMREAD_GRAYSCALE)
show_img_and_wait(image, "windowww")
gaus_blur = cv2.GaussianBlur(image, ksize=(7, 7), sigmaX=5, sigmaY=5)
median_blur = cv2.medianBlur(image, ksize=7)

gaus_edges = cv2.Canny(
    gaus_blur, 500, 900, apertureSize=5, L2gradient=True
)  # l2 normalise helps a lot tho
show_img_and_wait(gaus_edges, "canny gaus blur")

med_edges = cv2.Canny(median_blur, 500, 1200, apertureSize=5, L2gradient=True)
show_img_and_wait(med_edges, "canny median blur")
cv2.destroyAllWindows()


##unclear edges
image = cv2.imread(path5, cv2.IMREAD_GRAYSCALE)
show_img_and_wait(image, "windowww")
blur_img = cv2.GaussianBlur(image, ksize=(3, 3), sigmaX=2, sigmaY=2)
show_img_and_wait(blur_img, "blur")
edges = cv2.Canny(blur_img, 500, 1000, apertureSize=5)
show_img_and_wait(edges, "canny")
cv2.destroyAllWindows()


""" testing module
image = cv2.imread(path4, cv2.IMREAD_GRAYSCALE)
show_img_and_wait(image, "windowww")
blur_img = cv2.GaussianBlur(image, ksize=(9, 9), sigmaX=5, sigmaY=5)
show_img_and_wait(blur_img, "blur")
t1 = 200
t2 = t1 * 2.2
dt = t2 * 0.1
for _ in range(10):  
    edges = cv2.Canny(blur_img, t1, t2, apertureSize=5)
    show_img_and_wait(edges, "canny")
    cv2.destroyAllWindows()
    t2 += dt
    t1 += dt 
"""
