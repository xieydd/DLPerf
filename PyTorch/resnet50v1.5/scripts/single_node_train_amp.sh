# !/bin/bash

#WORKSPACE=${1:-"/examples/imagenet"}
WORKSPACE=${1:-"/DLPerf/PyTorch/resnet50v1.5"}
DATA_DIR=${2:-"/data"}
MODEL="resnet50"
#NODE1=127.0.0.1:11222
#master_node=${3:-$NODE1}
master_node=$MASTER_ADDR:$MASTER_PORT

gpus=${3:-0}
bz_per_device=${4:-128}
NUM_NODES=${5:-1}
TEST_TIMES=${6:-1}

a=`expr ${#gpus} + 1`
NUM_GPUS=`expr ${a} / 2`
total_bz=`expr ${bz_per_device} \* ${NUM_GPUS}`
LR=$(awk -v total_bz="$total_bz" 'BEGIN{print  total_bz / 1000}')

export CUDA_VISIBLE_DEVICES=${gpus}
LOG_FOLDER=/log/${NUM_NODES}n${NUM_GPUS}g
mkdir -p $LOG_FOLDER
LOGFILE=${LOG_FOLDER}/r50_b${bz_per_device}_fp32_$TEST_TIMES.log

CMD="$WORKSPACE/main_amp.py"
CMD+=" --arch $MODEL"
CMD+=" --epochs 100"
CMD+=" --batch-size $total_bz"
CMD+=" --lr $LR --workers 10"
CMD+=" --momentum 0.125"
CMD+=" --print-freq 1"
CMD+=" --opt-level O0"

#CMD=" python -m torch.distributed.launch $CMD $DATA_DIR "
CMD=" python -m torch.distributed.launch --nproc_per_node=${NUM_GPUS} $CMD $DATA_DIR"

if [ -z "$LOGFILE" ] ; then
   $CMD
else
   (
     $CMD
   ) |& tee $LOGFILE
fi

echo "Writting log to ${LOGFILE}"
