library(devtools)
#install_github("ramnathv/rCharts")
#install_github("cpsievert/pitchRx")
library(rCharts)
library(pitchRx)


data(pitches, package="pitchRx")
interval = 0.01
idx <- c("x0", "y0", "z0", "vx0", "vy0", "vz0", "ax", "ay", "az")
lidx <- names(pitches) %in% idx 
snapshots <- getSnapshots(pitches[lidx], interval)
other <- pitches[!lidx] #Keep 'other' variables for faceting/coloring
N <- dim(snapshots)[2]
 
i = 1
frame <- data.frame(i, snapshots[, i, ], other)
for (i in 2:(N-1)) {
  tempframe <- data.frame(i, snapshots[, i, ], other)
  frame <- rbind(frame, tempframe)
}
names(frame) <- c("n", "x", "y", "z", names(other))

d1 <- dPlot(
  y~x,
  groups = c("pitch_type"),
  data = frame[which(frame$n %in% 1:4),c(1:4,30)],
  type = "bubble"
)
d1$set(storyboard = "n")
d1$xAxis(type = "addMeasureAxis")
d1



require(ggvis)
ggvis(
  frame[which(frame$n %in% 1:20),c(1:4,12,30,13)],
  props(
    x = ~x,
    y = ~z,
    fill = ~type,
    opacity = ~y
  ),
  layer_point()
)