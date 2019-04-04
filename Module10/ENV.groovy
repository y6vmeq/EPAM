import groovy.json.JsonSlurper 
def cmd = "sudo knife environment list -F json -c /home/vagrant/chef-repo/.chef/knife.rb"
Process proc = cmd.execute()
proc.waitFor()
def list = new JsonSlurper().parseText(proc.text)
return list