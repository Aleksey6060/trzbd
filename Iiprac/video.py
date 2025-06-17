from ultralytics import YOLO
import cv2
import numpy as np
import argparse

def video_check(video_path):
    model = YOLO('best.pt')

    video = cv2.VideoCapture(video_path)

    if not video.isOpened():
        print('Не удалось открыть видео')
        return

    while True:
        ret, frame = video.read()
        if not ret:
            print('Кадр не считался')
            break
        frame_resize = cv2.resize(frame, (500, 500))

        detect_frame = model(frame_resize, imgsz=640, iou=0.4, conf=0.8, verbose=False)
        result = detect_frame[0]
        annotated_frame = result.plot()

        cv2.imshow("video", annotated_frame)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    video.release()
    cv2.destroyAllWindows()

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Detection object from video')
    parser.add_argument('video_path', type=str, help='Path to video file')
    args = parser.parse_args()

    video_check(args.video_path)