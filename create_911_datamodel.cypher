CREATE CONSTRAINT personIdConstraint IF NOT EXISTS FOR (person:Person) REQUIRE person.id IS UNIQUE;


MATCH (n)
DETACH DELETE n;


// load group nodes
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/lrnzhil/workshop/main/datasets/groups.csv' AS row
FIELDTERMINATOR ';'
MERGE (g:Group {groupid: row.GroupId, name: row.GroupName});

// load person nodes
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/lrnzhil/workshop/main/datasets/persons.csv" AS row
FIELDTERMINATOR ';'
MERGE (p:Person {personid: row.NodeId, firstname: row.FirstName, lastname: row.LastName});

// create relationships between person and group
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/lrnzhil/workshop/main/datasets/persons.csv' AS row
FIELDTERMINATOR ';'
MATCH (p:Person {personid: row.NodeId})
MATCH (g:Group {groupid: row.Group})
MERGE (p)-[:PART_OF]->(g);

// create relationships between person and group
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/lrnzhil/workshop/main/datasets/person_relationships.csv' AS row
FIELDTERMINATOR ';'
MATCH (p1:Person {personid: row.NodeId1}), (p2:Person {personid: row.NodeId2})                       
MERGE (p1)-[:KNOWS]->(p2)
MERGE (p2)-[:KNOWS]->(p1);