---
name: message-broker-audit
description: >-
  Production-grade audit of message brokers and asynchronous architecture in a
  repository: inspects actual code, configuration, queues, topics, delivery semantics,
  idempotency, retries, dead-letter queues, ordering, concurrency, backpressure,
  transactional outbox/inbox consistency, message schemas, observability, and failure modes.
  Use whenever the user asks to audit, review, inspect, or evaluate message brokers,
  event-driven architecture, pub/sub systems, queue implementations, worker pools,
  background job runners (Kafka, RabbitMQ, SQS, SNS, Redis Streams, Celery, BullMQ,
  Sidekiq, NATS, GCP Pub/Sub, Azure Service Bus), or asks "what breaks under 10x traffic?"
---

# Message Broker & Asynchronous Architecture Audit

You are a senior distributed-systems architect performing a production-grade audit of this application.

Your goal is to inspect the **actual code, configuration, infrastructure, and message flows in this repository** and identify whether the current message broker implementation follows established best practices.

Do not assume that the current architecture is correct. Do not recommend changes merely because they are different from your preferred architecture. Evaluate the implementation based on reliability, correctness, scalability, observability, maintainability, and operational complexity.

---

## 1. First: Understand the System

Before making recommendations, inspect the repository and build a mental model of:

* Applications/services
* Producers
* Consumers/workers
* Message broker(s) (e.g., RabbitMQ, Kafka, AWS SQS/SNS, Redis/BullMQ/Celery, NATS, etc.)
* Queues
* Topics/exchanges/streams
* Routing keys / subject bindings
* Dead-letter queues (DLQ)
* Retry mechanisms
* Scheduled/repeated jobs
* Database interactions
* External API calls
* Transaction boundaries
* Deployment architecture
* Docker/Kubernetes/server configuration
* Environment variables and broker configuration
* Monitoring/logging
* Existing tests

### Tracing Message Flows End-to-End

Trace every significant message flow end-to-end. For each flow, document:

```text
Producer
  ↓
Broker
  ↓
Queue/Topic
  ↓
Consumer
  ↓
Database / External Service
  ↓
ACK
```

> [!IMPORTANT]
> Do not provide recommendations until you understand these flows from real code in the repository.

---

## 2. Queue vs Topic / Publish-Subscribe

For every queue, topic, exchange, stream, or event you find, determine whether its current communication pattern is appropriate.

Classify each as:
* **Command** (point-to-point intent, single consumer expected)
* **Event** (fact that occurred, potentially multiple independent consumers)
* **Work queue** (competing consumers sharing load)
* **Pub/sub event** (fan-out broadcast to distinct subsystems)
* **Scheduled job** (time-triggered task execution)
* **Internal notification** (ephemeral internal state update)
* **Integration message** (cross-system or third-party contract)

Audit checks:
* Should this be a queue or a topic/pub-sub pattern?
* Should multiple consumers receive the message independently?
* Are multiple consumers incorrectly competing for messages that should be broadcast?
* Are multiple consumers unnecessarily receiving messages that only one needs?
* Is routing happening in the broker (native routing keys/topics) or filtered inside consumers?
* Are routing keys, topic names, and queue names consistent and intentional?

Explain reasoning based on the actual consumer requirements, not abstract theory.

---

## 3. Delivery Semantics

Determine what delivery guarantees the system actually provides in practice:
* **At-most-once**
* **At-least-once**
* **Effectively-once through idempotency**
* **Exactly-once claims** (evaluate critically)

Examine the code for:
* **ACK timing:** ACK before processing, ACK after processing, or ACK after database commit?
* Messages lost if worker crashes during processing
* Duplicate message processing paths
* Consumer crash behavior
* Producer crash behavior
* Broker crash behavior
* Network failure and reconnect behavior
* Visibility timeout / lease duration vs worst-case processing duration
* Redelivery behavior and unacknowledged message requeueing

Verify whether consumers are defensively designed for duplicate delivery.

---

## 4. Idempotency

Audit every consumer for idempotency:
* Event IDs / Message IDs / Business keys
* Idempotency keys & unique database constraints
* Deduplication tables / cache entries
* Transactional processing & upserts (`INSERT ... ON CONFLICT`, merge)
* Duplicate external API calls (payments, emails, webhooks, third-party state mutations)
* Race conditions between concurrent duplicate deliveries

