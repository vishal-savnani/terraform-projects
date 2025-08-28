                    ┌──────────────────────────┐
                    │        Internet          │
                    └─────────────┬────────────┘
                                  │
                     ┌────────────▼─────────────┐
                     │ Application Load Balancer│
                     │  (Public Subnets + SG)   │
                     └─────────────┬────────────┘
                                   │
                ┌──────────────────▼───────────────────┐
                │         Target Group (ALB)           │
                └───────────────┬─────────────────────┘
                                │
        ┌───────────────────────▼───────────────────────┐
        │            ECS Service (Fargate)              │
        │  - Desired count (e.g., 2 tasks)              │
        │  - Rolling updates                            │
        └───────┬───────────────────────┬──────────────┘
                │                       │
     ┌──────────▼─────────┐   ┌─────────▼──────────┐
     │   Task 1 (Fargate) │   │   Task 2 (Fargate) │
     │ Container from ECR │   │ Container from ECR │
     │ Logs → CloudWatch  │   │ Logs → CloudWatch  │
     └────────────────────┘   └────────────────────┘

