lucifR.queryParser <-
function(fields, an) {
  MultiFieldQueryParser = J("org/apache/lucene/queryparser/classic/MultiFieldQueryParser");
  parser = new(MultiFieldQueryParser, .jarray(fields), an);
  return(list(parser=parser,an=an,fields=fields));
}
