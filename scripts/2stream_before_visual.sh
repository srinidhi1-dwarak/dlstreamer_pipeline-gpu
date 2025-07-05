#!/bin/bash
echo "=== 2-Stream Before Optimization Demo ===" > 2stream_before.txt

# Start GPU monitoring
intel_gpu_top -o 2stream_before_gpu.log &
GPU_PID=$!

echo "Starting 2-Stream Before Optimization Demo..."

# Stream 1 - No optimization
gst-launch-1.0 videotestsrc pattern=ball num-buffers=450 ! \
  video/x-raw,width=640,height=480,framerate=15/1 ! \
  gvadetect model=$DETECTION_MODEL_FP32 device=GPU ! \
  gvaclassify model=$CLASSIFICATION_MODEL_FP32 device=GPU ! \
  gvafpscounter interval=3 ! gvawatermark ! videoconvert ! \
  ximagesink sync=false async=false &

# Stream 2 - No optimization
gst-launch-1.0 videotestsrc pattern=smpte num-buffers=450 ! \
  video/x-raw,width=640,height=480,framerate=15/1 ! \
  gvadetect model=$DETECTION_MODEL_FP32 device=GPU ! \
  gvaclassify model=$CLASSIFICATION_MODEL_FP32 device=GPU ! \
  gvafpscounter interval=3 ! gvawatermark ! videoconvert ! \
  ximagesink sync=false async=false &

sleep 35
pkill gst-launch-1.0
kill $GPU_PID
echo "2-stream before optimization demo completed" >> 2stream_before.txt
