# script to create the campaign for video within labelquest

ROOT_DIR=$( cd $( dirname $( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd ) ) && pwd )
echo $ROOT_DIR

# need your auth token? head over to https://APP_SITE/api/lq/v1/uam/auth
export WORK_DIR=$ROOT_DIR/cmlp/work

export URL_MEDIA=https://vmlr-workshop.STORAGE
if false; then
#export URL_MEDIA=http://content.research.DOMAIN/projects/mlci_2020/content
    export URL_ROOT=https://APP_SITE
    export AUTH_PATH=$WORK_DIR/auth.json
else
    export URL_ROOT=https://lq.web.DOMAIN
    export AUTH_PATH=$ROOT_DIR/auth_web.json
fi
#export URL_ROOT=http://localhost:5000

