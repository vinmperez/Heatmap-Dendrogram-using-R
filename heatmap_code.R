###############This is a script to make a heatmap using R################

read.csv("oleic_acid_heatmap.csv")        #Check your file
oa<-read.csv("oleic_acid_heatmap.csv")    #Objectify the file
row.names(oa) <- oa$phospholipid_species  #Start to build a name object

########alternatively, this is useful too, but especially not required here###################
row1<-oa[,1]
row.names(oa)<-make.names(row1, unique=TRUE)
fix(oa)

########Lets build the Matrix, Neo############################
oa <- oa[,2:6]
oa_matrix <- data.matrix(oa)		          #transforms data into a matrix

pdf("heatmap.pdf")                        #Finally, let there be heatmap
oa_heatmap <- heatmap(oa_matrix, Rowv=NA, Colv=NA, col = heat.colors(256), scale="column", margins=c(5,10))
dev.off()                                 #Its not pretty but you get the idea

#########alternatively, this will create a nicer heatmap with ggplot (you'll have to creat "log_smpl"##################

library("gplots")
smpl_heatmap<-heatmap.2(log_smpl, Rowv=NA, Colv=NA,
                        col=heat.colors(180), scale_x_continuous(breaks=NA),
                        margins=c(5,10), tracecol=NA)

#########done############################

#########the below scripts creates 4 separate heatmaps in the directory########################

bitmap(file="heatmap_BW_T.tiff", height=3,
       width=9, units="in", res=600)
smpl_heatmap<-heatmap.2(log_smpl, Rowv=NA, Colv=NA,
                        col=gray(0:100/100), scale_x_continuous(breaks=NA),
                        margins=c(5,10))
dev.off()


bitmap(file="heatmap_BW.tiff", height=4,
       width=4, units="in", res=600)
smpl_heatmap<-heatmap.2(log_smpl, Rowv=NA, Colv=NA,
                        col=gray(0:100/100), scale_x_continuous(breaks=NA),
                        margins=c(5,10), tracecol=NA)
dev.off()

bitmap(file="heatmap_color_T.tiff", height=3,
       width=9, units="in", res=600)
smpl_heatmap<-heatmap.2(log_smpl, Rowv=NA, Colv=NA,
                        col=colorRampPalette(c('blue','yellow','red'))(100),
                        scale_x_continuous(breaks=NA), margins=c(5,10))
dev.off()

bitmap(file="heatmap_color.tiff", height=4,
       width=4, units="in", res=600)
smpl_heatmap<-heatmap.2(log_smpl, Rowv=NA, Colv=NA,
                        col=colorRampPalette(c('blue','yellow','red'))(100),
                        scale_x_continuous(breaks=NA), margins=c(5,10),
                        tracecol=NA)
dev.off()




