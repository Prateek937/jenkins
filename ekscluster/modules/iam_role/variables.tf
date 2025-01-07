variable "name" {
    description = "name of the role"
    type = string
}

variable "trust" {
    description = "service to trust by the role."
    type = string
}

variable "policies" {
    description = "policies for the role"
    type = list(string)
}

variable "tags" {
    description = "appropriate tags"
    type = map(string)
}