/*
    Outputs
*/

output "ip_addresses" {
    value = toset([
        for name in module.vm-example-module.name : module.vm-example-module[name].ip_address
    ])
}