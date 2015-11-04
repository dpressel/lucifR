lucifR.newAnalyzer <-
function(byName="org/apache/lucene/analysis/standard/StandardAnalyzer") {
  StandardAnalyzer = J(byName);
  analyzer = new(StandardAnalyzer);
}
