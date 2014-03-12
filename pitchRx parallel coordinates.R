require(rCharts)
require(pitchRx)
require(dplyr)

data(pitches)

pitchPar <- rCharts$new()
pitchPar$setLib(
  system.file("parcoords", package = "rCharts") #make sure parcoords lowercase
)
pitchPar$set(
  padding = list(top = 24, left = 50, bottom = 12, right = 50),
  height = "400",
  width = "800"
)
pitchPar$set(
  data = toJSONArray(
    as.data.frame(select( pitches, type, pitch_type, start_speed, end_speed, break_angle, spin_rate, x, y, pz)),
    json = F
  ),
  colorby = "end_speed",
  range = fivenum( select( pitches, end_speed)[,1] ),
  colors = RColorBrewer::brewer.pal(n=5,"RdYlBu")
)
pitchPar$setTemplate(
  #chartDiv = "<{{container}} id = '{{ chartId }}' class = 'rChart parcoords'></{{ container}}>"
  afterScript = "<script></script>" 
)
pitchPar

pitchPar$save("pitchRx_parCoords.html",cdn=T)
