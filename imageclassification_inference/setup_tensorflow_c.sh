# !/bin/sh
rm -rf ../lib
mkdir -p ../lib
TARGET_DIR=$(cd $(dirname $0); pwd)/../lib
export LIBRARY_PATH=$LIBRARY_PATH:$TARGET_DIR/lib
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$TARGET_DIR/lib
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$TARGET_DIR/include
wget https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-cpu-darwin-x86_64-1.13.1.tar.gz
tar -C $TARGET_DIR -xzf libtensorflow-cpu-darwin-x86_64-1.13.1.tar.gz
rm libtensorflow-cpu-darwin-x86_64-1.13.1.tar.gz

# Create link because dyld_library_path cannot be set.
ln -s $TARGET_DIR/lib/libtensorflow.so /usr/local/lib
ln -s $TARGET_DIR/lib/libtensorflow_framework.so /usr/local/lib
