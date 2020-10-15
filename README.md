# cogment-api

## Introduction

The Cogment framework is a high-efficiency, open source framework designed to enable the training of models in environments where humans and agents interact with the environment and each other continuously. It’s capable of distributed, multi-agent, multi-model training.

This is the API definition from cogment. This repository is meant to be included within dependant projects.

For further Cogment information, check out the documentation at <https://docs.cogment.ai>

## Developers

The Cogment framework API is implemented using [gRPC](https://grpc.github.io/) services.  gRPC automatically generates idiomatic client and server stubs in a plethora of programming languages using protocol buffers.  The protocol buffer data nd associated language defines the gRPC service and method request and response types in `.proto` files.  The cogment api is composed of a set of `.proto` files within which the communication between the Cogment framework services are defined.
