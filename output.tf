/*
    Outputs
*/

output "ip_addresses" {
    value = toset([
        for key in module.vm-example-module : module.vm-example-module[key].ip_address
    ])
}