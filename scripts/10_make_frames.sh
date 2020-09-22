#
# Script to make keyframes from videos for easier review in a retrieval interface.
#   ./make_frames content/xmas keyframe
#  
# find content for a directory, populate for full workshop processing
#  -- see reference - https://www.contentai.io/docs/cli#batch-processing
ROOT_DIR=$( cd $( dirname $( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd ) ) && pwd )
cd $ROOT_DIR

cd $1  # change to content dir
mkdir -p $2   # create keyframe subdir
find $1 -type f | grep mp4 | xargs -I {} sh -c "ffmpeg -y -ss 6 -i {}  -t 1 -frames:v 1 -f image2 /tmp/tmp-frames.jpg && convert /tmp/tmp-frames.jpg -geometry 320x $2/{}.jpg"

