####——————————————————————————————ready————————————————————————————————————####
rm(list = ls())
getwd()

####——————————————————————————————read data——————————————————————————————————
X_train<-read.table('UCI HAR Dataset/train/X_train.txt')
Y_train<-read.table('UCI HAR Dataset/train/Y_train.txt')
subject_train<-read.table('UCI HAR Dataset/train/subject_train.txt')
X_test<-read.table('UCI HAR Dataset/test/X_test.txt')
Y_test<-read.table('UCI HAR Dataset/test/Y_test.txt')
subject_test<-read.table('UCI HAR Dataset/test/subject_test.txt')
features<-read.table('UCI HAR Dataset/features.txt')
activity_labels<-read.table('UCI HAR Dataset/activity_labels.txt')

####——————————————————————————————combine dataset——————————————————————————————
train<-cbind(Y_train,subject_train,X_train)
test<-cbind(Y_test,subject_test,X_test)

#————————————————————————descriptive variable names————————————————————————
names(train)<-c('label','subject',features[,2])
names(test)<-c('label','subject',features[,2])

#——————————————————————————————merge 2 datasets———————————————————————————————
mergedata<-rbind(train,test)

#————————————————————————descriptive activity names———————————————————————————
activity_labels[,2]
library(dplyr)
mergedata$activity<-activity_labels[mergedata$label,2]
mergedata$label<-mergedata$activity
names(mergedata)
data<-mergedata[,1:563]

#————————smaller dataset with only the mean and std variables——————————————
names(data)
smallerdata<-data[,c(1,2,grep("([Mm]ean)|-std", colnames(data)))]

#————————average of each variable for each activity / subject——————————————
tidy<-aggregate(. ~subject + label,smallerdata,mean)

write.table(tidy, file = "tidy.txt",row.names = FALSE)


