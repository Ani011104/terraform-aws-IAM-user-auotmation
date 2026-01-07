# output "users_converted_to_listofmap" {
#   value = local.users
# } --- just for testing

output "iam_user_passowrd" {
  value = {
    for user, profile in aws_iam_user_login_profile.iam_user_login_profile :
    user => profile.password
  }
  sensitive = true

}

