# EFK_Master

This will install the Elasticsearch, Kibana and fluentd on your node. This can be used as a Master node, Since it has Kibana.

I have added another repo (Cookbook) called EFK_Node for the nodes.


To upload 

# chef cookbook upload EFK_Master

To Bootstarp a node with this cookbook

# knife bootstrap <YourIP> --ssh-user <Username> --sudo --ssh-password <Password> --node-name <Yournode name> --run-list 'recipe[EFK_Master]'
