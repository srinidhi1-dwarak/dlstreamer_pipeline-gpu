#!/bin/bash
echo "=== 6-Stream Ultra-Optimized Demo ===" > 6stream_results.txt

# Start GPU monitoring
intel_gpu_top -o 6stream_gpu.log &
GPU_PID=$!

echo "Starting 6-Stream Ultra-Optimized Demo..."

PATTERNS=(ball smpte snow checkers-1 circular blink)

for i in {1..6}; do
  PATTERN=${PATTERNS[$((i-1))]}
  
  gst-launch-1.0 videotestsrc pattern=$PATTERN num-buffers=900 ! \
    video/x-raw,width=320,height=240,framerate=30/1 ! \
    gvadetect model=$DETECTION_MODEL_FP32 device=GPU \
      batch-size=8 inference-interval=8 nireq=4 \
      model-instance-id=inf0 ie-config=PERFORMANCE_HINT=THROUGHPUT ! \
    gvatrack tracking-type=short-term-imageless ! \
    gvaclassify model=$CLASSIFICATION_MODEL_FP32 device=GPU \
      batch-size=16 inference-interval=12 object-class=person \
      model-instance-id=inf1 ie-config=PERFORMANCE_HINT=THROUGHPUT ! \
    gvafpscounter interval=3 ! gvawatermark ! videoconvert ! \
    ximagesink sync=false async=false &
  
  sleep 0.5
done

sleep 35
pkill gst-launch-1.0
kill $GPU_PID
echo "6-stream ultra-optimized demo completed" >> 6stream_results.txt
