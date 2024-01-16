# resource "aws_iam_user" "first_user" {
#   name = "my-new-user"
#   tags = {
#     env = "dev"
#   }
# }

# resource "aws_iam_access_key" "keys"{
#     user = aws_iam_user.first_user.name
# }

