# GKE

This repository contains resources for provisioning a best-practice GKE cluster Terraform.

## Quickstart

```
# edit state bucket name in Makefile
# edit terraform.tfvars.example and rename to terraform.tfvars
make init
make plan
make apply
```

## Cleanup

```
make destroy
```