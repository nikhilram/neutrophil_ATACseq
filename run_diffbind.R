library(DiffBind)


bgp <- dba(sampleSheet="BGP-CL.csv")
bgp <- dba.count(bgp, bParallel = TRUE)
bgp <- dba.contrast(bgp, minMembers=4)
bgp <- dba.analyze(bgp, bParallel = TRUE)
dba.plotPCA(bgp)
dba.plotVolcano(bgp, fold=log2(1))
dba.plotVolcano(bgp, fold=log2(1), bUsePval = 0.05)
bgp.DB <- dba.report(bgp, th=0.05, bUsePval=TRUE, fold = 1, bCounts=TRUE,DataType=DBA_DATA_FRAME)
write.table(bgp.DB, "BGP-de.bed", quote=FALSE, sep="\t", row.names=FALSE, col.names=FALSE)
