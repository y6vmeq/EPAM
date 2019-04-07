import groovy.json.JsonSlurper
URL registryURL = new URL("http://node1:5000/v2/tomcat/tags/list")
def list = new JsonSlurper().parseText(registryURL.text)
return list.tags