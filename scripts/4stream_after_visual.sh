#!/bin/bash
echo "=== 4-Stream Optimized Demo ===" > 4stream_results.txt

# Start GPU monitoring
intel_gpu_top -o 4stream_gpu.log &
GPU_PID=$!

echo "Starting 4-Stream Optimized Demo..."

PATTERNS=(ball smpte snow checkers-1)

for i in {1..4}; do
  PATTERN=${PATTERNS[$((i-1))]}
  
  gst-launch-1.0 videotestsrc pattern=$PATTERN num-buffers=750 ! \
    video/x-raw,width=480,height=360,framerate=25/1 ! \
    gvadetect model=$DETECTION_MODEL_FP32 device=GPU batch-size=4 inference-interval=5 ! \
    gvaclassify model=$CLASSIFICATION_MODEL_FP32 device=GPU batch-size=8 object-class=person ! \
    gvafpscounter interval=3 ! gvawatermark ! videoconvert ! \
    ximagesink sync=false async=false &
  
  sleep 1
done

sleep 35
pkill gst-launch-1.0
kill $GPU_PID
echo "4-stream optimized demo completed" >> 4stream_results.txt
