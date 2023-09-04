##EC2 VARIABLE

variable "name" {
  description = "Define o nome da aplicação ex: gunts-api"
  type    = string
  default = ""
}
variable "security-group" {
 description = "define uma lista Id dos security groups que serão adicionados durante a criação da instancia"
 type = list(string)
 default = [ "value" ]
}
variable "vpc-id" {
  description = "recebe o id da vpc na qual a instancia ec2/elb será alocado"
  type = string
  default = ""
}
variable "subnet-id" {
  description = "Define o id da subnet na qual a instancia "
  type = string
  default = ""
}
###ELB VARIABLE
variable "elb-sg" {
    description = "Define uma lista de subnets para o application load balancer"
    type = list(string)
    default = [ "value1", "value2"]
}

### AWS RDS VARIABLE
variable "db-name" {
    description = "Define o nome do bando de dados ex: gunts"
    type = string
    default = ""
}
variable "db-engie" {
  description = "Define a engie do banco de dados"
  type = string
  default = ""
}
variable "db-engie-verison" {
  description = "Define a versão da engie do banco de dados"
  type = string
  default = ""
}
variable "db-instance-class" {
  description = "Define o tamanho da instancia rds"
  type = string
  default = ""
}
variable "db-instance-class" {
  description = "Define o nome de usuario para o banco de dados"
  type = string
  default = ""
}
## GLOBAL
variable "region" {
  description = "Define a região para o provider"
  type = string
  default = ""
}

