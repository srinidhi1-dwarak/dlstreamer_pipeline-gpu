#!/bin/bash
echo "=== 2-Stream After Optimization Demo ===" > 2stream_after.txt

# Start GPU monitoring
intel_gpu_top -o 2stream_after_gpu.log &
GPU_PID=$!

echo "Starting 2-Stream After Optimization Demo..."

# Stream 1 - With optimization
gst-launch-1.0 videotestsrc pattern=ball num-buffers=600 ! \
  video/x-raw,width=640,height=480,framerate=25/1 ! \
  gvadetect model=$DETECTION_MODEL_FP32 device=GPU batch-size=2 inference-interval=3 ! \
  gvaclassify model=$CLASSIFICATION_MODEL_FP32 device=GPU batch-size=4 object-class=person ! \
  gvafpscounter interval=3 ! gvawatermark ! videoconvert ! \
  ximagesink sync=false async=false &

# Stream 2 - With optimization
gst-launch-1.0 videotestsrc pattern=smpte num-buffers=600 ! \
  video/x-raw,width=640,height=480,framerate=25/1 ! \
  gvadetect model=$DETECTION_MODEL_FP32 device=GPU batch-size=2 inference-interval=3 ! \
  gvaclassify model=$CLASSIFICATION_MODEL_FP32 device=GPU batch-size=4 object-class=person ! \
  gvafpscounter interval=3 ! gvawatermark ! videoconvert ! \
  ximagesink sync=false async=false &

sleep 30
pkill gst-launch-1.0
kill $GPU_PID
echo "2-stream after optimization demo completed" >> 2stream_after.txt
