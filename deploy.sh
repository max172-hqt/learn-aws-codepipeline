if [ $CODEBUILD_BUILD_SUCCEEDING -eq 1 ]
then
  echo "Deploying to s3://$S3"
  npm run build
  aws s3 sync --delete --cache-control max-age=2592000,public $CODEBUILD_SRC_DIR/build/ s3://$S3
  aws cloudfront create-invalidation --distribution-id $CLOUDFRONT --paths "/*"
fi
