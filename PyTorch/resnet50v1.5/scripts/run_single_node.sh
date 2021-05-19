# !/bin/bash

WORKSPACE=${1:-"/DLPerf/PyTorch/resnet50v1.5"}
DATA_DIR=${2:-"/imagenet/imagenet"}
#NODE="127.0.0.1:11222"


i=1
while [ $i -le 5 ]
do
  #bash ${WORKSPACE}/scripts/single_node_train.sh ${WORKSPACE} ${DATA_DIR} ${NODE} 0 128 1 $i
  bash ${WORKSPACE}/scripts/single_node_train.sh ${WORKSPACE} ${DATA_DIR} 0 400 1 $i
  echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Finished Test Case ${i}! <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
  let i++
  sleep 20
done


i=1
while [ $i -le 5 ]
do
  #bash ${WORKSPACE}/scripts/single_node_train.sh ${WORKSPACE} ${DATA_DIR} ${NODE} 0,1,2,3 128 1 $i
  bash ${WORKSPACE}/scripts/single_node_train.sh ${WORKSPACE} ${DATA_DIR} 0,1,2,3 400 1 $i
  echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Finished Test Case ${i}! <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
  let i++
  sleep 20
done

i=1
while [ $i -le 5 ]
do
  bash ${WORKSPACE}/scripts/single_node_train.sh ${WORKSPACE} ${DATA_DIR} 0,1,2,3,4,5,6,7 400 1 $i
  echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Finished Test Case ${i}! <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
  let i++
  sleep 20
done
