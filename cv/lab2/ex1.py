import numpy as np
import cv2


def erode_and_dilate(
    image, mode, iterations, kernel=np.ones((3, 3), np.uint8), anchor=None
) -> np.ndarray:
    image_new = image
    if mode == "open":  ## размыкание
        for _ in range(iterations):
            image_new = cv2.erode(image_new, kernel, anchor)
        for _ in range(iterations):
            image_new = cv2.dilate(image_new, kernel, anchor)
    elif mode == "close":  ##замыкание
        for _ in range(iterations):
            image_new = cv2.dilate(image_new, kernel, anchor)
        for _ in range(iterations):
            image_new = cv2.erode(image_new, kernel, anchor)
    else:
        print("wrong mode")

    return image_new


def show_img_and_wait(image, win_name, lifetime=0):
    cv2.imshow(win_name, image)
    cv2.waitKey(lifetime)


def main():
    path1 = r"/Users/new/Desktop/course4labs/cv/lab2/2-1.jpg"
    image = cv2.imread(path1, cv2.IMREAD_GRAYSCALE)
    cv2.imshow("sourcePic", image)
    cv2.waitKey(0)
    # fill given image
    fill_image = erode_and_dilate(image=image, mode="open", iterations=2)
    show_img_and_wait(fill_image, "fill circles custom")
    pr_fill_image = cv2.morphologyEx(
        image, op=cv2.MORPH_OPEN, kernel=np.ones((3, 3), dtype=np.uint8), iterations=2
    )
    show_img_and_wait(pr_fill_image, "fill circles lib")

    ##delete everything inside the circle
    clear_img = erode_and_dilate(
        image=image, mode="close", iterations=1, kernel=np.ones((3, 3), dtype=np.uint8)
    )
    show_img_and_wait(clear_img, "del from cicrles custom")

    pr_clear_img = cv2.morphologyEx(
        image, op=cv2.MORPH_CLOSE, kernel=np.ones((3, 3), dtype=np.uint8), iterations=1
    )
    show_img_and_wait(pr_clear_img, "del from cicrles lib")

    ##saving image
    try:
        cv2.imwrite("saved_image_with_cleared_circles.png", clear_img)
        print("saved successfully")
    except:
        print("smth went wrong")


if __name__ == "__main__":
    main()
