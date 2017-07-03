# Eclipse MQTT test suite

A conformance test suite for the IoT protocol MQTT written in TTCN-3.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

The MQTT Test Suite has several dependencies to other Titan ProtocolModules and TestPorts which need to be known for the MQTT Test Suite. 

#### Getting Dependencies

To clone the required Modules and Ports with the correct folder structure you should adapt and execute the cloneTitanDependencies.sh. If you don't change the PATH_BASE variable, the script will automatically clone the required modules to ~/TitanModules.

```bash
./cloneTitanDependencies.sh
```
Will clone the required (and some other) modules and ports in to the folder ${PATH_BASE}/

#### Importing Dependencies

Open the Titan IDE in your desired workspace and use the import feature 

```
File -> Import -> TITAN -> Project from .tpd file
```
and import the MQTT ProtocolModule with

```
${PATH_BASE}/ProtocolModules/MQTT/MQTT_v3.1.1_CNL113831.tpd
```

and the IPL4 TestPort with

```
${PATH_BASE}/TestPorts/IPL4asp/IPL4asp_CNL113531.tpd
```

### Installing

TODO

## Running the tests

TODO

## Deployment

TODO

## Built With

* [Maven](https://maven.apache.org/) - Dependency Management

## Contributing

Please read [CONTRIBUTING.md](#) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [Whatever](#) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Alexander Kaiser** - *Initial work* - [relayr](https://relayr.io/)

See also the list of [contributors](#) who participated in this project.

## License

TODO

## Acknowledgments

TODO

