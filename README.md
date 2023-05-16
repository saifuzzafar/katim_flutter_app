
# Katim Flutter App

A brief description of what this project does and who it's for


## Overview
Flutter is Google's UI toolkit for building beautiful, natively compiled applications for mobile, web, desktop, and embedded devices from a single codebase.

This demo app is compatible with iOS, MacOS, Android, and Flutter Web with support for mobile, tablet, and web management with a responsive UI.
## Architecture
The architecture of the template facilitates separation of concerns and avoids tight coupling between it's various layers. The goal is to have the ability to make changes to individual layers without affecting the entire app. Clean Architecture is used to achive the same.

layers
presentaiton: All UI and state management elements like widgets, pages and view models.

domain: Use cases for individual pieces of work.

infrastructure: Services provide access to external elements such as databases, apis, etc.
database-floor: Floor as the Database provider
network-retrofit: Retrofit as the Database provider
## Libraries used 
Dependency Injection - Provider
Network - Dio
Database - Hive
State managment - Provider
