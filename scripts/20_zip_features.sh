# Script to build zip files and push data for low-level and tag-level features

ROOT_DIR=$( cd $( dirname $( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd ) ) && pwd ) 
echo $ROOT_DIR

mkdir -p $ROOT_DIR/dist

echo "Please make sure you've downloaded all of your relevant contentai data first... (see 00_make_batch.sh)"

cd $ROOT_DIR/features

# first get the binary/low level features
if [ ! -f "$ROOT_DIR/dist/features_binary.tgz" ]; then
    # see stack page https://stackoverflow.com/a/4269862 for why -- we want only leaf nodes!
    find . -type d -exec sh -c '(ls -p "{}"|grep />/dev/null)||echo "{}"' \; | grep -e '\(videocnn\|vggish\)' > $ROOT_DIR/dist/features_binary.txt
    tar -czvf $ROOT_DIR/dist/features_binary.tgz -T $ROOT_DIR/dist/features_binary.txt
    # find ./ -type d | grep batches | grep -e '\(videocnn\|vggish\)' | xargs zip -9r $ROOT_DIR/dist/features_binary.zip
fi

# now get everything else
if [ ! -f "$ROOT_DIR/dist/features_tag.tgz" ]; then
    find . -type d -exec sh -c '(ls -p "{}"|grep />/dev/null)||echo "{}"' \; | grep batches | grep -v -e '\(videocnn\|vggish\)' > $ROOT_DIR/dist/features_tag.txt
    tar -czvf $ROOT_DIR/dist/features_tag.tgz -T $ROOT_DIR/dist/features_tag.txt
fi
