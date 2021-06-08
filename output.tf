/*
    Outputs
*/


output "ip_addresses" {
    value = toset([
        for value in module.vm-example-module : value.ip_address
    ])
}
