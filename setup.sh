#!/bin/sh -e

aws iam create-role --role-name K8sMaster --assume-role-policy-document '{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Principal":{"Service":"ec2.amazonaws.com"},"Action":"sts:AssumeRole"}]}' > /dev/null
aws iam put-role-policy --role-name K8sMaster --policy-name master --policy-document '{"Version":"2012-10-17","Statement":

[
  {"Sid":"K8sMasterDescribeResources","Effect":"Allow","Action":["ec2:DescribeInstances","ec2:DescribeRegions","ec2:DescribeRouteTables","ec2:DescribeSecurityGroups","ec2:DescribeSubnets","ec2:DescribeVolumes"],"Resource":"*"},
    {"Sid":"K8sMasterDescribeResources","Effect":"Allow","Action":[
      "ec2:*",
      "ecr:*",
      "elasticloadbalancing:*",
      "logs:*",
      "tag:*",
      "autoscaling:*"
      ],"Resource":"*"
      },
  {"Sid":"K8sMasterAllResourcesWriteable","Effect":"Allow","Action":["ec2:CreateRoute","ec2:CreateSecurityGroup","ec2:CreateTags","ec2:CreateVolume","ec2:ModifyInstanceAttribute"],"Resource":"*"},

{
  "Sid":"K8sMasterTaggedResourcesWritable",
  "Effect":"Allow","Action":["ec2:AttachVolume","ec2:AuthorizeSecurityGroupIngress","ec2:DeleteRoute","ec2:DeleteSecurityGroup","ec2:DeleteVolume","ec2:DetachVolume","ec2:RevokeSecurityGroupIngress"],"Resource":"*"}]}'

aws iam put-role-policy --role-name K8sMaster --policy-name ecr --policy-document '{"Version":"2012-10-17","Statement":[{"Sid":"K8sECR","Effect":"Allow","Action":["ecr:GetAuthorizationToken","ecr:BatchCheckLayerAvailability","ecr:GetDownloadUrlForLayer","ecr:GetRepositoryPolicy","ecr:DescribeRepositories","ecr:ListImages","ecr:BatchGetImage"],"Resource":"*"}]}'
aws iam put-role-policy --role-name K8sMaster --policy-name cni --policy-document '{"Version":"2012-10-17","Statement":[{"Sid":"K8sNodeAwsVpcCNI","Effect":"Allow","Action":["ec2:CreateNetworkInterface","ec2:AttachNetworkInterface","ec2:DeleteNetworkInterface","ec2:DetachNetworkInterface","ec2:DescribeNetworkInterfaces","ec2:DescribeInstances","ec2:ModifyNetworkInterfaceAttribute","ec2:AssignPrivateIpAddresses","tag:TagResources"],"Resource":"*"}]}'
aws iam put-role-policy --role-name K8sMaster --policy-name autoscaler --policy-document '{"Version":"2012-10-17","Statement":[{"Sid":"K8sClusterAutoscalerDescribe","Effect":"Allow","Action":["autoscaling:DescribeAutoScalingGroups","autoscaling:DescribeAutoScalingInstances","autoscaling:DescribeTags","autoscaling:DescribeLaunchConfigurations"],"Resource":"*"},{"Sid":"K8sClusterAutoscalerTaggedResourcesWritable","Effect":"Allow","Action":["autoscaling:SetDesiredCapacity","autoscaling:TerminateInstanceInAutoScalingGroup","autoscaling:UpdateAutoScalingGroup"],"Resource":"*"}]}'
aws iam put-role-policy --role-name K8sMaster --policy-name loadbalancing --policy-document '{"Version":"2012-10-17","Statement":[{"Sid":"K8sELB","Effect":"Allow","Action":["elasticloadbalancing:AddTags","elasticloadbalancing:AttachLoadBalancerToSubnets","elasticloadbalancing:ApplySecurityGroupsToLoadBalancer","elasticloadbalancing:CreateLoadBalancer","elasticloadbalancing:CreateLoadBalancerPolicy","elasticloadbalancing:CreateLoadBalancerListeners","elasticloadbalancing:ConfigureHealthCheck","elasticloadbalancing:DeleteLoadBalancer","elasticloadbalancing:DeleteLoadBalancerListeners","elasticloadbalancing:DescribeLoadBalancers","elasticloadbalancing:DescribeLoadBalancerAttributes","elasticloadbalancing:DetachLoadBalancerFromSubnets","elasticloadbalancing:DeregisterInstancesFromLoadBalancer","elasticloadbalancing:ModifyLoadBalancerAttributes","elasticloadbalancing:RegisterInstancesWithLoadBalancer","elasticloadbalancing:SetLoadBalancerPoliciesForBackendServer"],"Resource":"*"},{"Sid":"K8sNLB","Effect":"Allow","Action":["ec2:DescribeVpcs","elasticloadbalancing:AddTags","elasticloadbalancing:CreateListener","elasticloadbalancing:CreateTargetGroup","elasticloadbalancing:DeleteListener","elasticloadbalancing:DeleteTargetGroup","elasticloadbalancing:DescribeListeners","elasticloadbalancing:DescribeLoadBalancerPolicies","elasticloadbalancing:DescribeTargetGroups","elasticloadbalancing:DescribeTargetHealth","elasticloadbalancing:ModifyListener","elasticloadbalancing:ModifyTargetGroup","elasticloadbalancing:RegisterTargets","elasticloadbalancing:SetLoadBalancerPoliciesOfListener"],"Resource":"*"}]}'
aws iam create-instance-profile --instance-profile-name K8sMaster
aws iam add-role-to-instance-profile --instance-profile-name K8sMaster --role-name K8sMaster
aws iam create-role --role-name K8sNode --assume-role-policy-document '{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Principal":{"Service":"ec2.amazonaws.com"},"Action":"sts:AssumeRole"}]}' > /dev/null
aws iam put-role-policy --role-name K8sNode --policy-name node --policy-document '{"Version":"2012-10-17","Statement":[{"Sid":"K8sNodeDescribeResources","Effect":"Allow","Action":["ec2:DescribeInstances","ec2:DescribeRegions"],"Resource":"*"}]}'
aws iam put-role-policy --role-name K8sNode --policy-name ecr --policy-document '{"Version":"2012-10-17","Statement":[{"Sid":"K8sECR","Effect":"Allow","Action":["ecr:GetAuthorizationToken","ecr:BatchCheckLayerAvailability","ecr:GetDownloadUrlForLayer","ecr:GetRepositoryPolicy","ecr:DescribeRepositories","ecr:ListImages","ecr:BatchGetImage"],"Resource":"*"}]}'
aws iam put-role-policy --role-name K8sNode --policy-name cni --policy-document '{"Version":"2012-10-17","Statement":[{"Sid":"K8sNodeAwsVpcCNI","Effect":"Allow","Action":["ec2:CreateNetworkInterface","ec2:AttachNetworkInterface","ec2:DeleteNetworkInterface","ec2:DetachNetworkInterface","ec2:DescribeNetworkInterfaces","ec2:DescribeInstances","ec2:ModifyNetworkInterfaceAttribute","ec2:AssignPrivateIpAddresses","tag:TagResources"],"Resource":"*"}]}'
aws iam create-instance-profile --instance-profile-name K8sNode
aws iam add-role-to-instance-profile --instance-profile-name K8sNode --role-name K8sNode
