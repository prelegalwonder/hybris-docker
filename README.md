# hybris-docker (WIP)

This repo is an attempt to dockerize the SAP H[y]bris ecommerce platform for the purposes of easier configuration, deployment and maintainability.
<br>The provided dockerfile and configurations associated are based off the develop configuration template.
<br>In order to make this production ready, you will need to revise it according to your needs. If you have any questions about how to apply those needs via Docker, feel free to open an issue on this repo and I'll make my best effort to assist.

## Requirements
- Access to the [Hybris Wiki](http://wiki.hybris.com) and or media.
- A recent version of docker [installed on a host](https://docs.docker.com/installation/).
- A user on that host with docker access (*root or a user in the docker group*).
- [Sufficient host resources](https://wiki.hybris.com/display/general/System+Requirements+-+Release+5.4).
- Direct or indirect ( HTTP_PROXY ) access to the internet from the host.

## Assumptions
- Familiarity with Hybris ( eg. using it in a project )
- Basic Linux understanding
- Familiarity with an editor like vi or nano.

## Quick-Start
1. Checkout this repo to your docker host:
 - `git clone https://github.com/prelegalwonder/hybris-docker.git`
2. Copy your media and license into the appropriate directories:
 - Note: _if you don't have a license you can just leave the demo license in place to evaluate Hybris._
 - `cp hybris-commerce-suite-5.4.0.4.zip /<path-to>/hybris-docker/`
 - `cp hybrislicence.jar /<path-to>/hybris-docker/conf/`
3. Execute docker build:
 - `docker build -t hybris:5.4.0.4 -f Dockerfile .`
4. Run your container once your image is complete:
 - `docker run --name hybris-test -p 8009:8009 -p 8010:8010 -p 9001:9001 -p 1099:1099 -d hybris:5.4.0.4`
5. View the startup logs:
 - `docker logs -f hybris-test`

## How do I...
### Overwrite default environment variables?
At runtime, specify the override you want to use ( eg, HeapSize ):
- `docker run --name hybris-test -e HYB-JAVA-XMX=8g -e HYB-JAVA-XMS=8g -p 8009:8009 -p 9001:9001 -p 1099:1099 -d hybris:5.4.0.4`

### Add my own dynamic variables?
The Entrypoint script ( _hybris-wrapper.sh_ ) on first execution will iterate through all the ENV variables starting with "HYB-" and replace the corresponding value @HYB-VARIABLE@ in the local.properties. To add your own, simply add an ENV line to the Dockerfile with the variables you want to replace, and put place-holders for those variables in the form of the same name in the local.properties.
  - Example Dockerfile line:
        ENV HYB-CLUSTER-ID=0
  - Example local.properties entry:
        cluster.id=@HYB-CLUSTER-ID@

### Keep all of this organized?!
There are many docker management solutions. A preferred method is to document your operational, infrastructure, release requirements and use-cases and evaluate the various solutions against them. Below is a short list of popular solutions.
 - [Kubernetes](http://kubernetes.io/): Manage a cluster of Linux containers as a single system to accelerate Dev and simplify Ops.
 - [Terraform](https://www.terraform.io/) + [Consul](https://www.consul.io/): Docker orchestration tools from Hashicorp.
 - [Rancher](http://rancher.com/rancher/): Rancher is a complete infrastructure platform for running Docker in production
 - [Panamax](http://panamax.io/): Docker Management for Humans

### More to come...
