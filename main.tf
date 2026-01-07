
/*
IMPORTANT: why we are again converting list of map -> map of objects
--- if the order of the list changes, tf will destroy and recreate the resource
--- so to avoid that we are converting map of objects which are orderless
--- since the maps are orderless, we need a unique key to identify each object
*/

resource "aws_iam_user" "iam_users" {
  // using for each to create as many users are presnt in the list
  // creates a map of obects
  // make sure to include the {objects inside this so that is a map of objects}
  for_each = { for user in local.users : user.first_name => user }

  name = lower("${substr(each.value.first_name, 0, 1)}${each.value.last_name}")
  path = "/csvusers/"

  tags = merge(local.common_tags, {
    Name       = "${each.value.first_name} ${each.value.last_name}"
    Department = each.value.department
    JobTitle   = each.value.job_title
  })
}


/*
need to create a login profile for each user so that they 
can login to aws console
*/
resource "aws_iam_user_login_profile" "iam_user_login_profile" {
  // here , same logic we need to create as many login as users
  for_each = aws_iam_user.iam_users
  user     = each.value.name

  password_reset_required = true

  lifecycle {
    ignore_changes = [password_reset_required, password_length]
  }
}

