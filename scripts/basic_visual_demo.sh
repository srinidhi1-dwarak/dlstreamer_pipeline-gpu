#!/bin/bash
echo "=== Basic Pipeline Demo with Visual Output ===" > basic_demo.txt

# Start GPU monitoring
intel_gpu_top -o basic_gpu_monitor.log &
GPU_PID=$!

echo "Starting Basic Pipeline Demo..."
gst-launch-1.0 videotestsrc pattern=ball num-buffers=450 ! \
  video/x-raw,width=640,height=480,framerate=15/1 ! \
  gvadetect model=$DETECTION_MODEL_FP32 device=GPU ! \
  gvaclassify model=$CLASSIFICATION_MODEL_FP32 device=GPU ! \
  gvafpscounter interval=3 ! gvawatermark ! videoconvert ! \
  ximagesink sync=false async=false

# Stop monitoring
kill $GPU_PID
echo "Basic pipeline demo completed" >> basic_demo.txt
echo "GPU data saved to: basic_gpu_monitor.log" >> basic_demo.txt
