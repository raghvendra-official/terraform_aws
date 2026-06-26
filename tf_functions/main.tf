terraform {}

locals {
  value = "Hello World!"
}

variable "string_list" {
  type = list(string)
  default = [ "serv1", "serv2", "serv2" ]
}

output "output"{
    #value = lower(local.value)
    #value = upper(local.value)
    #value = startswith(local.value,"Hello")
    #value = split(" ", local.value)
    #value = max(10,52,83)
    #value = min(10,52,83)
    #value = abs(-15)
    #value = length(var.string_list)
    #value = join(":",var.string_list)
    #value = contains(var.string_list, "server")
    value = toset(var.string_list)

}