import groovy.json.JsonSlurper
URL registryURL = new URL("http://node1:5000/v2/greeter/tags/list")
def list = new JsonSlurper().parseText(registryURL.text)
return list.tags