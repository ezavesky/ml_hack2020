# script to create the campaign for video within labelquest

ROOT_DIR=$( cd $( dirname $( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd ) ) && pwd )
echo $ROOT_DIR

# load settings from defined file
source $ROOT_DIR/scripts/40_campaign_settings.sh
# destinations for labels and tasks
DEST_LABELS=$ROOT_DIR/assets/labels_final.json


cd $ROOT_DIR
echo "--- write conslidated labels --- " 
python packages/pylq/lq/content_label.py -n mlci_2020_primary --auth_path $AUTH_PATH --url_root $URL_ROOT --ssl_ignore labels  --task_path $DEST_LABELS
rsync -aP $DEST_LABELS $WORK_DIR/assets/.

