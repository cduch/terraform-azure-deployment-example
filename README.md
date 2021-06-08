# terraform-azure-multiregion-example

Example of Webserver Deployment to multiple regions in Azure

## 1. Login to Azure and set ENV variables:

```
az login
az account list
az account set --subscription="SUBSCRIPTION_ID"
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/SUBSCRIPTION_ID"
```

requires the following variables:

ARM_SUBSCRIPTION_ID	SUBSCRIPTION_ID from the last command's input.
ARM_CLIENT_ID	appID from the last command's output.
ARM_CLIENT_SECRET	password from the last command's output. (Sensitive)
ARM_TENANT_ID	tenant from the last command's output.


## 2. Clone repo:

```
git clone git@github.com:cduch/terraform-azure-multiregion-example.git
```

## 3. Edit terraform.tfvars and change at least the _admin_password_ and the _owner_

```
cd terraform-azure-multiregion-example
vi terraform.tfvars
```
## 4. Plan & Apply changes

```
terraform plan
```

Check if everything looks like desired, if so apply the changes:

```
terraform apply -auto-approve
```

## 5. Use IPs in Output to access the webservers

```
Outputs:

ip_addresses = tolist([
  "X.X.X.X",
])

```

## 6. Destroy the deployment

```
terraform destroy -auto-approve
```
