# Various tutorials

# Hello0

Basic elixir module

* Hello.hello/0

## Knowledge

* module
* function
* Call function from elixir shell

## Going further

* Add arguments to function
* Add arguments with default value
* Add arguments with keyword list

# Hello1

Simple store API

* Hello.start/0
* Hello.put/3
* Hello.get/2

## Knowledge

* Use basic data structure (Map)
* Understand functional programming: no side effect

## Going further

* Lookup reduce with Map
* Change Map with Keyword
* Understand elixir protocols using Enum instead of Keyword or Map
  functions

# Hello2

GenServer based store

* Hello.Store.put/2
* Hello.Store.get/1

## Knowledge

* OTP application basics: Application, Supervisor, GenServer

## Going further

* Write crashing code, observer supervisor behaviour
  
# Hello3

Telnet API on port 2323

## Knowledge

* Write a protocol, use pattern matching

## Going further

* Implement new commands
* Close TCP connection when "BYE"
* Add CREATE command to launch new bucket (spawn GenServer)

# HelloRest0

Basic API

## Knowledge

* Minimalist API with ewebmachine

## Going further

* Add JSON support (poison deps already included)
* Try PUT: observe 405

# HelloRest1

## Knowledge

* Implements PUT + DELETE

## Going further

* PUT request without 'content-type': observe 415

# HelloRest2

## Knowledge

Plug API with bucket

## Going further

* Return 404 if Store.get returns nil
* Add "/hello" returning all key/value pairs from Store
