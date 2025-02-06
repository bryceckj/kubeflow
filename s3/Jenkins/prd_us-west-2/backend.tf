terraform {
  backend "s3" {
    bucket  = "s3usw2appprd01tfstate"
    key     = "us-west-2/mlops/kubeflow-s3-prd.tfstate"
    region  = "us-west-2"
    encrypt = "true"

    // Provide the dynamodb_table created for the account for locking and uncomment the below line.for eg : dynamodbglogisitk8stfprd
    dynamodb_table = "terraform_locks"
  }
}
