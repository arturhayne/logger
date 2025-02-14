# Log Monitoring System

## Overview
This system collects, processes, and visualizes logs using **Filebeat**, **Elasticsearch**, and **Kibana**.

- **Filebeat** collects log files and sends them to **Elasticsearch**.
- **Elasticsearch** indexes and stores log data.
- **Kibana** provides a UI for analyzing logs.

## Project Structure
```
logs/
│── application.log  # Example log file
│── error.log        # Example error log file
│── access.log       # Example access log file
│
config/
│── filebeat.yml     # Filebeat configuration file
│── pipeline_logs.json # Elasticsearch ingest pipeline
│
Dockerfile          # Dockerfile for Filebeat container
```

## Prerequisites
Make sure you have **Docker** installed on your system.

## Setup and Execution

1. **Clone the repository**
   ```sh
   git clone <repository-url>
   cd <repository-folder>
   ```

2. **Start the services** using Docker Compose:
   ```sh
   docker-compose up -d
   ```
   This will start **Elasticsearch**, **Kibana**, and **Filebeat**.

3. **Create the pipeline in Elasticsearch:**
   ```sh
   curl -X PUT "http://localhost:9200/_ingest/pipeline/pipeline_logs" \
        -H "Content-Type: application/json" \
        -d @config/pipeline_logs.json
   ```

4. **Verify that Filebeat is running correctly:**
   ```sh
   docker logs filebeat --tail 50
   ```

5. **Check if logs are reaching Elasticsearch:**
   ```sh
   curl -X GET "http://localhost:9200/filebeat-*/_search?pretty"
   ```

6. **Access Kibana** at:  
   [http://localhost:5601](http://localhost:5601)

7. **Configure Kibana Index Pattern:**
   - Navigate to **Management** → **Stack Management** → **Index Patterns**.
   - Create a new pattern: `filebeat-*`.
   - Set `@timestamp` as the time filter field.

## Troubleshooting

- **Elasticsearch is not accessible:**
  ```sh
  curl -X GET "http://localhost:9200/_cat/health?v"
  ```
  If it is not running, restart the container:
  ```sh
  docker restart elasticsearch
  ```

- **Filebeat logs are not appearing:**
  ```sh
  docker logs filebeat
  ```
  Check the `filebeat.yml` configuration.

- **No logs in Kibana?**
  - Verify logs exist in Elasticsearch using step **5**.
  - Update the time range in Kibana's Discover tab.

## Stopping the System
To stop all services, run:
```sh
docker-compose down
```