For every non-idempotent consumer, detail the failure scenario:

```text
Message received
      ↓
DB updated
      ↓
Worker crashes
      ↓
Message redelivered
      ↓
DB updated again
```

Determine whether this causes a real correctness problem or silent state corruption.

---

## 5. Retry Strategy

Audit retry behavior across all worker and consumer loops:
* Maximum retry count / attempts limit
* Exponential backoff and jitter configuration
* Initial and maximum retry delays
* Retryable vs non-retryable errors classification
* Risk of infinite retries and poison messages blocking queues
* Broker-level retry (nack/requeue) vs application-level retry (delayed queues, retries table)
* Retry ordering impact
* Retry storms and downstream thundering herds

Evaluate handling of specific failure modes:
* `400 / Validation error` → Non-retryable (reject/DLQ immediately)
* `401 / Authorization error` → Refresh credential or alert
* `404 / Missing resource` → Permanent vs eventual consistency
* `409 / Conflict` → Optimistic lock retry vs reject
* `429 / Rate limit` → Backoff based on `Retry-After` header
* `500 / Server error` → Transient retry with backoff
* `503 / Service unavailable` → Transient retry with backoff
* `Timeout / Network partition` → Safe retry if idempotent

Recommend which errors must be retried and which must route directly to a DLQ.

---

## 6. Dead Letter Queues (DLQ)

Determine whether the system has an operational DLQ strategy:
* Which messages enter the DLQ?
* After how many attempts or what elapsed time?
* Can DLQ messages be safely inspected without consuming them destructively?
* Can messages be replayed / redriven after bug fixes?
* Is the original payload preserved intact (without schema mangling)?
* Is failure metadata preserved (exception stack trace, error code, timestamp, retry count, original headers)?
* Is there an operational workflow, alerting, or runbook for DLQ messages?

A DLQ should not be a black hole where business data disappears silently.

---

## 7. Ordering

Determine whether message ordering matters for each message flow:
* Is ordering strictly required (e.g., financial ledger, state transitions)?
* Is ordering actually guaranteed by the broker and consumer configuration?
* Can concurrent workers process related messages out of order?
* Are messages partitioned/keyed appropriately (e.g., Kafka partition key, SQS MessageGroupId)?
* Can retries break message ordering?
* Can duplicate messages create ordering anomalies?

Identify flows where the application assumes FIFO ordering without enforcing single-consumer or partition affinity.

---

## 8. Concurrency & Resource Contention

Audit worker concurrency:
* Number of consumers, workers, processes, threads, or goroutines
* Prefetch / batch size configuration (e.g., `prefetch_count`, `max_poll_records`)
* Parallel processing limits per node and cluster-wide
* Database connection pool sizing vs worker concurrency
* External API rate limits and connection pooling
* Broker connection limits and channel limits
* CPU and memory saturation under peak load
* In-process race conditions and shared state locks

Flag situations where scaling up worker count would saturate the database or external APIs.

---

## 9. Backpressure & Load Management

Determine what happens when producers outpace consumers:
* Queue growth and queue depth limits
* Consumer autoscaling triggers and scale-up lag
* Producer rate limiting, throttling, or backpressure signals
* Load shedding strategies
* Broker memory and disk limits (broker alarms, blocked publishers)
* Database connection starvation

Determine whether the system degrades gracefully or cascades into catastrophic failure.

---

## 10. Transactional Consistency

Audit database transactions combined with message publishing:

```text
BEGIN TRANSACTION
  UPDATE orders ...
COMMIT
publish("order.updated")  <-- What if broker is unreachable or process crashes here?
```

Or:

```text
publish("order.updated")  <-- What if DB transaction fails/rollbacks after publish?
COMMIT
```

Determine whether the system needs:
* **Transactional Outbox Pattern** (CDC / poller writing events atomically with business data)
* **Inbox Pattern** (deduplicating and processing within consumer transactions)
* **Idempotent Consumers**
* **Two-Phase Commit / Broker Transactions** (only if strictly justified)

Do not recommend the Outbox Pattern reflexively—verify whether the actual failure modes and business criticality justify the added operational complexity.

