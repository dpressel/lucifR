lucifR.index <-
function(aframe, dirname, fnames=names(F), cb=NULL) {
  
  IndexWriterConfig = J("org/apache/lucene/index/IndexWriterConfig");
  IndexWriter = J("org/apache/lucene/index/IndexWriter");
  FSDirectory = J("org/apache/lucene/store/FSDirectory");
  Document = J("org/apache/lucene/document/Document");
  TextField = J("org/apache/lucene/document/TextField");
  Field = J("org/apache/lucene/document/Field");
  IntField = J("org/apache/lucene/document/IntField");
  jfs = .jnew("java/io/File", dirname)
  jpath = jfs$toPath()
  analyzer = lucifR.newAnalyzer();
  iwc = new(IndexWriterConfig, analyzer)
  iwc$setOpenMode(IndexWriterConfig$OpenMode$CREATE);
  jdir = FSDirectory$open(jpath);
  writer = new(IndexWriter, jdir, iwc);
  
  # Go through all rows in a frame indexing any requested fname (column)
  #for (i in 1:nrow(aframe)) {
  invisible(sapply(1:nrow(aframe), function(i) {
    
    # This is the main work loop for indexing
    doc = new(Document);
    
    for (name in fnames) {
      val = aframe[i,][[name]]
      tf = new(TextField, name, as.character(val), Field$Store$YES);
      doc$add(tf);
    }
    
    # Track our own docid
    sf = new(IntField, "docid", i, Field$Store$YES)
    doc$add(sf);
    writer$addDocument(doc);
    
    # print status callback if requested
    if (i %% 1000 == 0 && is.null(cb) == FALSE) {cb(i)}
    return(NULL);
  }));
  
  # Very important to close the IndexWriter
  writer$close();
}
