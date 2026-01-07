# Terraform AWS IAM User Automation

This project automates the creation and management of AWS IAM users and groups using Terraform. It reads user data from a CSV file and dynamically provisions resources based on the defined attributes.

## Overview

The configuration performs the following actions:

1.  **Reads User Data**: Parses `users.csv` to get a list of users with their details (First Name, Last Name, Department, Job Title).
2.  **Creates IAM Users**: Dynamically creates an AWS IAM user for each entry in the CSV file.
3.  **Creates Login Profiles**: Generates a login profile (with a temporary password) for each user to access the AWS Console.
4.  **Creates IAM Groups**: Provisions specific IAM groups:
    -   **Education**
    -   **Managers**
    -   **Engineers**
5.  **Assigns Group Memberships**: Automatically adds users to the appropriate groups based on their `Department` or `JobTitle`:
    -   Users in the "Education" department go to the **Education** group.
    -   Users with "Manager" or "CEO" in their job title go to the **Managers** group.
    -   Users in the "Engineering" department go to the **Engineers** group.

## Project Structure

-   `main.tf`: Defines the `aws_iam_user` and `aws_iam_user_login_profile` resources.
-   `groups.tf`: Defines `aws_iam_group` resources and `aws_iam_group_membership` logic.
-   `local.tf`: Handles CSV decoding and local variable definitions (like common tags).
-   `users.csv`: The source of truth for user data.
-   `output.tf`: Outputs the generated passwords for the users (marked as sensitive).
-   `backend.tf`: Configures the S3 backend for storing Terraform state.
-   `provider.tf`: Configures the AWS provider.

## Usage

1.  **Initialize Terraform**:
    ```bash
    terraform init
    ```

2.  **Plan the changes**:
    ```bash
    terraform plan
    ```

3.  **Apply the configuration**:
    ```bash
    terraform apply
    ```

4.  **View Passwords**:
    To see the generated passwords for the users:
    ```bash
    terraform output -json iam_user_passowrd
    ```