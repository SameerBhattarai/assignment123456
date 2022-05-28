#prt 1
unzip("getdata-projectfiles-UCI HAR Dataset.zip")
XTest<- read.table("UCI HAR Dataset/test/X_test.txt")
YTest<- read.table("UCI HAR Dataset/test/Y_test.txt")
SubjectTest <-read.table("UCI HAR Dataset/test/subject_test.txt")
XTrain<- read.table("UCI HAR Dataset/train/X_train.txt")
YTrain<- read.table("UCI HAR Dataset/train/Y_train.txt")
SubjectTrain <-read.table("UCI HAR Dataset/train/subject_train.txt")
features<-read.table("UCI HAR Dataset/features.txt")
activity<-read.table("UCI HAR Dataset/activity_labels.txt")
X<-rbind(XTest, XTrain)
Y<-rbind(YTest, YTrain)
Subject<-rbind(SubjectTest, SubjectTrain)
#part2
index<-grep("mean\\(\\)|std\\(\\)", features[,2])
#part3            
Y[,1]<-activity[Y[,1],2]
#part4
names<-features[index,2]
names(X)<-names 
names(Subject)<-"SubjectID"
names(Y)<-"Activity"
cleandata<-cbind(Subject, Y, X)
head(cleandata[,c(1:4)])
#part5
cleandata<-data.table(cleandata)
tidydata <- cleandata[, lapply(.SD, mean), by = 'SubjectID,Activity']
write.table(tidydata, file = "Tidy.txt", row.names = FALSE)