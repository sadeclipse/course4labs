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
    path2 = r"/Users/new/Desktop/course4labs/cv/lab2/2-2.jpg"
    image = cv2.imread(path2, cv2.IMREAD_GRAYSCALE)
    cv2.imshow("sourcePic", image)
    cv2.waitKey(0)
    test_kernel = np.full(shape=(2, 2), fill_value=2)
    first_clear = erode_and_dilate(
        image=image, mode="close", iterations=1, kernel=test_kernel  ## zamikanie
    )
    second_clear = cv2.dilate(
        first_clear, kernel=test_kernel, iterations=1
    )  ## narashivanie
    show_img_and_wait(image=second_clear, win_name="decrease noise")


if __name__ == "__main__":
    main()
