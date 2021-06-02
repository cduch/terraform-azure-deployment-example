/*
    Outputs
*/

output "ip_addresses" {
    value = split(",", join(",", module.dc-deployment.*.ip_address))
}