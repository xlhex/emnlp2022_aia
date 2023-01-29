#!/bin/bash
TASK_NAME=$1
SEED=$2
GLUE_DIR=data/$TASK_NAME/attack
OUTPUT_DIR="expr/${1}/attack/${SEED}/"
EXTRACTED_MODEL_DIR=$3

if [ ! -d $OUTPUT_DIR ];then
    mkdir -p $OUTPUT_DIR
fi

log="$OUTPUT_DIR/log.txt"

python attack.py \
    --model_type dstilbert \
    --model_name_or_path bert-base-cased \
    --task_name $TASK_NAME \
    --do_train \
    --do_eval \
    --do_lower_case \
    --data_dir $GLUE_DIR/ \
    --max_seq_length 128 \
    --per_gpu_train_batch_size 64 \
    --per_gpu_eval_batch_size 64 \
    --learning_rate 5e-5 \
    --num_train_epochs 4 \
    --seed $SEED \
    --output_dir $EXTRACTED_MODEL_DIR  > $log 2>&1
