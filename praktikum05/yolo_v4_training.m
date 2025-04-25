detector = yolov4ObjectDetector("tiny-yolov4-coco")
detector.Network
data = load("vehicleTrainingData.mat");
trainingData = data.vehicleTrainingData;
dataDir = fullfile(toolboxdir('vision'),'visiondata');
trainingData.imageFilename = fullfile(dataDir,trainingData.imageFilename);
imds = imageDatastore(trainingData.imageFilename);
blds = boxLabelDatastore(trainingData(:,2:end));
ds = combine(imds,blds);
inputSize = [224 224 3];
trainingDataForEstimation = transform(ds,@(data)preprocessData(data,inputSize));
numAnchors = 6;
[anchors, meanIoU] = estimateAnchorBoxes(trainingDataForEstimation,numAnchors);
area = anchors(:,1).*anchors(:,2);
[~,idx] = sort(area,"descend");
anchors = anchors(idx,:);
anchorBoxes = {anchors(1:3,:);anchors(4:6,:)};

classes = {'vehicle'};
detector = yolov4ObjectDetector("tiny-yolov4-coco",classes,anchorBoxes,InputSize=inputSize);

options = trainingOptions("sgdm", ...
    InitialLearnRate=0.001, ...
    ExecutionEnvironment="cpu", ...
    MiniBatchSize=16,...
    MaxEpochs=40, ...
    BatchNormalizationStatistics="moving",...
    ResetInputNormalization=false,...
    VerboseFrequency=30);
trainedDetector = trainYOLOv4ObjectDetector(ds,detector,options);

I = imread('highway.png');

[bboxes, scores, labels] = detect(trainedDetector,I,Threshold=0.05);
detectedImg = insertObjectAnnotation(I,"Rectangle",bboxes,labels);
figure
imshow(detectedImg)