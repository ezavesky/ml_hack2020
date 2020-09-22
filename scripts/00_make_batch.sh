#
# Script to make a batch file for processing via ContentAI.
#  example is  `make_batch.sh content/xmas "xmas|holiday|gifts|etc"
#
# After scirpt execution, you need to remove the last comma on the second-to-last line for valid JSON syntax.
# 
# To execute within contentai, use the batch mode executor:
#   `contentai batch run -f batch.json`   (and record the output batch ID)
# To download cool insights for this patch afterwards:
#   `contentai batch data <BATCHID>

ROOT_DIR=$( cd $( dirname $( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd ) ) && pwd )
echo "Root dir: $ROOT_DIR"
cd $ROOT_DIR

# find content for a directory, populate for full workshop processing
#  -- see reference - https://www.contentai.io/docs/cli#batch-processing
QUERYSTR=$2
echo "{ \"metadata\": { \"name\": \"batch-$1\", \"query\":\"$QUERYSTR\" }, " > batch-$1.json
echo '"workflow": "digraph { azure_videoindexer -> dsai_metadata_flatten; dsai_moderation_image -> dsai_metadata_flatten; azure_videoindexer-> dsai_moderation_text -> dsai_metadata_flatten; dsai_videocnn -> dsai_activity_classifier -> dsai_metadata_flatten; dsai_vggish -> dsai_activity_classifier -> dsai_metadata_flatten}",  ' >> batch-$1.json
echo '"content": {' >> batch-$1.json
find $1 -type f | grep mp4 | grep -v -e '\.jpg' | xargs -I {} echo '"https://vmlr-workshop.STORAGE/{}": { },' >> batch-$1.json
echo '} } ' >> batch-$1.json

