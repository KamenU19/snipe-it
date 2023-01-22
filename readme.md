Telerik 2020 DevOps Project

A repository for the Telerik 2020 DevOps Project for deploying SnipeIT

Initial setup and validations:
1) Add License
2) Add Readme 

Build and upload:
1) Build docker image
2) Scan the docker image with Snyk
3) Push docker image
4) Build infrastructure (EC2 - server, EC2 - self hosted runner, S3, ALB, setup networking)
5) Scan the Terraform code with chekov

Additional setup:
1) Set up Web Application Firewall WAF - Cloudflare
2) Set up Intrustion Detection System (IDS), File Integrity Monitoring (FIM) and vulnerability scanning - Wazuh 
3) Set up Application Performance Monitoring (APM) - New Relic
4) Set up Availabiliity monitoring - updown


