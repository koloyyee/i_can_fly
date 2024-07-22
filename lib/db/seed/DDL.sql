-- airlines definition

CREATE TABLE `airlines` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `code` TEXT NOT NULL, `companyName` TEXT NOT NULL);


-- airplanes definition

CREATE TABLE `airplanes` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `type` TEXT NOT NULL, `capacity` INTEGER NOT NULL, `maxSpeed` INTEGER NOT NULL, `maxRange` INTEGER NOT NULL, `manufacturer` TEXT NOT NULL);


-- customers definition

CREATE TABLE `customers` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `name` TEXT NOT NULL, `email` TEXT NOT NULL, `password` TEXT NOT NULL, `firstName` TEXT NOT NULL, `lastName` TEXT NOT NULL, `birthday` INTEGER NOT NULL, `address` TEXT NOT NULL, `createdAt` INTEGER NOT NULL);


-- flights definition

CREATE TABLE `flights` (`id` INTEGER NOT NULL, `airplaneType` TEXT, `arrivalCity` TEXT NOT NULL, `departureCity` TEXT NOT NULL, `departureDateTime` INTEGER NOT NULL, `arrivalDateTime` INTEGER NOT NULL, PRIMARY KEY (`id`));


-- staffs definition

CREATE TABLE `staffs` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `email` TEXT NOT NULL, `password` TEXT NOT NULL, `createdAt` INTEGER NOT NULL);