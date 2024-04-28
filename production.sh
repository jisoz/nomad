#nomad in production
#Scenario:
# Imagine you have a cluster of servers running Nomad to manage containerized applications. This cluster consists of:

# Three Nomad Servers:

# Responsible for cluster management, scheduling decisions, and maintaining the authoritative state of the system.
# Use the Raft consensus protocol to achieve consensus on job placements and other decisions.
# Handle ACLs for controlling access to Nomad operations.
# Multiple Nomad Clients:

# Installed on each physical or virtual machine in the cluster.
# Responsible for reporting available resources (CPU, memory, etc.) to the Nomad servers.
# Execute tasks assigned by the Nomad servers based on job specifications.
# Perform health checks on running tasks and report the status back to Nomad servers.
# Can join or leave the cluster dynamically.
# Workflow:
# Job Submission:

# An application developer submits a Nomad job specification to the cluster. This job specifies the application, resource requirements, and other configurations.
# Nomad servers receive and evaluate the job, making decisions on where to run the application's tasks.
# Scheduling:

# Nomad servers use their knowledge of the cluster's resources, including information reported by Nomad clients, to schedule the application's tasks.
# They consider factors like CPU and memory requirements, constraints, affinity rules, and health checks.
# Allocation and Task Execution:

# Nomad servers decide to allocate specific tasks of the job to Nomad clients based on their available resources.
# Nomad clients receive the allocation and execute the tasks. This might involve starting containers or running native processes.
# Resource Reporting:

# Nomad clients continuously report resource utilization back to the Nomad servers. This includes information about CPU usage, memory usage, and available disk space.
# Nomad servers use this real-time resource information for future scheduling decisions.
# Health Checking:

# Nomad clients regularly perform health checks on the running tasks. For example, a health check might involve making HTTP requests to a web service to ensure it's responding.
# If a task is unhealthy, the Nomad client reports the status to the Nomad servers.
# Dynamic Scaling:

# If more machines are added to the cluster (new Nomad clients), they dynamically join the Nomad cluster, and Nomad servers start considering them in scheduling decisions.
# Similarly, if a machine goes offline or a Nomad client is stopped, Nomad servers adjust scheduling decisions accordingly.
# Consul Integration (Optional):

# Nomad clients can integrate with Consul for service discovery and health checking. This enables Nomad-managed services to be discovered by Consul and included in the Consul service registry.



#Installing Nomad for Production
export NOMAD_VERSION="1.1.0"
curl --silent --remote-name https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip
unzip nomad_${NOMAD_VERSION}_linux_amd64.zip
sudo chown root:root nomad
sudo mv nomad /usr/local/bin/
nomad version
nomad -autocomplete-install
complete -C /usr/local/bin/nomad nomad
sudo mkdir --parents /opt/nomad
sudo useradd --system --home /etc/nomad.d --shell /bin/false nomad
sudo nano /etc/systemd/system/nomad.service
[Unit]
Description=Nomad
Documentation=https://www.nomadproject.io/docs/
Wants=network-online.target
After=network-online.target

# When using Nomad with Consul it is not necessary to start Consul first. These
# lines start Consul before Nomad as an optimization to avoid Nomad logging
# that Consul is unavailable at startup.
#Wants=consul.service
#After=consul.service




[Service]

# Nomad server should be run as the nomad user. Nomad clients
# should be run as root
User=root
Group=root

ExecReload=/bin/kill -HUP $MAINPID
ExecStart=/usr/local/bin/nomad agent -config /etc/nomad.d
KillMode=process
KillSignal=SIGINT
LimitNOFILE=65536
LimitNPROC=infinity
Restart=on-failure
RestartSec=2

## Configure unit start rate limiting. Units which are started more than
## *burst* times within an *interval* time span are not permitted to start any
## more. Use `StartLimitIntervalSec` or `StartLimitInterval` (depending on
## systemd version) to configure the checking interval and `StartLimitBurst`
## to configure how many starts per interval are allowed. The values in the
## commented lines are defaults.

# StartLimitBurst = 5

## StartLimitIntervalSec is used for systemd versions >= 230
# StartLimitIntervalSec = 10s

## StartLimitInterval is used for systemd versions < 230
# StartLimitInterval = 10s

TasksMax=infinity
OOMScoreAdjust=-1000

[Install]
WantedBy=multi-user.target


sudo mkdir --parents /etc/nomad.d
sudo chmod 700 /etc/nomad.d
sudo nano /etc/nomad.d/nomad.hcl 
datacenter = "dc1"
data_dir = "/opt/nomad"


sudo nano /etc/nomad.d/server.hcl

log_level = "DEBUG"

server {
  enabled = true
  bootstrap_expect = 1
}

advertise {
  http = "178.128.192.173"  #ip of server 
  rpc  = "178.128.192.173"
  serf = "10.19.0.7"
}

chown :nomad /etc/nomad.d
chmod 750 /etc/nomad.d

chown -R nomad:nomad /opt/nomad

sudo systemctl enable nomad
sudo systemctl start nomad
sudo systemctl status nomad


#info 
nomad.hcl:
This file typically contains general configuration settings for the Nomad agent. Here are the key configurations:

datacenter: Specifies the datacenter to which the Nomad agent belongs. This is important when running Nomad in a multi-datacenter environment, and it helps Nomad agents discover and communicate with each other within the same datacenter.

data_dir: Defines the directory where Nomad stores its data, including state, logs, and other persistent information.

server.hcl:
This file is specifically used for configuring Nomad servers. It contains settings related to running Nomad in server mode.
#href="https://releases.hashicorp.com/nomad/1.1.0/nomad_1.1.0_linux_arm64.zip





#in odroid same installation but in /etc/nomad.d/client.hcl (v1.3.0-beta.1)
    client {
    enabled = true
    #   servers = ["178.128.192.173:4647"]  # Replace with the public IP of the remote machine
    }
#also put  liek before the nomad.hcl

# to run job make sure making this 
sudo usermod -aG docker nomad
sudo systemctl restart nomad




nomad stop -purge officefrontend
nomad node status -verbose 33383d74-5279-6699-d062-6b6bfb8d7b07
nomad job status jobname
nomad alloc status dac34c14
nomad deployment list
nomad job restart jobname 
nomad job scale [options] <job> <group> <count>
nomad job scaling-events [options] <job>


for raw_exec : 
client.hcl
client {
  enabled = true
  servers = ["178.128.192.173:4647"]  # Replace with the public IP of the remote machine


  host_volume "postgres" {
  path      = "/srv/live/postgres-database/data/"  #(dont forget to chown nomad:nomad  la kel shi b2lb data )
   read_only = false

}
}

#plugin "exec" {
 # config {
  #  enabled = true
  #}
#}
plugin "raw_exec" {
  config {
    enabled = true
  }
}

in /srv...... pg_hba.conf change and restart back

# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     trust
# IPv4 local connections:
host    all             all             0.0.0.0/0            trust
# IPv6 local connections:
host    all             all             ::1/128                 trust
# Allow replication connections from localhost, by a user with the
# replication privilege.
local   replication     all                                     trust
host    replication     all             0.0.0.0/0            trust
host    replication     all             ::1/128                 trust

host all all all trust
