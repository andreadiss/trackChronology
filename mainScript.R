### created by Andrea Dissegna [7-4-20]

searchMat = matrix(ncol = 5,nrow = 1)
colnames(searchMat) = c("search_n", "URL", "hierachical","tag", "connection")
count = 0
searcher = function(pos){
  if (length(readClipboard()) > 0) {
    n = nrow(searchMat)+1 
    URL = readClipboard()
    tag = readline("Enter tag here:")
    newrow = c(n,URL,pos,tag,NA)
    searchMat = rbind(searchMat,newrow)
    link(searchMat,n,pos,tag,URL)
  }
  else {print("The Clipboard is empty")}
}


link = function(searchMat, n, pos,tag, URL){
  if (is.na(searchMat[n-1,3]) == FALSE) {
    if (searchMat[n-1,3] == searchMat[n,3] ){
      count = count + 1
      assign("count",count, envir = .GlobalEnv)
        if (count > 0){
          link = paste(n-count,"[",searchMat[n-count,4],"]", "-->", n,"[",searchMat[n,4],"]", sep = "")
        }
    } else {link = paste(n-1,"[",searchMat[n-1,4],"]", "-->", n,"[",searchMat[n,4],"]", sep = "")
      count = 0
      assign("count",count, envir = .GlobalEnv)}
  } else {link = "NA"}
  searchMat[n-1,5] = link
  assign("searchMat",searchMat, envir = .GlobalEnv)
  return(searchMat[-1,])
}

plot = function(){
  searchDat = data.frame(searchMat)
  searchDat = searchDat[-1,]
  assign("searchDat",searchDat, envir = .GlobalEnv)
  DiagrammeR(
    paste0(
    "graph LR;", "\n",
    paste(searchDat$connection, collapse = "\n"),"\n",
    "classDef column fill:#f2f5f5, stroke:#0D3FF3, stroke-width:1px;","\n",
    "class ", paste0(1:length(searchDat$connection), collapse = ","), " column;",
    paste("click",searchDat$search_n,"\"",searchDat$URL,"\"","\"Click here\"", collapse = "\n")
    )
  )
}
