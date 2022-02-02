# custom-worldpress-newspaper
Custom worldpress container tailored for the [theme newspaper](https://themeforest.net/item/newspaper/5489609)

## Introduction
Running wordpress in a container is great to be up and running in no time, but what if some configuration files have to be tweaked?

For example, I decided to use [newspaper](https://mattiarubini.com) as theme on my [personal website](https://mattiarubini.com).
A theme that needs some [specific configuration](https://forum.tagdiv.com/requirements-for-newspaper/) to run at best performance.

Some of those tweaks are made on persistent files (such as: plugins, themes and wordpress configurations) that are mounted in the container when it's started.
Those tweaks are done once manually on the file system made availaible for the container to mount.
A good example is the content of the folder:

    /var/www/html

While other tweaks are made in files that are already present in the image and are related to a specific instance of the container (such as the php configurations).
Those files have to be modified in the image before the container is started.
A good example is the content of the folder:

    $PHP_INI_DIR/conf.d/

It this project, there are both the `Dockerfile` to build a tweaked image of wordpress suited for the newspaper wordpress theme.
It is also present a `Jenkinsfile` that automate the whole process.

For those that are not familiar with how jenkins builds conatiner, the repo [jenkins-container](https://github.com/Mot93/jenkins-container) goes more in depth to explain the whole process.

## Getting the default config files
The first thing to do is to fetch a copy of the config file to change.

To do so it's necessary to start the container, grab the file content and store it somewhere.

1. Start the container:

    docker run -d --name worldpress docker.io/wordpress:5.9

2. Grab from the container the desired file content and store it on a local file (for example the php.ini file):

        docker exec worldpress cat $PHP_INI_DIR/conf.d/php.ini > default-php.ini

    Note: this specific file doesn't exists, but the principle is still valid.

3. Stop the container

    docker stop worldpress

## Adding the new config file to the image
Once every file is ready to be placed in the container, build the Dockerfile in charge of copying the configurations files inside the image

    docker build .

## Uploading the custom image
Now that the image is ready, unless it soppose to be used on the same machine it was build, upload it to an image registry.

1. Login to the image registry

    docker login <registry>

2. Upload the image

    docker push <username>/jenkins:<tagname>
