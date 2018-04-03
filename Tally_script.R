library("xlsx")

filepath <- "C:/Users/Derek/Google Drive/OSU - PhD/TA - SUS 350/Winter 2018/Roadmap Eval/"

students <- read.csv("student_list.csv")

files <- list.files(path = paste0(filepath))
forms <- files[grepl("xlsx",files)]

tally <- NULL

for(i in 1:length(forms))
  {
    df <- read.xlsx(paste0(filepath,forms[i]),sheetIndex=1)
    df <- df[c(1:2,13:17,19:20),]
    
    df2 <- df[3:7,1:6]
    colnames(df2) <- c("Student","G1","G2","G3","G4","INOTE")
    for(x in 2:5) {df2[,x] <- as.numeric(as.character(df2[,x]))}
    
    df2$TOTAL <- rowSums(df2[,2:5])
    df2$GRADEFROM <- df[1,2]
    df2$ONOTE <- df[9,1]
    df2$GROUP <- df[2,2]

    tally <- rbind(tally,df2)
    print(i)
  }

write.csv(tally,"Student_grades_compiled.csv")

