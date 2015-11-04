lucifR.newQuery <-
function(qp, query, fields=qp$fields) {
  
  # Use the query parser object from lucifR.queryParser
  parser = qp$parser;
  
  # Use the analyzer passed to lucifR.queryParser
  an = qp$an;
  query = parser$parse(.jarray(query), .jarray(fields), an);
  return(query);
}
