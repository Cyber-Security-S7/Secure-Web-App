# Secure-Web-App
Contains a 'secure web app' example application made in Blazor for educational purposes.

See the Body of Knowledge document for further explanation on topics, or run the application using Docker Compose.

[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=Cyber-Security-S7_Secure-Web-App&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=Cyber-Security-S7_Secure-Web-App)


## Terraform
Terraform is used to deploy the secure web application to the cloud.
Terraform is a form of Infrastrucure as Code, where you define the cloud environment from a code perspective, and can build or destroy your environment with simple commands.

### Terraform + Relation to security
One of the benefits of using infrstructure as code is that it deploys from a 'single source of truth'.
The IaC code can be reviewed by other people, and can also be statically scanned.
Because you always build the same environment using the same IaC, it makes your deployment more fault-tolerant, as less human made misconfigurations happen.


