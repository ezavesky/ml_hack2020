# Script to compile and upload an instance of the python labelquest API interface

ROOT_DIR=$( cd "$( dirname $( dirname "${BASH_SOURCE[0]}" ))" && pwd )
echo $ROOT_DIR

cd $ROOT_DIR/packages/pylq
rm -rf dist/
python setup.py bdist_wheel sdist
find dist -type f | grep whl | xargs -I {} mv {} "dist/lq-latest-py3-none-any.whl"
# scp dist/lq-*-py3-none-any.whl ezavesky@content.research.DOMAIN:/data/www/projects/mlci_2020/packages/.
for F in $(ls -1 dist/lq*.whl | sed -e 's@^dist/@@g'); do
    echo "Placed file '$F'..."
    aws s3 cp dist/$F s3://vmlr-workshop/packages/
    aws s3api put-object-acl --bucket vmlr-workshop --key packages/$F --acl public-read
done
