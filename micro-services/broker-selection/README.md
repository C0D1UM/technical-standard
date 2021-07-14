# Broker Selection

## Terms

Before moving on, you should understand these two terms of communication:

*Request/Reply* communication is when you expected the destination service
reply immediately after processed. The simplest example is HTTP request.

![Request Reply Communication](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/C0D1UM/technical-standard/main/micro-services/broker-selection/distributing-communication.plantuml)

*Distributing* communication is when you don't need reply from the
destination service. Most of the time distributing communication is async.

![Request Reply Communication](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/C0D1UM/technical-standard/main/micro-services/broker-selection/request-reply-communication.plantuml)

## Decision Tree

![Broker Selection](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/C0D1UM/technical-standard/main/micro-services/broker-selection/decision-making.plantuml)

## Tools By Communication Categories

### Request/Reply

- gRPC
- NATS

### Distributing

- AWS SQS
- NATS JetStream
