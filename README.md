# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

        Ruby v3.3.5

* System dependencies

        Rails v7.2.1

* Configuration

* Database creation

* Database initialization

    Initialize User

        CREATE USER developer WITH ENCRYPTED PASSWORD '12345abcde';

    Create Database and Grant Permission to User

        CREATE DATABASE wallet_app;
        GRANT ALL ON DATABASE wallet_app TO developer;
        ALTER DATABASE wallet_app OWNER TO developer;

    Run Migration

        rails db:migrate

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
