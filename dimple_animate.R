install_github("XML2R", "cpsievert")
install_github("pitchRx", "cpsievert")

require(pitchRx)
data(pitches)
#code from animateFX https://github.com/cpsievert/pitchRx/blob/master/R/animateFX.R
interval = 0.01
idx <- c("x0", "y0", "z0", "vx0", "vy0", "vz0", "ax", "ay", "az")
if (!all(idx %in% names(data))) warning("You must have the following variables in your dataset to animate pitch locations: 'x0', 'y0', 'z0', 'vx0', 'vy0', 'vz0', 'ax', 'ay', 'az'")
for (i in idx) data[,i] <- as.numeric(data[,i]) #Coerce the pitchFX parameters to numerics
complete <- pitches[complete.cases(pitches[,idx]),]
reordered <- complete
parameters <- reordered[, names(reordered) %in% idx]
snapshots <- getSnapshots(parameters, interval)
other <- reordered[, !(names(reordered) %in% idx)] #Keep 'other' variables for faceting/coloring
N <- dim(snapshots)[2]
 
i = 1
frame <- data.frame(i,snapshots[,i,],other)

for (i in 2:(N-1)) {
  tempframe <- data.frame(i,snapshots[,i,],other)
  frame <- rbind(frame, tempframe )
}
names(frame) <- c("n", "x", "y", "z",names(other))



require(rCharts)
d1 <- dPlot(
  y~x,
  groups = c("pitch_type"),
  data = frame[,c(1:4,30)],
  type = "bubble"
)
d1$set(storyboard = "n")
d1$xAxis(type = "addMeasureAxis")
d1
