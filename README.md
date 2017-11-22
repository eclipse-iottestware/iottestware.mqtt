# Eclipse MQTT test suite

A Conformance Test Suite for the IoT protocol MQTT written in TTCN-3.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

As the Test Suite is written in TTCN-3 you need to have an installed and running TTCN-3 compilation and execution environment. 
This Test Suite is written and tested with [Eclipse Titan](https://projects.eclipse.org/projects/tools.titan), which is also the recommended TTCN-3 environment.

other prerequisites
 - GNU Make
 - Eclipse 4.6.1 Neon (optional)
 - TBD...

### Installing Dependencies

The MQTT Test Suite has several dependencies to [Titan components](https://projects.eclipse.org/projects/tools.titan/developer) (mainly ProtocolModules and TestPorts). The install script automates the installation of the required ProtocolModules and TestPorts.

The script has mainly two variables in the configuration section.

By default, **PATH_BASE** is set to **~/Titan** and defines the base path where the Titan components and the Test Suite will be cloned to.

By default, **PATH_CLI_WORKSPACE** is set to **~/IoTTestware** and defines the base path where your workspace for CLI operation will be located.

```bash
./install.sh
```
Now the required dependencies should be available in **PATH_BASE**.

### Installing MQTT Test Suite

With Eclipse Titan you are free to choose to work either from the Command Line (CLI) or from Eclipse IDE.

#### Eclipse IDE

Open the Titan IDE in your desired workspace and use the import feature 

```
File -> Import -> TITAN -> Project from .tpd file
```
and import the .tpd File from the MQTT Test Suite. 
(The file should be: *${PATH_BASE}/IoTTestware/iottestware.mqtt/iottestware.mqtt.tpd*)

This will import the MQTT Test Suite as well as the required ProtocolModules and TestPorts.

*Note:* The configurations of all modules must be consistent. **TBD**

#### Command Line

If you like to build and run the MQTT Test Suite from the CLI than no further installation is required. The install script already created the *${PATH_CLI_WORKSPACE}/iottestware.mqtt/bin* folder, linked all the required files and generated a Makefile accordingly. 

## Building MQTT Test Suite

Depending on your choice from the previous step you can now decide to build the MQTT Test Suite either from the CLI or IDE. 

*Note:* Building from CLI is possible in both cases. You should always have a Makefile inside the /bin folder. 

### Eclipse IDE

TBD

### Command Line

Within the /bin folder of the MQTT Test Suite you should have an automatically generated Makefile. Simply call the make command to build the executable Test Suite.

```bash
make all
```
Now you should have a newly generated binary file **iottestware.mq**

## Running the tests

TODO

## Built With

* [Maven](https://maven.apache.org/) - Dependency Management

## Versioning

We use [Whatever](#) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Alexander Kaiser** - *Initial work* - [relayr](https://relayr.io/)

See also the list of [contributors](#) who participated in this project.

## License

TODO

## Acknowledgments

TODO

