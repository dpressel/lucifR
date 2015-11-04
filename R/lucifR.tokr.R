lucifR.tokr <-
function(an, str) {
  CharTermAttribute = J("org/apache/lucene/analysis/tokenattributes/CharTermAttribute");
  ts = an$tokenStream("dontcare", str);

  # This is draconian, Lucene has a horrible API
  charTermAttribute = ts$addAttribute(CharTermAttribute$class);
  
  ts$reset();
  toks = c();
  
  # Traverse tokens
  while (ts$incrementToken()) {
    
    # And get the values out and put them in a list
    rstr = as.character(charTermAttribute$toString())
    toks = c(toks, rstr);
  }
  
  ts$end();
  ts$close();
  return(toks)
}
