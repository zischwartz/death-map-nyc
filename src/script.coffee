

goto_me= ->
  if "geolocation" of navigator
    navigator.geolocation.getCurrentPosition (position)->
      console.log position
      map.setView([position.coords.latitude, position.coords.longitude])
  else alert("Geolocation not supported by your browser")

class IconFactory 
  constructor: (@types)->
    # console.log types
  make: (type) ->
    obj = @types[type]
    options = new obj.constructor()
    seed = Math.random()
    for key of obj
        if typeof obj[key] is "function"
          options[key] = obj[key](seed)
        else
          options[key] = obj[key]

    an_icon = L.icon options
    return an_icon




# use it
death_icons = new IconFactory
  medium_skull:
    iconSize: [80, 106]
    iconAnchor:   [40, 106]
    iconUrl: 'img/medium/skull.png'
  medium_glock_skull:
    iconSize: [80, 106]
    iconAnchor:   [40, 106]
    iconUrl: 'img/medium/skull.png'
    shadowSize:[108, 84]
    shadowAnchor: (seed)->
      n = Math.floor(seed * 6) # options.length below is 6
      if n <= 2
        [140, 100*seed+60]
      else 
        [-40, 100*seed+60]
    shadowUrl: (seed)->
      options = ["img/medium/glock.png", "img/medium/glock_rot1.png", "img/medium/glock_rot2.png", "img/medium/glock_reverse.png", "img/medium/glock_rot1_reverse.png", "img/medium/glock_rot2_reverse.png",]
      options[ Math.floor(seed * options.length) ]

  small_skull:
    iconSize: [80/2, 106/2]
    iconAnchor:   [40/2, 106/2]
    iconUrl: 'img/medium/skull.png'
  small_glock_skull:
    iconSize: [80/2, 106/2]
    iconAnchor:   [40/2, 106/2]
    iconUrl: 'img/medium/skull.png'
    shadowSize:[108/2, 84/2]
    shadowAnchor: (seed)->
      n = Math.floor(seed * 6) # options.length below is 6
      if n <= 2
        [140/2, 100/2*seed+60/2]
      else 
        [-40/2, 100/2*seed+60/2]
    shadowUrl: (seed)->
      options = ["img/small/glock.png", "img/small/glock_rot1.png", "img/small/glock_rot2.png", "img/small/glock_reverse.png", "img/medium/glock_rot1_reverse.png", "img/medium/glock_rot2_reverse.png",]
      options[ Math.floor(seed * options.length) ]


  small_skull_jitter:
    iconSize: (s)->[80/2, 106/2]
    iconAnchor: (s)->  [Math.random()*20+40/2, Math.random()*20+106/2]
    iconUrl: 'img/medium/skull.png'
  small_glock_skull_jitter:
    iconSize: (s)->[80/2, 106/2]
    iconAnchor:  (s)-> [Math.random()*20+40/2, Math.random()*20+106/2]
    iconUrl: 'img/medium/skull.png'
    shadowSize:[108/2, 84/2]
    shadowAnchor: (seed)->
      n = Math.floor(seed * 6) # options.length below is 6
      if n <= 2
        [140/2, 100/2*Math.random()+60/2]
      else 
        [-10, 100/2*Math.random()+60/2]
    shadowUrl: (seed)->
      options = ["img/small/glock.png", "img/small/glock_rot1.png", "img/small/glock_rot2.png", "img/small/glock_reverse.png", "img/medium/glock_rot1_reverse.png", "img/medium/glock_rot2_reverse.png",]
      options[ Math.floor(seed * options.length) ]


  tiny_skull_jitter:
    iconSize: (s)->[80/4, 106/4]
    iconAnchor: (s)->  [Math.random()*20+40/4, Math.random()*20+106/4]
    iconUrl: 'img/medium/skull.png'
  tiny_glock_skull_jitter:
    iconSize: (s)->[80/4, 106/4]
    iconAnchor:  (s)-> [Math.random()*20+40/4, Math.random()*20+106/4]
    iconUrl: 'img/medium/skull.png'
    shadowSize:[108/4, 84/4]
    shadowAnchor: (seed)->
      n = Math.floor(seed * 6) # options.length below is 6
      if n <= 2
        [200/4, 100/4*Math.random()+80/4]
      else 
        # glocks on the right, that point left
        [-5, 100/4*Math.random()+80/4]
    shadowUrl: (seed)->
      options = ["img/tiny/glock.png", "img/tiny/glock_rot1.png", "img/tiny/glock_rot2.png", "img/tiny/glock_reverse.png", "img/medium/glock_rot1_reverse.png", "img/medium/glock_rot2_reverse.png",]
      options[ Math.floor(seed * options.length) ]


