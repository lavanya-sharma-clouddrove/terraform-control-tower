variable "name" {
  type    = string
  default = "nov-25"
}
variable "environment" {
  type    = string
  default = "test"
}
variable "label_order" {
  type    = list(string)
  default = ["name", "environment"]
}
