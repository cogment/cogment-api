# cogment-api

[![Apache 2 License](https://img.shields.io/badge/license-Apache%202-green)](./LICENSE) [![Changelog](https://img.shields.io/badge/-Changelog%20-blueviolet)](./CHANGELOG.md)

[Cogment](https://cogment.ai) is an innovative open source AI platform designed to leverage the advent of AI to benefit humankind through human-AI collaboration developed by [AI Redefined](https://ai-r.com). Cogment enables AI researchers and engineers to build, train and operate AI agents in simulated or real environments shared with humans. For the full user documentation visit <https://docs.cogment.ai>

This module, `cogment-api`, is the [gRPC API](https://docs.cogment.ai/cogment/cogment-low-level-api-guide/grpc/) definition for Cogment.

## About the API

The Cogment framework API is implemented using [gRPC](https://grpc.github.io/) services. gRPC automatically generates client and server stubs in a plethora of programming languages using protocol buffers. The protocol buffer data and associated language defines the gRPC service and method request and response types in `.proto` files. The cogment api is composed of a set of `.proto` files within which the communication between the Cogment framework services are defined.
