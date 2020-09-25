# Script to build zip files and push data for low-level and tag-level features

ROOT_DIR=$( cd $( dirname $( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd ) ) && pwd ) 
echo $ROOT_DIR

mkdir -p $ROOT_DIR/dist
rm -rf $ROOT_DIR/notebooks
mkdir -p $ROOT_DIR/notebooks

echo "Please make sure you've downloaded all of your relevant contentai data first... (see 00_make_batch.sh)"

rsync -aP --delete --exclude='.*' --exclude="*auth*.json" --exclude='*.pkl*' --exclude=packages $ROOT_DIR/cmlp/work/. $ROOT_DIR/notebooks/.
cd $ROOT_DIR/notebooks

# grab only the python notebooks and content under 'assets'
rm -f $ROOT_DIR/dist/code.zip
zip -r9 $ROOT_DIR/dist/code.zip . -x "*/.DS*" -x ".*" 
echo "Created file '$ROOT_DIR/dist/code.zip'..."
