lucifR.search <-
function(aframe, searcher, q, limit=10) {
  
  # Rjava will need this to be the base class not derived, otherwise the method wont be found
  qq = .jcast(q, new.class="org/apache/lucene/search/Query", check=TRUE)
  
  # Explicitly give the signature of this method, passing cast query and explicitly coerce limit to int
  top = .jcall(searcher, "Lorg/apache/lucene/search/TopDocs;", "search", qq, as.integer(limit))
  hits = top$scoreDocs
  
  # Initialize an empty table with same names as aframe, but also with a score
  df = read.table(text="", col.names=c(names(aframe), "score"))
  
  for (hit in hits) {
    
    doc = searcher$doc(hit$doc);
    
    # Get the row back in the frame -- we stored this in the index
    docid = as.integer(doc$get("docid"));
    
    # Get the hit score
    score = hit$score
    
    # bind the score to the aframe row, and append that into df
    df <- rbind(df, cbind(aframe[docid,], score))
  }
  return (df)
}