---

## 11. Message Schema & Contract Evolution

Audit message formats and payload structure:
* Schema format (JSON, Protocol Buffers, Avro, etc.)
* Versioning strategy (envelope version, event type version)
* Standard envelope fields:
  * `eventId` / `messageId`
  * `eventType` / `eventName`
  * `timestamp`
  * `correlationId`
  * `causationId`
  * `producer` / `source`
* Schema validation (at producer, consumer, or schema registry)
* Backward and forward compatibility rules
* Required vs optional fields
* Coupling risk: Is the message anemic/coupled to internal database models, or does it represent an explicit domain contract?

Prefer stable domain/integration contracts over serializing database entities.

---

## 12. Observability & Tracing

Determine whether a message can be traced end-to-end through distributed logs and traces:
* Propagation of `traceId`, `correlationId`, `causationId`, and `messageId` across headers
* Context propagation across process boundaries
* Can logs answer: *"Where did this message originate, what worker processed it, how long did each stage take, and why did it fail?"*
* Metrics availability:
  * Queue depth / backlog size
  * Consumer lag
  * Processing latency and duration percentiles (p50, p95, p99)
  * Throughput (messages/sec published vs consumed)
  * Error rates and retry counts
  * DLQ message count and age
  * Redelivery count
  * Age of oldest message in queue

---

## 13. Failure Scenarios

Simulate and analyze the following 10 failure scenarios against the current codebase:

| Scenario | Event | Current Behavior & Consequence |
| :--- | :--- | :--- |
| **A** | Consumer crashes before processing | |
| **B** | Consumer crashes during processing (halfway through side effects) | |
| **C** | Consumer crashes after DB commit but before ACK | |
| **D** | Broker becomes unavailable or restarts | |
| **E** | Database becomes unavailable during consumer run | |
| **F** | External API becomes unavailable or rate-limits | |
| **G** | Message is delivered twice (network retry or rebalance) | |
| **H** | Messages arrive out of order | |
| **I** | Malformed or poison message enters the queue | |
| **J** | Producer deploys a new message schema before consumers upgrade | |

Explain precisely what happens in the current implementation for each scenario.

---

## 14. Security & Isolation

Audit:
* Authentication to broker (passwords, mTLS, IAM roles, SASL, tokens)
* Authorization and topic/queue ACLs
* Credential management (environment variables, vaults, hardcoded secrets)
* TLS in transit (client-to-broker, broker-to-broker)
* Sensitive data / PII in payloads (passwords, tokens, personal identifiers)
* Payload encryption at rest and in transit
* Tenant isolation in multi-tenant environments (cross-tenant message leakage risk)

---

## 15. Performance & Efficiency

Evaluate performance bottlenecks:
* Oversized payloads (large blobs stored in message instead of Claim-Check pattern)
* Serialization / deserialization overhead
* N+1 message publishing or consumption patterns
* Unnecessary synchronous waits inside consumers
* Polling efficiency vs push-based delivery
* Batching and prefetch tuning
* Connection and channel churn (reconnecting per message)

Focus on real architectural bottlenecks over theoretical microsecond optimizations.

---

## 16. Operational Complexity

Ask for every component: *"What problem does this component solve?"*
* Unnecessary queues, exchanges, or topics
* Duplicate retry systems (application loop fighting broker retry)
* Redundant schedulers or pollers
* Overengineered abstractions wrapping standard broker SDKs
* Broker features enabled without clear necessity

Prefer the simplest architecture that satisfies reliability and business requirements.

---

## 17. Code Quality & Lifecycle Management

Inspect implementation files for:
* Error handling completeness (no swallowed exceptions)
* Connection management and pooling (channels/connections reused, not created per message)
* Automatic reconnection and topology re-declaration
* Graceful shutdown (finishing in-flight messages before SIGTERM exits, stopping consumer intake first)
* Cancellation token / context propagation on shutdown and timeout
* Resource cleanup (closing file handles, connections, statements)
* Type safety and payload deserialization guards
* Structured logging with context

---

## 18. Testing & Validation

