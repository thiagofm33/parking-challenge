### First Steps

1. Build the docker images and run the services

        $ docker-compose up

2. Change the ownership of the project's folder

        $ sudo chown -R $USER:$USER .

   > Note: it might be needed because of the `tmp/db` folder

3. Create and migrate the DBs

        $ docker-compose run api rails db:create db:migrate

   > important: The services must be up and running, hence this command must be run after `docker-compose up`.
