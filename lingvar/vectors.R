txt = read.table("mock.txt", header=FALSE, stringsAsFactors=FALSE, fill=TRUE)
res = list()
for (i in 1:nrow(txt)) {
  s = txt[i, ]
  s = s[s!= ""]
  s2 = data.frame(
       Cues = rep(" ", length(s)),
       Outcomes = rep(" ", length(s)),
       Frequency = rep(1, length(s)), stringsAsFactors="FALSE")
  for (j in 1:length(s)) {
    s2[j,"Cues"] = paste(s[-j], sep="_", collapse="_")
    s2[j,"Outcomes"] = s[j]
  }
  res[[i]] = s2
}
res =do.call(rbind, res)
