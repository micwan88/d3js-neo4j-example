call apoc.load.xml("file:import/ctm.xml", "/DEFTABLE/SMART_FOLDER") yield value as row
CREATE (n:Folder {name: row.FOLDER_NAME, maxwait: row.MAXWAIT, orderMethod: row.FOLDER_ORDER_METHOD});

call apoc.load.xml("file:import/ctm.xml", "/DEFTABLE/SMART_FOLDER/JOB") yield value as row
CREATE (n:Job 
{
name: row.JOBNAME,
description: row.DESCRIPTION, 
runas: row.RUN_AS, 
taskType: row.TASKTYPE,
cyclic: row.CYCLIC, 
confirm: row.CONFIRM,
node: row.NODEID,
cmd: row.CMDLINE, maxwait: row.MAXWAIT,
interval: row.INTERVAL,

dayscal: row.DAYSCAL,
weekdays: row.WEEKDAYS,
days: row.DAYS,
timeFrom: row.TIMEFROM,
timeTo: row.TIMETO,
daysAndOR: row.DAYS_AND_OR,
months: row.JAN + row.FEB + row.MAR + row.APR + row.MAY + row.JUN + row.JUL + row.AUG + row.SEP + row.OCT + row.NOV + row.DEC,

latesub: null,
latetime: null,
parent: row.PARENT_FOLDER
});

Match (n:Folder)
Match (j:Job {parent: n.name})
CREATE (j)<-[:PARENT]-(n);

call apoc.load.xml("file:import/ctm.xml", "/DEFTABLE/SMART_FOLDER/JOB/INCOND | /DEFTABLE/SMART_FOLDER/JOB/OUTCOND") yield value as row
MERGE (n:Condition
{
name: row.NAME
});

call apoc.load.xml("file:import/ctm.xml", "/DEFTABLE/SMART_FOLDER/JOB[SHOUT]") yield value as row
unwind [x IN row._children WHERE x._type IN ['SHOUT'] AND x.WHEN='LATESUB'] as shout
match (j:Job {name: row.JOBNAME})
SET j.latesub = shout.TIME;

call apoc.load.xml("file:import/ctm.xml", "/DEFTABLE/SMART_FOLDER/JOB[SHOUT]") yield value as row
unwind [x IN row._children WHERE x._type IN ['SHOUT'] AND x.WHEN='LATETIME'] as shout
match (j:Job {name: row.JOBNAME})
SET j.latetime = shout.TIME;

call apoc.load.xml("file:import/ctm.xml", "/DEFTABLE/SMART_FOLDER/JOB[OUTCOND]") yield value as row
unwind [x IN row._children WHERE x._type IN ['OUTCOND'] AND x.SIGN='+'] as con
match (j:Job {name: row.JOBNAME})
match (n:Condition {name: con.NAME})
CREATE (j)-[:OUT_ADD {sign: con.SIGN}]->(n);

call apoc.load.xml("file:import/ctm.xml", "/DEFTABLE/SMART_FOLDER/JOB[OUTCOND]") yield value as row
unwind [x IN row._children WHERE x._type IN ['OUTCOND'] AND x.SIGN='-'] as con
match (j:Job {name: row.JOBNAME})
match (n:Condition {name: con.NAME})
CREATE (j)-[:OUT_SUB {sign: con.SIGN}]->(n);

call apoc.load.xml("file:import/ctm.xml", "/DEFTABLE/SMART_FOLDER/JOB[ON/DOCOND]") yield value as row
unwind [x IN row._children WHERE x._type IN ['ON']] as onst
unwind [y IN onst._children WHERE y._type IN ['DOCOND'] AND y.SIGN='+'] as con
match (j:Job {name: row.JOBNAME})
match (n:Condition {name: con.NAME})
CREATE (j)-[:OUT_ADD {sign: con.SIGN, code: onst.CODE}]->(n);

call apoc.load.xml("file:import/ctm.xml", "/DEFTABLE/SMART_FOLDER/JOB[ON/DOCOND]") yield value as row
unwind [x IN row._children WHERE x._type IN ['ON']] as onst
unwind [y IN onst._children WHERE y._type IN ['DOCOND'] AND y.SIGN='-'] as con
match (j:Job {name: row.JOBNAME})
match (n:Condition {name: con.NAME})
CREATE (j)-[:OUT_SUB {sign: con.SIGN, code: onst.CODE}]->(n);

call apoc.load.xml("file:import/ctm.xml", "/DEFTABLE/SMART_FOLDER/JOB[INCOND]") yield value as row
unwind [x IN row._children WHERE x._type IN ['INCOND'] AND x.AND_OR='A'] as con
match (j:Job {name: row.JOBNAME})
match (n:Condition {name: con.NAME})
CREATE (j)<-[:IN_AND {and_or: con.AND_OR}]-(n);

call apoc.load.xml("file:import/ctm.xml", "/DEFTABLE/SMART_FOLDER/JOB[INCOND]") yield value as row
unwind [x IN row._children WHERE x._type IN ['INCOND'] AND x.AND_OR='O'] as con
match (j:Job {name: row.JOBNAME})
match (n:Condition {name: con.NAME})
CREATE (j)<-[:IN_OR {and_or: con.AND_OR}]-(n);