#!/usr/bin/env ruby

require 'json'
require 'yaml'

dnaFile = File.read('./dna.json')
dnaJson = JSON.parse(dnaFile)

instance_apiYaml = YAML.load_file('./instance_api.yml')

instances = dnaJson["engineyard"]["environment"]["instances"]

printf("%-20s %-15s\n", "AWS Instance ID:",  dnaJson["engineyard"]["this"])
printf("%-20s %-15s\n", "Role:", dnaJson["engineyard"]["environment"]["name"])
printf("\n")

instances.each do |i|
  if i["instance_api_config"]["instance_id"] == instance_apiYaml["instance_id"]
    printf("%-20s %-15s\n", "Public Hostname:", i["public_hostname"])
    printf("%-20s %-15s\n", "Private Hostname:", i["private_hostname"])
    printf("%-20s %-15s\n", "Role:", i["role"])
  end
end
