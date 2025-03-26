# Use official Jenkins image
FROM jenkins/jenkins:lts

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Switch to root user
USER root

# Update and install necessary packages with retries
RUN apt-get update && \
    for i in {1..5}; do \
      apt-get install -y --no-install-recommends \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg \
      make \
      g++ && break || sleep 10; \
    done && \
    apt-get install -f -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Switch back to Jenkins user
USER jenkins

# Expose ports
EXPOSE 8080 50000

# Start Jenkins
CMD ["java", "-jar", "/usr/share/jenkins/jenkins.war"]
