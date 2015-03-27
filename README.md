Checklists App
==============

Checklists App allows you to create multiple checklists to control your repetead actions, e.g. action points to prepare meeting.

If any of actions are repetable you can create template for that to save time next time you'll want to compose checklist.

## Contributing

### Prerequsites

* Docker
* Docker Compose (old fig)

###  Running app

To run application execute following command in directory where you cloned it:

`docker-compose up`

This will run docker container with passenger within it.
You can access application by requesting `IP_ADDRESS:4000` where `IP_ADDRESS` is `127.0.0.1` if you're using Linux or proper IP addres when you're using VirtualBox - most common is `192.168.59.103`.

### Rake tasks

Executing rake tasks is proxied by `docker`. To do it run following command inside application directory:

`docker-compose run --rm app bin/rake RAKE_TASK`

You can list all available rake tasks by executing:

`docker-compose run --rm app bin/rake -T`

**Remeber to execute `docker-compose` with `--rm` option. It will remove container after exit form it what prevent from rubbish docker containers.**