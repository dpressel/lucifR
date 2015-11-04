lucifR.newSearcher <-
function(dirname) {
  FSDirectory = J("org/apache/lucene/store/FSDirectory");
  DirectoryReader = J("org/apache/lucene/index/DirectoryReader");
  IndexReader = J("org/apache/lucene/index/IndexReader");
  IndexSearcher = J("org/apache/lucene/search/IndexSearcher");
  
  jfs = .jnew("java/io/File", dirname)
  jpath = jfs$toPath()
  jdir = FSDirectory$open(jpath);
  reader = DirectoryReader$open(jdir);
  searcher = new(IndexSearcher, reader);
  return(searcher);
}
