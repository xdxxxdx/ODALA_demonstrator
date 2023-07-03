from rdflib import Graph, Literal, Namespace, RDF, URIRef
from rdflib.plugins.sparql import prepareQuery

# Create a new RDF graph
graph = Graph()

# Load your RDF data into the graph
graph.parse("../configs/devices/devices.sample.ttl.", format="turtle")
# Define the SPARQL CONSTRUCT query
with open("../devices.rq", "r") as file:
    query = file.read()
# Prepare the query for execution
q = prepareQuery(query)

# Execute the query and get the resulting RDF graph
result = graph.query(q)

# Print the resulting RDF graph
print(result.serialize(format="turtle").decode())
