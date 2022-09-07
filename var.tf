# Mention the subnets
variable "subnets" {
  type    = list(any)
  default = ["subnet-01295276de86d6a0d", "subnet-07c49101815086dc9", "subnet-0ed0bc588099f3633"]
}

variable "vpc" {
  default = "vpc-0fb13d13817cada4d"
}

variable "sg" {
    type = list
    default = ["sg-09c431acf91fe28d3"]
}
