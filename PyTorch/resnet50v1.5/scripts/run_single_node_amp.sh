# !/bin/bash

WORKSPACE=${1:-"/DLPerf/PyTorch/resnet50v1.5"}
DATA_DIR=${2:-"/imagenet/imagenet"}
#NODE="127.0.0.1:11222"


bash ${WORKSPACE}/scripts/single_node_train_amp.sh ${WORKSPACE} ${DATA_DIR} 0,1,2,3,4,5,6,7 320 1 1 
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Finished Test Case ! <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
