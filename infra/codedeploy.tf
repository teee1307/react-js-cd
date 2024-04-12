# Create a CodeDeploy application
resource "aws_codedeploy_app" "main" {
  name = "Quizz_App"
}

# Create a deployment group
resource "aws_codedeploy_deployment_group" "main" {
  app_name              = aws_codedeploy_app.main.name
  deployment_group_name = "Sample_DepGroup"
  service_role_arn      = data.aws_iam_role.existing_role.arn

  deployment_config_name = "CodeDeployDefault.OneAtATime" # AWS defined deployment config

  # Define EC2 tag filters to specify the instances to include in the deployment group
  ec2_tag_filter {
    key    = "Name"
    type   = "KEY_AND_VALUE"
    value  = "dev-node"
  }

  # Trigger a rollback on deployment failure event
  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}
