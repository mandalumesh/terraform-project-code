# Concept 1

# variable "dynamic-rg" {
#     type = map(any)
# }

# Concept 2
variable "dynamic-rg" {
  type = map(
    object(
      {
        name       = string
        location   = string
        tags       = optional(map(string))
        managed_by = optional(string)
      }
    )
  )

}
