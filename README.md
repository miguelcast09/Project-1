## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![diagram](https://user-images.githubusercontent.com/105833279/169910761-37a31834-4f86-4bf1-82e4-29a366527c8b.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook (YAML) file may be used to install only certain pieces of it, such as Filebeat.

  - [Filebeat Playbook](https://github.com/miguelcast09/Project-1/blob/main/Ansible/filebeat-playbook.yml)
  - [Metricbeat Playbook](https://github.com/miguelcast09/Project-1/blob/main/Ansible/metricbeat-playbook.yml)
  
This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly responsive, in addition to restricting inbound access to the network.
- The looad balancer's main security aspect is to protect macine from Denial of Service attacks. Also, the advantage of using a jump box is that it is a hardened and monitored device which is used to access, manage and update other devices .

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the log files and system metrics.
- Filebeat collects centralized log information and forwards the data to either Elasticsearch or Logstash for indexing.
- Metricbeat records metrics and statistics that it collects from systems and services, and ships them to any specified output.


| Name                 | Function          | IP Address | Operating System            |
|----------------------|-------------------|------------|-----------------------------|
| Jump-Box-Provisioner | Gateway           | 10.0.0.4   | Linux Ubuntu 18.04 LTS Gen2 |
| Web-1                | Web Server        | 10.0.0.5   | Linux Ubuntu 18.04 LTS Gen2 |
| Web-2                | Web Server        | 10.0.0.6   | Linux Ubuntu 18.04 LTS Gen2 |
| ELKvm                | Monitoring Server | 10.1.0.5   | Linux Ubuntu 18.04 LTS Gen2 |


### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the jump box machine can accept connections from the Internet. Access to this machine is only allowed from the IP address: 99.158.45.25

Machines within the network can only be accessed by Jump-Box-Provisioner VM.
- The only machine that has access to the ELK server is the Jump-Box-Provisioner VM. The elk's machine ip address is: 10.1.0.5

A summary of the access policies in place can be found in the table below.

| Name                 | Publicly Accessible | Allowed IP Addresses |
|----------------------|---------------------|----------------------|
| Jump-Box-Provisioner | Yes                 | 99.158.45.25         |
| Web-1                | No                  | 10.0.0.4             |
| Web-2                | No                  | 10.0.0.4             |
| ELKvm                | No                  | 99.158.45.25         |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it automates cloud provisioning, device management, application deployment, intra-service orchestration, and other IT needs. 

The playbook implements the following tasks:
- Firstly, install docker.io, python3-pip and the docker module itself one at a time, and in that order.
- Secondly, increase the virtual memory of the machine by executing the command sysctl -w vm.max_map_count=262144 and make it present in the machine.
- Then, download and launch the docker elk container by publishing the ports it will run on ( 5601:5601, 9200:9200 and 5044:5044). 
- Finally, enable the service docker on boot.

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![Docker ps output](https://user-images.githubusercontent.com/105833279/170160790-1910aac5-de6c-4d08-b071-75e3e8d2fbf5.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:

| Machine | IP Address |
|---------|------------|
| Web-1   | 10.0.0.5   |
| Web-2   | 10.0.0.6   |

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:

- Metricbeat records system metrics and statistics from the operating system and services running on the server to help increase the availability and reliability of the system. Filebeat collects information about the file system and log files from services like Apache or Microsoft Azure tools to efficiently manage and centralize the files, folders and logs.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the filebeat-config.yml file to /etc/ansible/files/filebeat-config.yml.
- Update the filebeat-config.yml file to include the host ip address for the ELK vm for: output.elasticsearch and setup.kibana.
- Run the playbook, and navigate to the ELK's public ip address 20.211.156.16:5601/app/kibana to check that the installation worked as expected.

The playbook files are:
- filebeat-playbook.yml- file is then copied to /etc/filebeat/filebeat.yml
- metricbeat-playbook.yml- file is then copied to /etc/metricbeat/metricbeat.yml

Now, specify the machine that will run the playbook by navigating into directory /etc/ansible/ and running nano against hosts files to add the IP address of the VM's. Then, create two collection of hosts ([azureweb] and [elk]) to specify the groups where the ELK server and Filebeat will be installed on.

Lastly, navigate to the ELK's IP address: 20.211.156.16:5601/app/kibana to verify that the server is up and running.

Commands to execute in order to run the Playbook:
- ansible-playbook install-elk.yml
- ansible-playbook filebeat-playbook.yml
- ansible-playbook metricbeat-playbook.yml
- ansible-playbook my-playbook.yml
