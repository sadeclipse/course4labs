import cv2
import numpy as np

# for mac
path1 = "/Users/new/Desktop/course4labs/cv/lab1/1_1.jpg"
# for win
# path1 = r"C:\Users\user\Desktop\course4labs\cv\lab1\1_1.jpg"

#my cool class
class Picture:
    def __init__(self, path, readmode, lifetime, winName) -> None:
        self.path = path
        self.readmode = readmode
        self.lifetime = lifetime
        self.win_name = winName

    def drawAndClosePic(self):
        image = cv2.imread(self.path, self.readmode)
        cv2.namedWindow(self.win_name, cv2.WINDOW_FULLSCREEN)
        cv2.moveWindow(self.win_name, 0, 0)
        cv2.imshow(self.win_name, image)
        cv2.waitKey(delay=self.lifetime)
        cv2.destroyWindow(self.win_name)

    def drawAndWaitKey(self):
        image = cv2.imread(self.path, self.readmode)
        cv2.namedWindow(self.win_name, cv2.WINDOW_FULLSCREEN)
        cv2.moveWindow(self.win_name, 0, 0)
        cv2.imshow(self.win_name, image)
        key = cv2.waitKey(0)
        while key != 27:
            key = cv2.waitKey(0)
        cv2.destroyAllWindows()

    def swapChannels(self):
        image = cv2.imread(self.path, cv2.IMREAD_COLOR)
        b, g, r = cv2.split(image)
        img_rgb = cv2.merge([b, r, g])  # type: ignore
        cv2.namedWindow(self.win_name, cv2.WINDOW_FULLSCREEN)
        cv2.moveWindow(self.win_name, 0, 0)
        cv2.imshow(self.win_name, img_rgb)
        cv2.waitKey(delay=self.lifetime)
        cv2.destroyWindow(self.win_name)


image1 = Picture(
    path=path1, readmode=cv2.IMREAD_COLOR, lifetime=5000, winName="fullcolor"
)
image2 = Picture(
    path=path1, readmode=cv2.IMREAD_GRAYSCALE, lifetime=7000, winName="fullgray"
)
image3 = Picture(
    path=path1,
    readmode=cv2.IMREAD_REDUCED_COLOR_2,
    lifetime=9000,
    winName="halfcolored",
)
image4 = Picture(
    path=path1,
    readmode=cv2.IMREAD_REDUCED_GRAYSCALE_4,
    lifetime=11000,
    winName="quartergrey",
)
l = [image1, image2, image3, image4]
for item in l:
    item.drawAndClosePic()

image5 = Picture(
    path=path1, readmode=cv2.IMREAD_COLOR, lifetime=4000, winName="switched"
)
image5.swapChannels()
image5.win_name = "press esc to exit"
image5.drawAndWaitKey()
