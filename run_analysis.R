##start with empty workspace
rm(list=ls(all=TRUE))

##load current dir
currdir<-getwd()

##load files
url1<-paste(currdir,"/activity_labels.txt",sep="")
url2<-paste(currdir,"/features.txt",sep="")
#test data files
url3<-paste(currdir,"/test/X_test.txt",sep="")
url4<-paste(currdir,"/test/y_test.txt",sep="")
url5<-paste(currdir,"/test/subject_test.txt",sep="")
#training set files
url6<-paste(currdir,"/train/X_train.txt",sep="")
url7<-paste(currdir,"/train/y_train.txt",sep="")
url8<-paste(currdir,"/train/subject_train.txt",sep="")


activity<-read.table(url1)
features<-read.table(url2)
X_test<-read.table(url3)
y_test<-read.table(url4)
sub_test<-read.table(url5)
X_train<-read.table(url6)
y_train<-read.table(url7)
sub_train<-read.table(url8)


#merge train data together
train<-cbind(X_train,sub_train,y_train)

#merge test data 
test<-cbind(X_test,sub_test,y_test)

#merge train and test
mergedata<-rbind(train,test)


#naming the data frame
varnames<-c(as.character(features$V2),"Subject","Activity")
names(mergedata)<-varnames


#getting means of measurements of data set
mergedata<-mergedata[grep("mean|std|Subject|Activity",names(mergedata))]

#replacing activity names
mergedata$Activity[mergedata$Activity==1]<- "Walking"
mergedata$Activity[mergedata$Activity==2]<- "Walking_Upstairs"
mergedata$Activity[mergedata$Activity==3]<- "Walking_Downstairs"
mergedata$Activity[mergedata$Activity==4]<- "Sitting"
mergedata$Activity[mergedata$Activity==5]<- "Standing"
mergedata$Activity[mergedata$Activity==6]<- "Laying"

#creating tidy data table
tidyData <- aggregate(.~ Subject + Activity,mergedata,mean,na.rm=T)
write.table(tidyData,"tidyData.txt",row.name=FALSE)
