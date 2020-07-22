# Simple CF standup

This repository contains scripts to quickly stand up/tear down a minimal AWS Cloud Foundry instance.

## Pre-requisites

1. AWS account
2. [cf CLI](https://github.com/cloudfoundry/cli)
3. [bosh CLI](https://bosh.io/docs/cli-v2-install/)
4. [bbl CLI])(https://github.com/cloudfoundry/bosh-bootloader)
5. make

## Configuration

1. Get an AWS access key pair
2. Identify the system domain. This should be a subdomain of a Route53 domain that your AWS user has access to, as BBL will add DNS entries to it.
3. Copy [creds.sample](creds.sample) to `creds` and edit it, changing the AWS keys, `SYSTEM_DOMAIN` and `BBL_ENV_NAME`.

## Create BOSH and CF

```sh
make prepare
make up
```

## Tear everything down when finished

```sh
make down
```
