# Eclipse MQTT test suite

A Conformance Test Suite for the IoT protocol MQTT written in TTCN-3.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

## Prerequisites

This Test Suite is written and tested with [Eclipse TITAN](https://projects.eclipse.org/projects/tools.titan), which is the recommended and required TTCN-3 environment. 


## Installing Dependencies

The MQTT Test Suite has several dependencies to [TITAN components](https://projects.eclipse.org/projects/tools.titan/developer) (mainly ProtocolModules and TestPorts). The install script automates the installation of the required ProtocolModules and TestPorts.

The script has mainly two variables in the configuration section.

By default, **PATH_BASE** is set to **~/Titan** and defines the base path where the Titan components and the Test Suite will be cloned to.

By default, **PATH_CLI_WORKSPACE** is set to **~/IoTTestware** and defines the base path where your workspace for CLI operation will be located.

```bash
./install.sh
```
Now the required dependencies should be available in **PATH_BASE**.

## Installing MQTT Test Suite

With Eclipse Titan you are free to choose to work either from the Command Line (CLI) or from Eclipse IDE.

### Eclipse IDE

Open the Titan IDE in your desired workspace and use the import feature 
```
File -> Import -> TITAN -> Project from .tpd file
```
![Import from .tpd file](https://user-images.githubusercontent.com/2487708/33207536-56f3f9fc-d10e-11e7-9699-7298ee842a6b.png)

Klick Next and choose the **iottestware.mqtt.tpd** from **${PATH_BASE}**

![Create TITAN Project](https://user-images.githubusercontent.com/2487708/33207748-26bf29e0-d10f-11e7-84f3-0b79bddb6fd5.png)

Klick Next and choose importation options

![Importation Options](https://user-images.githubusercontent.com/2487708/33207865-aa9ef434-d10f-11e7-8b3e-08ac1d607a96.png)

Klick Finish and the IDE will import all the required Projects and open the properties for each. Make sure each project is configured to **_generate Makefile for use with the function test runtime_**.

![Makefile for FTR](https://user-images.githubusercontent.com/2487708/33207905-d6019bcc-d10f-11e7-965b-23e0a73b3e3c.png)

### Command Line

If you like to build and run the MQTT Test Suite from the CLI than no further installation is required. The install script already created the **${PATH_CLI_WORKSPACE}/iottestware.mqtt/bin** folder, linked all the required files and generated a Makefile accordingly. 

## Building MQTT Test Suite

Depending on your choice from the previous step you can now decide to build the MQTT Test Suite either from the CLI or IDE. 

*Note:* Building from CLI is possible in both cases. You should always have a Makefile inside the /bin folder. 

### Eclipse IDE

Right-click the **iottestware.mqtt** Project and select **Build Project**. 

![Build Project](https://user-images.githubusercontent.com/2487708/33208541-4135a706-d112-11e7-8cc1-a6ed63bc4f92.png)

*Note:* Make sure you are in the TITAN Editing Perspective, otherwise the Build Project might be not available. 


### Command Line

Within the **${PATH_CLI_WORKSPACE}/iottestware.mqtt/bin** folder of the MQTT Test Suite you should have an automatically generated Makefile. Simply call the make command to build the executable Test Suite.

```bash
make all
```
Now you should have a newly generated binary file **iottestware.mqtt**

## Running the Test Suite

### Configure the Test Suite
TODO

### Running from Eclipse IDE
TODO

### Running from Command Line
TODO

## Built With

* [Eclipse Titan](https://projects.eclipse.org/projects/tools.titan) - TTCN-3 Runtime
* [GNU Make](https://www.gnu.org/software/make/) - Build automation

## Versioning

We use [Github](https://github.com/) for versioning. For the versions available, see the [tags on this repository](https://github.com/eclipse/iottestware.mqtt/tags). 

## Authors

* **Alexander Kaiser** - *Initial work* - [relayr](https://relayr.io/)

See also the list of [contributors](https://github.com/eclipse/iottestware.mqtt/graphs/contributors) who participated in this project.

## License

[Eclipse Public License - v 1.0](LICENSE)

## Acknowledgments

TODO

