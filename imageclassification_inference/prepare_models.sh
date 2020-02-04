#!/bin/sh
wget -O model.zip "URL"
unar -o test/inference/imageclassification model.zip
cp -r test/inference/imageclassification/model ../imageclassification_inference_example/
rm model.zip
