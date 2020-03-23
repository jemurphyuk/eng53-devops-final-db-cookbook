# MongoDB cookbook
The cookbook for mongodb provisions an instance to make a data base server. The kitchencloud.yml completes this action on AWS cloud web server, kitchen.yml can be used for local.
The following environment variables are set in Jenkins, and need to be set locally to run locally

````
KITCHEN_YAML=kitchencloud.yml
````

### Unit/Integration testing using chefspec and inspec

To start the unit test, run the command

````
chef exec rspec spec
````
To start the integration test, run the command

````
kitchen test
````
A Jenkins job is capable of testing this cookbook by running the unit/int test commands, manually of using a webhook when a branch push is made
If these tests are successful, the build is merged and will trigger a packer job from repository

https://github.com/wizzchris/Engineering-53-DevOps-Final-Project-AppDB
