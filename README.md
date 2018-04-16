# Welcome to D3.js example for Neo4j

<img src="/demo/demo-screen.png?raw=true" width="500px"/>

This is [D3.js v5](https://d3js.org/) example visualize the result from [Neo4j](https://neo4j.com/).

## Live Demo
If you have Neo4j installed and started locally with HTTP endpoint opened for `7474` port (of course with `neo4j:password` as login/password), you can try the live demo directly.
1. [query.html](https://rawgit.com/micwan88/d3js-neo4j-example/master/query.html)
2. [ctm-query.html](https://rawgit.com/micwan88/d3js-neo4j-example/master/ctm-query.html)

## Page List
1. General example for D3.js + Neo4j ([query.html](query.html))
2. Styled example for D3.js + Control-M model in Neo4j ([ctm-query.html](ctm-query.html))

## Pre-requisite
1. You have to start your the Neo4j server as the example page connect it via HTTP endpoint.
2. Modify the Neo4j login and password in the example page as below.

``` javascript

//Modify below value to match your Neo4j setup
var neo4jAPIURL = 'http://localhost:7474/db/data/transaction/commit';
var neo4jLogin = 'neo4j';
var neo4jPassword = 'password';
```

## Styled Example for D3.js + Control-M jobflow model in Neo4j (`ctm-query`)
This is an example to visualize the Control-M jobflow in Neo4j. To try this, you have to load the Control-M job xml into Neo4j via [APOC plugin](https://github.com/neo4j-contrib/neo4j-apoc-procedures) and a series of Cypher queries.

The example of Cypher script can be found in ([here](cypher-example/controlm-model.cypher)).