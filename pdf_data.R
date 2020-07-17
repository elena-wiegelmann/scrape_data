library(tidyverse)
library(pdftools)

# Individual doc
doc_1 <- pdftools::pdf_text("/Users/elenawiegelmann/Desktop/inputs/docs/document_1.pdf")
doc_1 <- tibble(raw_data = doc_1)

doc_1 <- separate_rows(doc_1, raw_data, sep = "\n", convert = FALSE)


mylist <- list(paste("/Users/elenawiegelmann/Desktop/inputs/docs/document_",1:198,".pdf"))
# After you have it working for one then iterate over multiple with purrr.

mylist <- sapply(mylist, paste)
mylist <- gsub(" ", "", mylist, fixed = TRUE)

get_data <- function(i){
  separate_rows(tibble(raw_data = pdftools::pdf_text(mylist[i])), raw_data, sep = "\n", convert = FALSE)
}

mydat <- map(1:198,get_data)
View(mydat)
mydat[[1]]



