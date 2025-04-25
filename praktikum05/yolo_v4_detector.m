clear all
close all
name = "tiny-yolov4-coco";
detector = yolov4ObjectDetector(name);

disp(detector) 
analyzeNetwork(detector.Network)

img = imread("highway.png");
[bboxes,scores,labels] = detect(detector,img);
detectedImg = insertObjectAnnotation(img,"Rectangle",bboxes,labels);
figure
imshow(detectedImg)

%person 52
%person108 - no result
%person115
%bowl991

img = imread("image.orig/115.jpg");
[bboxes,scores,labels] = detect(detector,img);
detectedImg = insertObjectAnnotation(img,"Rectangle",bboxes,labels);
figure
imshow(detectedImg)

% for i =1:30
%    j = randi(1000)
%    img = imread("image.orig/"+num2str(j)+".jpg");
%    [bboxes,scores,labels] = detect(detector,img);
%    detectedImg = insertObjectAnnotation(img,"Rectangle",bboxes,labels);
%    figure
%    imshow(detectedImg)
% end