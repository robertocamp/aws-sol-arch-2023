terraform {
  source = "../../../infrastructure-modules/eks"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

inputs = {
  eks_version = "1.26"
  env         = include.env.locals.env
  eks_name    = "demo"
  subnet_ids  = dependency.vpc.outputs.private_subnet_ids

  node_groups = {
    general = {
      capacity_type  = "SPOT"
      instance_types = ["t2.micro"]
      scaling_config = {
        desired_size = 3
        max_size     = 10
        min_size     = 3
      }
    }
  }
}

dependency "vpc" {
  config_path = "../vpc"

// mock outputs are for when you want to run terraform plan on both modules simultaneously
  mock_outputs = {
    private_subnet_ids = ["subnet-1234", "subnet-5678"]
  }
}