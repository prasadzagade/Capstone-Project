/*data "terraform_remote_state" "common" {
  backend = "s3"

  config = {
   # dynamodb_table = "terraform-locks"
    bucket         = "terraformtfstatepayment1"
    encrypt        = true
    key            = "infrastructure/environments/com/ultimate-terraform-folder-strucutre/common.tfstate"
   region         = "eu-north-1"
    #role_arn       = "arn:aws:iam::007400497555:role/IACDeveloper"
  }
  } */


resource "aws_sns_topic" "user_updates" {
  name = "aws-snap-capstone"
}

resource "aws_sns_topic_subscription" "results_updates_sqs_target" {
    topic_arn = aws_sns_topic.user_updates.arn
    protocol  = "sqs"
    endpoint  = aws_sqs_queue.game_scores.arn
}

resource "aws_sqs_queue" "game_scores" {
  name          = "${var.prefix}game-scores"
  delay_seconds = 90
}
