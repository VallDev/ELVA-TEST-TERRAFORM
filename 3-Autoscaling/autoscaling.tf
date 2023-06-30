

#Autoscaling group that has associated a launch template to run nginx server in whole machines
resource "aws_autoscaling_group" "test_elva_ag" {
  name             = "TEST-ELVA-FROM-LAUNCH-asg"
  min_size         = 1
  desired_capacity = 1
  max_size         = 3

  health_check_type = "ELB"

  load_balancers = [
    "${aws_elb.test_elva_elb.id}"
  ]

  launch_template {
    id = aws_launch_template.test_elva_launch_template.id

  }
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  vpc_zone_identifier = [
    var.private_subnet_1_id,
    var.private_subnet_2_id,
    var.private_subnet_3_id,
  ]

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Test Elva autoscaling"
    value               = "web"
    propagate_at_launch = true
  }
}

#Autoscaling policy to increase number of machines
resource "aws_autoscaling_policy" "test_elva_ag_policy_up" {
  name                   = "test_elva_policy_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.test_elva_ag.name
}

#Autoscaling alarm that triggers the event to increase number of machines
resource "aws_cloudwatch_metric_alarm" "test_elva_cw_alarm_up" {
  alarm_name          = "test_elva_cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "70"
  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.test_elva_ag.name}"
  }
  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = ["${aws_autoscaling_policy.test_elva_ag_policy_up.arn}"]
}

#Autoscaling policy to decrease number of machines
resource "aws_autoscaling_policy" "test_elva_ag_policy_down" {
  name                   = "test_elva_policy_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.test_elva_ag.name
}

#Autoscaling alarm that triggers the event to decrease number of machines
resource "aws_cloudwatch_metric_alarm" "test_elva_cw_alarm_down" {
  alarm_name          = "test_elva_cw_alarm_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"
  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.test_elva_ag.name}"
  }
  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = ["${aws_autoscaling_policy.test_elva_ag_policy_down.arn}"]
}