start = [40.6294862,-74.022639]

toner_layer = new L.StamenTileLayer "toner-lite", 
  attribution: """Map tiles by <a href="http://stamen.com">Stamen Design</a>, under <a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a>. Data by <a href="http://openstreetmap.org">OpenStreetMap</a>, under <a href="http://www.openstreetmap.org/copyright">ODbL</a>."""

# watercolor_layer = new L.StamenTileLayer "watercolor", 
#   attribution: """Map tiles by <a href="http://stamen.com">Stamen Design</a>, under <a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a>. Data by <a href="http://openstreetmap.org">OpenStreetMap</a>, under <a href="http://creativecommons.org/licenses/by-sa/3.0">CC BY SA</a>."""


map = new L.Map "map", 
  center: new L.LatLng(start[0], start[1])
  zoom: 13
  layers: [toner_layer] #watercolor_layer
# map.addLayer(layer)

toner_layer.setOpacity(0.5)

map.on 'zoomend', ->
  currentZoom = map.getZoom()
  console.log currentZoom
  # smaller numbers are zoomed further out
  
  # TODO
  # one for zoom of 11

  #codify this, spend 15m making a tool for different states

  # if currentZoom <= 12
  #   for marker in markers
  #     marker.setIcon tiny_skull
  #     marker.setOpacity 0.5

  # if currentZoom > 12
  #   console.log 'change'
  #   for marker in markers
  #     marker.setIcon small_skull
  #     marker.setOpacity 0.7



# todo, generalize size, have it adjust on zoom
# also ask for location

# OR try it this way, maybe use two different actual sizes to keep it relatively performant
# http://jsfiddle.net/paulovieira/vNLaP/
# https://groups.google.com/forum/#!topic/leaflet-js/9ouCSvTIU3c


markers = []

# marker_opacity = 0.4
marker_opacity = 1


reqListener =()->
  data = JSON.parse this.responseText
  for x, i in data
    # make the markers, add them to map
    markers.push L.marker([x.lat, x.long], {icon: death_icons.make("tiny_skull_jitter"), clickable: false, opacity: marker_opacity}).addTo(map)


url = "motor_related_deaths.json"

oReq = new XMLHttpRequest()
oReq.addEventListener('load', reqListener)
oReq.open("get", url, true)
oReq.send()

# # SAME AS ABOVE
# # but with glock_skull, and longitude, lat

reqListener =()->
  data = JSON.parse this.responseText
  for x, i in data
    # make the markers, add them to map
    # markers.push L.marker([x.latitude, x.longitude], {icon: glock_skull, clickable: false, opacity: 0.7}).addTo(map);
    markers.push L.marker([x.latitude, x.longitude], {icon: death_icons.make("tiny_glock_skull_jitter"), riseOnHover:true, clickable: false, opacity: marker_opacity}).addTo(map)


url = "murders.json"

oReq = new XMLHttpRequest()
oReq.addEventListener('load', reqListener)
oReq.open("get", url, true)
oReq.send()


# var myMarker = new L.CircleMarker([10,10], { /* Options */ });

# map.on('zoomend', function() {
#   var currentZoom = map.getZoom();
#   myMarker.setRadius(currentZoom);
# });


# setIcon



