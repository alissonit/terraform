##Files terraform:

###Init repository terraform

```
terraform init
```
### Terraform plan
```
terraform plan -var="name=testal" -var="resourcegroup=<reource_group_name>" -var="location=Brazil South" -var="vmsize=Standard_DS1_v2" -var="vnet=<vnet_name>" -var="subnet=default" -var="subscription_id=<subscription_id>" -var="client_id=<client_id>" -var="tenant_id=<tenant_id>"
```
* For apply alter plan to apply

