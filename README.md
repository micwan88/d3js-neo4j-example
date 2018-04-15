# Welcome to D3.js example for Neo4j

<img src="/demo/demo-screen.png?raw=true" width="500px"/>

This is [D3.js v5](https://d3js.org/) example visualize the result from [Neo4j](https://neo4j.com/).

## Examples
1. General example in D3.js for Neo4j ([query.html](query.html))
test
2. D3.js example for Control-M model in Neo4j ([ctm-query.html](ctm-query.html))
test

## Prerequisite
1. You have to start your the Neo4j server as the example page connect it via HTTP endpoint.
2. Modify the Neo4j login and password in the example page as below.

``` javascript

//Modify below value to match your Neo4j setup
var neo4jAPIURL = 'http://localhost:7474/db/data/transaction/commit';
var neo4jLogin = 'neo4j';
var neo4jPassword = 'password';
```
