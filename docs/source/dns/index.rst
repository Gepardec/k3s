**************
DNS Server
**************

Kubernetes and DNS
####################

The Domain Name System (DNS) is a system for associating various types of information – such as IP addresses – with easy-to-remember names. By default most Kubernetes clusters automatically configure an internal DNS service to provide a lightweight mechanism for service discovery. Built-in service discovery makes it easier for applications to find and communicate with each other on Kubernetes clusters, even when pods and services are being created, deleted, and shifted between nodes.

To access a workload in Kubernetes we use Ingress. An Ingress is a a separate resource that configures a LoadBalancer in Kubernetes. The Ingress API supports TLS termination, virtual hosts, and path-based routing. It can easily set up a load balancer to handle multiple backend services. In the case of the LoadBalancer service, the traffic entering through the external load balancer is forwarded to the kube-proxy that in turn forwards the traffic to the selected pods. In contrast, the Ingress LoadBalancer forwards the traffic straight to the selected pods which is more efficient.

For virtual hosts specified by an Ingress a client must be able to resolve the DNS entry specified in the Ingress. For this purpose we run our own DNS server on our Bastion host.

-----

Access Kubernetes via DNS
#########################################

We run the kubernetes cluster in a dedicated private network. Only the bastion host provides access to the kubernetes nodes from the outside. As such all traffic directed at the kubernetes cluster needs to go through the bastion host. To enable traffic to pass through the bastion host a :doc:`loadbalancer <../lb/index>` is running on our bastion host with the kubernetes nodes as backend. Further information regarding our infrastructure architecture can be found in the :doc:`architecture <../arch/index>` section.

.. TODO ADD GRAFIK
   DNS NAME -> BASTION LB -> Kubernetes

All DNS entries pointing to our physical Loadbalancer running on the Bastion host.

In order to resolve DNS entries outside our internal infrastructure network we expose the DNS running on the Bastion host. Doing so we can resolve DNS entries from our workstations and reach the kubernetes cluster. 

----

DNS Entries and Purpose
##########################

Due to our infrastructure architecture we only need a wildcard dns entry `*.k3s` to serve the public IP of the bastion host. Further distinctions are handled by the :doc:`loadbalancer <../lb/index>` on the bastion host.

The kubernets api can be reached via https://api.k3s:6443 while workloads are available via http://[NAME].apps.k3s or https://[NAME].apps.k3s.

----

How to install DNS
###################

The ansible role bertvv.bind is used to install and configure the DNS Server on the bastion host. Here an example of a minimalistic playbook configuring the wildcard dns entry on the bastion host.

.. code-block:: yaml

    ---
    - hosts: bastion
      gather_facts: true
      become: true
      vars: 
        bind_allow_query:
        - any
        bind_listen_ipv4:
        - any
        bind_forwarders:
        - '8.8.8.8'
        - '8.8.4.4'
        bind_zone_master_server_ip: "{{ hostvars[inventory_hostname]['ansible_default_ipv4']['address'] }}"
        bind_zone_domains:
          - name: 'k3s'
            hostmaster_email: "office@gepardec.com"
            hosts:
            - name: "*"
                ip: "{{ hostvars[inventory_hostname]['ansible_default_ipv4']['address'] }}"
      roles:
        - bertvv.bind

----

CI for DNS
#################

We utilize molecule to test the compatibility of the bertvv.bind ansible role with CentOS 7,8 and Debian 10 in travis-ci.com and notify our slack channel k3s-alerts on failed CI runs up and the first green build after one or more failed builds.

Our latest CI runs are available at: https://travis-ci.com/github/gepardec/k3s
