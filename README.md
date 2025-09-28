# Kubernetes-Event-Driven-Autoscaling-with-KEDA
This project demonstrates how to use KEDA (Kubernetes Event-Driven Autoscaling) to scale workloads in Kubernetes based on external events (instead of only CPU/Memory metrics).

Why KEDA?
Traditional HPA (Horizontal Pod Autoscaler) scales only on CPU/Memory.
KEDA enables event-driven scaling from sources like Azure Event Hub, Kafka, RabbitMQ, Prometheus, etc.
Saves costs by scaling to zero when idle and scaling up instantly when demand increases.

What I Did
Created an Azure Event Hub as the event source.
Configured a ScaledObject in Kubernetes linked to Event Hub.
Deployed a sample application to respond to messages.
Verified autoscaling:
Scale up when messages arrive.
Scale down to zero when idle.

Benefits
Cost efficiency – no idle workloads.
Performance – apps scale instantly based on demand.
Cloud-native – works seamlessly on AKS or any Kubernetes cluster
