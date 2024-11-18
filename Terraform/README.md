# Deploying the 'Secure Web App' using Terraform.
This `README.md` provides some additional information for blue teamers during the hacking week.

## Introduction
The 'Secure Web Application' can be deployed to Azure using Infrastructure as Code with Terraform.
This essentially lets you build the entire Azure environment based on the Terraform code.

I chose to use Terraform so that Blue-teamers are able to access the Azure environment themselves as they can now deploy it themselves.

## How to use Terraform

### Step 1: Install Terraform
See [Terraform Documentation](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) and install Terraform on your local PC.

### Step 2: Authenticate with Azure CLI

See [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli) on how to authenticate with Azure CLI.

### Step 3: Clone the repository
Clone this repository to your local PC using:
```
git clone https://github.com/Cyber-Security-S7/Secure-Web-App.git
```

Make sure you run the next terraform commands inside the /Terraform/.. folder so it finds the terraform code.

### Step 4: Manage terraform secrets
Rename the [`terraform.tfvars.example`](terraform.tfvars.example) file into `terraform.tfvars`, and update the docker username and docker password to your credentials (credentials to Dockerhub, make an accout if you do not already have one).
These are required by Terraform because it needs to pull the docker image from Dockerhub. Even though the repository is public it wants you to authenticate, so make sure you have this configured.

### Step 5: Initialize Terraform
Not sure if this is required, but just run it.
```
terraform init
```

### Step 6: Make terraform build plan
This command will create the terraform plan.
You can also look up how to save the plan if you want, but I usually just run this.
```
terraform plan
```

### Step 7: Apply the build plan
This command can only be run after you have created the plan.
```
terraform apply
```

### Step 8: Destroy the build plan
If you are done with testing or done after the hacking week you can use the following command to destroy all infrastructure which Terraform created.

```
terraform destroy
```

## About the Terraform code itself
The Terraform code deploys the 'Secure Web Application' as a container deployment on Azure.
Terraform will also make a public static IP adress so that the web application is accessible.

Terraform will tell you the IP adress after running the deploy command, but you can also look it up in the Azure portal.

## Monitoring
The only logs currently available are that of the docker image itself.
You can find them through the Azure portal.

If you want to make changes to the Terraform code for the monitoring part of blue-teaming, I would recommend that you clone/fork the repository and add the changes. 

I expect that Azure offers several services which you could look into to perform security monitoring. If you want to use open-source / self-hosted monitoring tools, then we will need to find a way to probably push logs from Azure to the monitoring solution, but I don't know exactly how this would work and what is required.

## Azure costs
Using your Fontys account you get some free credits on Azure which you can use to host this application.
If you want to save credits, make sure to destroy the Terraform environment in the evenings, as this will save costs on the public IP adress and the docker container.

The only downside here is that everytime you re-build your environment, you'll get a different public IP adress, so you have to notify the red-teamers.