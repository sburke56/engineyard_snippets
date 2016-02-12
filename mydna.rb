#!/usr/bin/env ruby

require 'json'
require 'yaml'

# in production file is located at /etc/chef/dna.json
dnaFile = File.read('./dna.json')
dnaJson = JSON.parse(dnaFile)

# in production file is located at /etc/engineyard/instance_api.yml
instance_apiYaml = YAML.load_file('./instance_api.yml')

instances = dnaJson["engineyard"]["environment"]["instances"]

printf("%-20s %-15s\n", "AWS Instance ID:",  dnaJson["engineyard"]["this"])
printf("%-20s %-15s\n", "Role:", dnaJson["engineyard"]["environment"]["name"])
printf("\n")

# Spin through the instances and see which one we are currently using by
# matching the instance_id from the instance_api.yml file
instances.each do |i|
  if i["instance_api_config"]["instance_id"] == instance_apiYaml["instance_id"]
    printf("%-20s %-15s\n", "Public Hostname:", i["public_hostname"])
    printf("%-20s %-15s\n", "Private Hostname:", i["private_hostname"])
    printf("%-20s %-15s\n", "Role:", i["role"])
  end
end
