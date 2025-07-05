#!/bin/bash
echo "Setting up Multi-Stream AI Pipeline Environment..."

# Install Python dependencies
pip install -r requirements.txt

# Set up models directory
export MODELS_PATH=$PWD/models
mkdir -p $MODELS_PATH

# Download models 
if [ ! -f "$MODELS_PATH/intel/person-vehicle-bike-detection-crossroad-0078/FP32/person-vehicle-bike-detection-crossroad-0078.xml" ]; then
    omz_downloader --name person-vehicle-bike-detection-crossroad-0078 -o $MODELS_PATH
fi

if [ ! -f "$MODELS_PATH/intel/person-attributes-recognition-crossroad-0230/FP32/person-attributes-recognition-crossroad-0230.xml" ]; then
    omz_downloader --name person-attributes-recognition-crossroad-0230 -o $MODELS_PATH
fi

# Export environment variables for models
export DETECTION_MODEL_FP32=$MODELS_PATH/intel/person-vehicle-bike-detection-crossroad-0078/FP32/person-vehicle-bike-detection-crossroad-0078.xml
export CLASSIFICATION_MODEL_FP32=$MODELS_PATH/intel/person-attributes-recognition-crossroad-0230/FP32/person-attributes-recognition-crossroad-0230.xml

echo "Setup complete. You can now run the demo scripts from the scripts/ directory."
