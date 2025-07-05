# dlstreamer_pipeline-gpu

# Intel Unnati Project: Multi-Stream AI Pipeline Optimization on Intel Iris Xe Graphics

This project demonstrates  optimization of multi-stream AI inference pipelines using Intel DL Streamer framework,on Intel Iris Xe Graphics hardware.

Objective
With the exponential growth of AI-powered surveillance and edge computing applications, understanding the limits of Intel integrated graphics is crucial.This project implements highly optimized multi-stream pipelines upto 6 streams on Intel Iris Xe Graphics.

Prerequisites
Hardware:
a)Intel Iris Xe Graphics (TigerLake GT2) or compatible Intel GPU

b)8GB+ RAM

Operating System:

c)Ubuntu 22.04 LTS or more

Software:

d)Docker Engine 20.10+

e)Intel GPU drivers 

f)X11 server (for visual output)

g)Intel DL Streamer Docker image

h)OpenVINO Runtime 2023.0+ 

Pipeline Details

-Base Framework: Intel DL Streamer, GStreamer, OpenVINO Runtime  
-Target Hardware: Intel Iris Xe Graphics (TigerLake GT2)

Optimized Pipeline:
- gvadetect — Advanced person and vehicle detection with batch processing
- gvatrack — Short-term imageless tracking for object continuity  
- gvaclassify — Person attributes classification with inference intervals
- gvafpscounter — Real-time FPS monitoring per stream
- gvawatermark — Visual overlay of detection results
- Runs on GPU (device=GPU) 

Models Used:
- person-vehicle-bike-detection-crossroad-0078 (3.964 GFLOPs)
- person-attributes-recognition-crossroad-0230 (0.174 GFLOPs)

Advanced Optimization Techniques

✅ Inference Interval Optimization: Every 8th frame detection, every 12th frame classification  
✅ Batch Processing: 8-frame detection batches, 16-frame classification batches  
✅ Model Instance Sharing:Efficient memory utilization across streams  
✅ Performance Hint Tuning: THROUGHPUT mode for maximum efficiency  
✅ Tracking Integration: Object continuity between inference operations  
✅ GPU Memory Management: Optimal buffer allocation and sharing  

Project Structure

i)Pipeline Scripts: Automated single-stream, 2-stream, and 6-stream configurations  
ii)Performance Monitoring: Real-time GPU utilization tracking with intel_gpu_top  
iii)Results Analysis: Comprehensive FPS logging, consistency metrics, and bottleneck analysis  
iv)Visualization: Performance charts showing throughput, consistency, and resource utilization  


Author:Srinidhi  

Achieving 95.4% performance consistency across 6 concurrent AI inference streams 

Feel free to clone, study, and use this framework for your own Intel projects

