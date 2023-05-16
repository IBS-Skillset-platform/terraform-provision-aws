variable "region" {
  default = "ap-south-1"
  type = string
  description = "AWS Zone"
}
variable "IBS-RnD-Sub1" {
  type = string
  default = "subnet-02dd41ebb55564c30"
 }

variable "IBS-RnD-Sub2" {
  type = string
  default = "subnet-e47c3b8c"
}

variable "project_name" {
   default = "ibs-skillset-happystays-db"
}

variable "postgres_username" {
   default = "ibsskillsetdb"
}

variable "postgres_password" {
   default = "qN%5no2d9j9#Rfm#"
}

variable "vpc_id" {
   default = "vpc-946c32fc"
}

variable "sec_group_id" {
   default = "sg-0903c6fabaa7f08c8"
}