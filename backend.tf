terraform {
  backend "s3" {
    bucket         = "my-terraform-prod-state-harsh"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "my-terraform-locks-harsh"
    encrypt        = true
  }
}


# terraform {
#   backend "s3" {
#     bucket         = "my-terraform-prod-state-<yourname>"
#     key            = "terraform.tfstate"
#     region         = "ap-south-1"
#     dynamodb_table = "my-terraform-locks-<yourname>"
#     encrypt        = true
#   }
# }
