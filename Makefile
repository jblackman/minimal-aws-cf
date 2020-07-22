help:
	@awk '/^## / {$$1=""; helptext=$$0; getline; printf "\033[36m%-30s\033[0m %s\n", $$1, helptext} /^###/ {sub(/### */, ""); print}' $(MAKEFILE_LIST)

### --- Top-level targets ----------------------------------

## Clones the bosh and CF deployment repos, creates certs
prepare: certs clone

## Stands up the complete CF platform
up: bosh cf

## Destroys CF and BOSH, cleaning up AWS objects
down: cf-destroy bbl-destroy

## Creates the bosh director
bosh: bbl-up runtime-config

## Creates CF
cf: upload-stemcell cf-deploy cf-login

###
### --- Step-wise targets ----------------------------------

## Regenerates the CF api certificate
certs:
	./manage certs

## Clones the BOSH and CF deployment repositories
clone:
	rm -rf bosh-deployment cf-deployment
	git clone https://github.com/cloudfoundry/bosh-deployment
	git clone https://github.com/cloudfoundry/cf-deployment

## Runs bbl plan, bbl up to create the bosh director
bbl-up:
	./manage bbl_up

## Uploads a suitable BOSH runtime-config
runtime-config:
	./manage runtime-config

## Uploads a suitable CF stemcell
upload-stemcell:
	./manage upload-stemcell

## Deploys CF
cf-deploy:
	./manage cf-deploy

## Prints the CF admin password
cf-password:
	./manage cf-password

## Logs in to CF
cf-login:
	./manage cf-login

## Destroys the CF deployment
cf-destroy:
	./manage cf-destroy

## Tears down the BOSH director and all AWS objects
bbl-destroy:
	./manage bbl-destroy
