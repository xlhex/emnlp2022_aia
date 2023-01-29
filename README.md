# Extracted BERT Model Leaks More Information than You Think!

## Descriptions
This repo contains source code and pre-processed corpora for Extracted BERT Model Leaks More Information than You Think! (accepted to EMNLP 2022) ([paper](https://arxiv.org/abs/2210.11735)) ([code](https://github.com/xlhex/emnlp2022_aia))

## Dependencies
* python3
* pytorch>=1.4
* transformers==3.0.2
* cuda 10.0

## Data
Please download data from [here](https://drive.google.com/file/d/1hd1mVkhrNaOt9cIhDEq83TmjRZ2_0IAX/view?usp=sharing)

## Usage
```shell
git clone https://github.com/xlhex/emnlp2022_aia.git
```

## Train a victim model
```shell
TASK=blog
SEED=1234
sh train_vic.sh $TASK $SEED
```

## Query the victim model
```shell
TASK=blog
SEED=1234
QUERY_FILE=review_1x.tsv
PRED_FILE=review_1x_temp_1.0_pred.tsv
DEFENSE=temp # temp, perturb, mostleast (refer to Section 5)
sh pred.sh $TASK $SEED $QUERY_FILE $PRED_FILE $DEFENSE

mkdir data/$TASK/review
python construct_distilled_data.py data/$TASK/review_1x.tsv data/$TASK/review_1x_temp_1.0_pred.tsv data/$TASK/review/train.tsv
cd data/$TASK/review
ln -s ../dev.tsv
cd -
```

## Train an extracted model
```shell
TASK=blog
SEED=1234
sh train_extract.sh $TASK $SEED
```

## Attribute inference attack
```shell
TASK=blog
SEED=1234
sh run_attack.sh $TASK $SEED $TASK/review/$SEED/
```

## Citation
Please cite as:

```bibtex
@inproceedings{he2022extracted,
  title={Extracted BERT Model Leaks More Information than You Think!},
  author={Xuanli He, Lingjuan Lyu, Chen Chen, and Qiongkai Xu},
  booktitle={Proceedings of the 2022 Conference on Empirical Methods in Natural Language Processing},
  pages={1530–1537},
  year={2022}
}
```
