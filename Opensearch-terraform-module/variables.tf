variable "region" {
  default = "ap-south-1"
  type = string
  description = "AWS Zone"
}
variable "IBS-RnD-Sub1" {
  type = string
  default = "subnet-e47c3b8c"
 }

 variable "IBS-RnD-Sub2" {
  type = string
  default = "subnet-02dd41ebb55564c30"
 }

 variable "IBS-RnD-Sub3" {
  type = string
  default = "subnet-0a4380a9072b85578"
 }

variable "IBS-RnD-Sub4" {
  type = string
  default = "subnet-0e29d2ff5e924b4fb"
 }

variable "volume_type" {
  type = string
  default = "gp3"
}
variable "throughput" {
  type = number
  default = 250
}
variable "ebs_enabled" {
  type = bool
  default = true
}
variable "ebs_volume_size" {
  type = number
  default = 100
}
variable "service" {
  type = string
  default = "openSearchCluster"
 }
variable "instance_type" {
  type = string
  default = "r5.large.search"}
variable "instance_count" {
   type = number
   default = 1
   }
variable "dedicated_master_enabled" {
  type    = bool
  default = false
}

variable "security_options_enabled" {
  type    = bool
  default = true
}
variable "engine_version" {
  type = string
  default = "2.3"
}