# Script to compile and upload an instance of the python labelquest API interface

ROOT_DIR=$( cd $( dirname $( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd ) ) && pwd )
echo $ROOT_DIR

mkdir -p $ROOT_DIR/dist

cd $ROOT_DIR/packages/pylq
rm -rf dist/
python setup.py bdist_wheel sdist
find dist -type f | grep whl | xargs -I {} mv {} "dist/lq-latest-py3-none-any.whl"

for F in $(ls -1 dist/lq*.whl | sed -e 's@^dist/@@g'); do
    echo "Placed file '$F'..."
    mv dist/$F $ROOT_DIR/dist
    rm -rf dist build
done