Audit test coverage for asynchronous code:
* Unit tests for consumer business logic in isolation
* Integration tests with real or containerized broker (Testcontainers, embedded broker)
* Duplicate delivery / idempotency tests
* Retry and backoff tests
* Poison pill and DLQ routing tests
* Crash recovery tests
* Schema compatibility tests

Recommend the minimum set of high-value tests needed.

---

## 19. Deliverable: Architecture Findings Report

Produce the final audit report using this exact structure:

### Executive Summary
Concise description of the current architecture, broker technologies, and overarching reliability posture.

### Architecture Diagram
ASCII diagram illustrating:
```text
Service → Broker → Queue/Topic → Consumer → DB/API
```

### Message Flow Inventory
Comprehensive inventory table:

| Flow | Type | Broker Primitive | Producer | Consumer(s) | Delivery Guarantees | Retry Strategy | DLQ | Idempotent? | Risk Level |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |

### Findings

Classify each finding by severity: `CRITICAL`, `HIGH`, `MEDIUM`, or `LOW`.

```markdown
### [SEVERITY] <Short Descriptive Title>

**Location:** `<file path>:<line number>` or `<component name>`

**Problem:**
<Concise explanation of what is happening in the code>

**Why it matters:**
<Concrete failure mode, data loss, state corruption, or operational risk>

**Failure Scenario:**
<Step-by-step trace of how the failure triggers in production>

**Recommendation:**
<Specific code or configuration change>

**Trade-off:**
<Operational or development cost of the change>
```

### What Is Already Good
Highlight existing patterns, correct idempotency guards, or sensible configurations that should be preserved.

### Recommended Architecture
Show the proposed target architecture with ASCII diagrams and updated flow patterns.

### Migration Plan
Prioritized phased roadmap:
* **Phase 1 — Correctness:** Prevent message loss, corruption, duplicate execution bugs, or data inconsistency.
* **Phase 2 — Reliability:** Retries, DLQs, graceful shutdown, error classification.
* **Phase 3 — Observability:** Distributed tracing, correlation IDs, queue depth / lag metrics, alerting.
* **Phase 4 — Scalability:** Prefetch tuning, concurrency controls, backpressure, partitioning.
* **Phase 5 — Optimization:** Batching, payload slimming, Claim-Check pattern, connection pooling.

---

## Non-Negotiable Audit Rules

1. **Inspect actual code before making recommendations.** Never assume based on conventions alone.
2. **Do not favor brokers based on popularity.** Evaluate Kafka, RabbitMQ, SQS, Redis, etc., based on requirements.
3. **Do not recommend microservices** unless the existing system already requires them.
4. **Prefer simplicity.** The best distributed system is the one with the fewest moving parts that meets the SLA.
5. **Distinguish bugs from risks.** Separate actual defects from theoretical edge cases.
6. **Cite exact files, functions, and line numbers** for every finding.
7. **Explicitly state unknowns.** If a config or broker setup is external or undocumented, state that it is unknown.
8. **Never invent configuration.** If you did not find a setting in the repo, do not assume it exists.
9. **Ground recommendations in current scale.** Do not impose hyperscale complexity on moderate-throughput apps.
10. **Analyze DB and messaging consistency together.** An ACK is meaningless if the database rolled back.
11. **Assume duplicate delivery will happen.** If a consumer is not idempotent, it is vulnerable.
12. **Treat external APIs as unreliable and slow.**
13. **Assume workers can crash at any CPU instruction.**
14. **Check graceful shutdown.** Can a deployment drop messages in flight?
15. **Consider multi-instance deployment.** Do consumers step on each other when running N replicas?
16. **Consider rolling deployments.** What happens when v1 and v2 consumers run simultaneously?
17. **Separate must-fix from nice-to-have.**
18. **Provide concrete code-level solutions**, not generic advice.
19. **If the code is already correct, say so.** Do not invent problems.
20. **Answer the 10x traffic breakdown question.**

---

## Final Concluding Question

At the conclusion of the audit, always provide a dedicated section answering:

> **"If this application receives 10× its current traffic tomorrow, what will break first, and why?"**

Base the answer strictly on evidence found in the repository (e.g., unconstrained connection pools, missing prefetch, unindexed deduplication tables, synchronous external HTTP calls in consumers, or unbounded queue memory).
