# This is a user guide of jira and confluence

- Start the Containers
  ```bash
  docker-compose up -d

- Connecting Jira and Confulence with a PostgreSql Database

  ```bash
  docker exec -it postgres-db psql -U admin

- Create database for both jira and confluence
  
  ```bash
  CREATE DATABASE jiradb;
  CREATE DATABASE confluencedb;

# Jira and Confluence Data Restore Process

This guide outlines the steps to restore Jira & Confluence data from a backup using Docker and PowerShell.

- Copy the backup file to the Jira container, replace your actual path of jira backup file

  ```bash
  docker cp C:\Users\onur\final_jira_backup.zip jira:/var/atlassian/application-data/jira/import

- Verify that the file is indeed in the correct location. You can do this by accessing the Jira container and listing the files:

  ```bash
  docker exec -it jira /bin/bash
  cd /var/atlassian/application-data/jira/import
  ls

- When the setup wizard prompts for the backup, ensure you select final_backup.zip, which contains the necessary XML files:

  ```bash
  /var/atlassian/application-data/jira/import/final_jira_backup.zip

- Copy the backup file to the Confluence container, replace your actual path of confluence backup file

  ```bash
  docker cp C:\Users\onur\final_confluence_backup-2024-09-15-14-41-30-617.xml.zip confluence:/var/atlassian/application-data/confluence/restore/site

- Verify that the file is indeed in the correct location. You can do this by accessing the Confluence container and listing the files:

  ```bash
  docker exec -it confluence /bin/bash
  cd /var/atlassian/application-data/confluence/restore/site
  ls
