set -e -x

PYTHON_DIR=~/workflow/anaconda3/bin
startDate=`date +%Y%m%d%H%M%S`

# download SQuAD and Glove
#sh download.sh

# preprocess the data
#${PYTHON_DIR}/python config.py --mode prepro

# debug
#${PYTHON_DIR}/python config.py --mode debug

# train
${PYTHON_DIR}/python config.py --mode train &> logs/log.train

# test
${PYTHON_DIR}/python config.py --mode test &> logs/log.test

# offical evaluation
${PYTHON_DIR}/python evaluate-v1.1.py ~/data/squad/dev-v1.1.json log/answer/answer.json &> logs/log.eva

mkdir -p backup/${startDate}
cp -rp log logs config.py model.py backup/${startDate}
cp -rp backup/${startDate} /fds/rnet/backup/${startDate}

echo "finished ^_^"
