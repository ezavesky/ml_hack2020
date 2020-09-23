# script to create the campaign for video within labelquest

ROOT_DIR=$( cd $( dirname $( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd ) ) && pwd )
echo $ROOT_DIR

# need your auth token? head over to https://APP_SITE/api/lq/v1/uam/auth

#URL_MEDIA=http://content.research.DOMAIN/projects/mlci_2020/content
URL_MEDIA=https://vmlr-workshop.STORAGE
URL_ROOT=https://APP_SITE
#URL_ROOT=https://lq.web.DOMAIN
#URL_ROOT=http://localhost:5000
#AUTH_PATH=$ROOT_DIR/auth_web.json
AUTH_PATH=$ROOT_DIR/auth.json

cd $ROOT_DIR
echo "--- list all existing projects --- " 
python packages/pylq/lq/content_label.py -n mlci_2020_primary --auth_path $AUTH_PATH --ssl_ignore projects  --url_root $URL_ROOT

echo "--- delete prior instance --- " 
python packages/pylq/lq/content_label.py -n mlci_2020_primary --auth_path $AUTH_PATH --ssl_ignore delete  --url_root $URL_ROOT

echo "--- create new project --- " 
python packages/pylq/lq/content_label.py -n mlci_2020_primary --auth_path $AUTH_PATH --ssl_ignore -m $ROOT_DIR/features/assets.txt --media_url "$URL_MEDIA" -c $ROOT_DIR/features/classes.txt --campaign_question $ROOT_DIR/features/question.txt --url_root $URL_ROOT --media_rate "1.25" create
