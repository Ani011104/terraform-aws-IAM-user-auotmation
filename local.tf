locals {
  /*
    What we need to do is , we have a csv file
    we need to convert that int a list of map
    each map will have key value pair
    key will be the column name
    value will be the column value
     */

  users = csvdecode(file("users.csv"))

  common_tags = {
    Name       = "Username"
    Department = "Department"
    JobTitle   = "JobTitle"
  }

}
