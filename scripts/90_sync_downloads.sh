# Script to finalize upload of `dist` directory to cloud-accessible resources

ROOT_DIR=$( cd $( dirname $( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd ) ) && pwd )
echo $ROOT_DIR

# scp dist/lq-*-py3-none-any.whl ezavesky@content.research.DOMAIN:/data/www/projects/mlci_2020/packages/.
for F in $(ls -1 $ROOT_DIR/dist* ); do
    echo "Placed file '$F'..."
    aws s3 cp dist/$F s3://vmlr-workshop/packages/
    aws s3api put-object-acl --bucket vmlr-workshop --key packages/$F --acl public-read
done
