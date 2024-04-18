# Terraform
`terraform validate` - Check whether the configuration is valid

`terraform fmt` - Reformat your configuration in the standard style

`terraform show [-json]` - Show the current state or a saved plan

`terraform providers` - Show the providers required for this configuration

`terraform providers mirror` - Downloads the providers required for the current configuration and copies them into a directory in the local filesystem

`terraform output` - Show output values from your root module

`terraform refresh` - Update the state to match remote systems

`terraform graph` - Generate a Graphviz graph of the steps in an operation
* `apt install graphiz -y`
`terraform graph | dot -Tsvg > graph.svg`

`terraform apply -auto-approve`

Lifecycle rules:
```bash
lifecycle {
    create_before_destroy = true  # Create the resource first and tehn destroy older
#   prevent_destroy = true  # Prevents destroy of a resource
#   ignore_changes = all   # Ignore Changes to Resource Attributes (specific/all)
}
```
Meta Arguments:
depends_on
lifecycle
count
for_each

Count
```hcl
resource "local_file" "pet" {
    filename = var.filename[count.index]
    count = length(var.filename)
}

variable "filename" {
    default = [
        "/root/pets.txt",
        "/root/dogs.txt"
    ]
}
```

for_each
```hcl
resource "local_file" "pet" {
    filename = each.value
    for_each = var.filename
}

variable "filename" {
    type = set(string)
    default = [
        "/root/pets.txt",
        "/root/dogs.txt"
    ]
}
```