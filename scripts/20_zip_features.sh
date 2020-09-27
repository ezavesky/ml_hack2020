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

# now grab the IMDB 5000 movie database from kaggle
if [ ! -f "$ROOT_DIR/dist/features_imdb_5000.csv.tgz" ]; then
    path_expected=$ROOT_DIR/features/movie_metadata.csv
    if [ ! -f $path_expected ]; then
        echo "Please go to this link to re-download the file and place it at '$path_expected' URL: 'https://storage.googleapis.com/kaggle-data-sets/7181/10279/bundle/archive.zip?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=gcp-kaggle-com%40kaggle-161607.iam.gserviceaccount.com%2F20200926%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20200926T142523Z&X-Goog-Expires=259199&X-Goog-SignedHeaders=host&X-Goog-Signature=88cd7b0a14b06715650a84e9ae6cce0885269a6848a120988ff474016d12b016fe4c681c48a30b7ee3b00bb5030b6ef10dc12186b6a6fdac29a42f0ecb72ebc22291000a30b8315151fff5525d053087e64f9f83730ded7b7fdc7968f94b16b3d56540a8319d7075483192770e885863e39345121c173f8e0317435d199c2a59fa928a487e1bc632084a87af6f72fb0bc182b17cd96796700a1ea466d9fe8d025704d13cdf22f552983d2602ba9dc538f00ac8edaebe6fcc623df157263df7feef2c328bb21891380c46c9c613db6d984a47dc7080c3aacf460dbdcfab2675b9a2c23152e0e7efa2f6d7d2e8e2f080380e90ced7357f519c1bb9ec14386265e5'  (from this original site 'https://www.kaggle.com/carolzhangdc/imdb-5000-movie-dataset')" 
    else
        tar -czvf $ROOT_DIR/dist/features_imdb_5000.csv.tgz movie_metadata.csv
    fi
fi
