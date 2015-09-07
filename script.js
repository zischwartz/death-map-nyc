// Generated by CoffeeScript 1.9.2
var IconFactory, death_icons, goto_me, map, marker_opacity, markers, oReq, reqListener, start, toner_layer, url;

goto_me = function() {
  if ("geolocation" in navigator) {
    return navigator.geolocation.getCurrentPosition(function(position) {
      console.log(position);
      return map.setView([position.coords.latitude, position.coords.longitude]);
    });
  } else {
    return alert("Geolocation not supported by your browser");
  }
};

IconFactory = (function() {
  function IconFactory(types) {
    this.types = types;
  }

  IconFactory.prototype.make = function(type) {
    var an_icon, key, obj, options, seed;
    obj = this.types[type];
    options = new obj.constructor();
    seed = Math.random();
    for (key in obj) {
      if (typeof obj[key] === "function") {
        options[key] = obj[key](seed);
      } else {
        options[key] = obj[key];
      }
    }
    an_icon = L.icon(options);
    return an_icon;
  };

  return IconFactory;

})();

death_icons = new IconFactory({
  medium_skull: {
    iconSize: [80, 106],
    iconAnchor: [40, 106],
    iconUrl: 'img/medium/skull.png'
  },
  medium_glock_skull: {
    iconSize: [80, 106],
    iconAnchor: [40, 106],
    iconUrl: 'img/medium/skull.png',
    shadowSize: [108, 84],
    shadowAnchor: function(seed) {
      var n;
      n = Math.floor(seed * 6);
      if (n <= 2) {
        return [140, 100 * seed + 60];
      } else {
        return [-40, 100 * seed + 60];
      }
    },
    shadowUrl: function(seed) {
      var options;
      options = ["img/medium/glock.png", "img/medium/glock_rot1.png", "img/medium/glock_rot2.png", "img/medium/glock_reverse.png", "img/medium/glock_rot1_reverse.png", "img/medium/glock_rot2_reverse.png"];
      return options[Math.floor(seed * options.length)];
    }
  },
  small_skull: {
    iconSize: [80 / 2, 106 / 2],
    iconAnchor: [40 / 2, 106 / 2],
    iconUrl: 'img/medium/skull.png'
  },
  small_glock_skull: {
    iconSize: [80 / 2, 106 / 2],
    iconAnchor: [40 / 2, 106 / 2],
    iconUrl: 'img/medium/skull.png',
    shadowSize: [108 / 2, 84 / 2],
    shadowAnchor: function(seed) {
      var n;
      n = Math.floor(seed * 6);
      if (n <= 2) {
        return [140 / 2, 100 / 2 * seed + 60 / 2];
      } else {
        return [-40 / 2, 100 / 2 * seed + 60 / 2];
      }
    },
    shadowUrl: function(seed) {
      var options;
      options = ["img/small/glock.png", "img/small/glock_rot1.png", "img/small/glock_rot2.png", "img/small/glock_reverse.png", "img/medium/glock_rot1_reverse.png", "img/medium/glock_rot2_reverse.png"];
      return options[Math.floor(seed * options.length)];
    }
  },
  small_skull_jitter: {
    iconSize: function(s) {
      return [80 / 2, 106 / 2];
    },
    iconAnchor: function(s) {
      return [Math.random() * 20 + 40 / 2, Math.random() * 20 + 106 / 2];
    },
    iconUrl: 'img/medium/skull.png'
  },
  small_glock_skull_jitter: {
    iconSize: function(s) {
      return [80 / 2, 106 / 2];
    },
    iconAnchor: function(s) {
      return [Math.random() * 20 + 40 / 2, Math.random() * 20 + 106 / 2];
    },
    iconUrl: 'img/medium/skull.png',
    shadowSize: [108 / 2, 84 / 2],
    shadowAnchor: function(seed) {
      var n;
      n = Math.floor(seed * 6);
      if (n <= 2) {
        return [140 / 2, 100 / 2 * Math.random() + 60 / 2];
      } else {
        return [-10, 100 / 2 * Math.random() + 60 / 2];
      }
    },
    shadowUrl: function(seed) {
      var options;
      options = ["img/small/glock.png", "img/small/glock_rot1.png", "img/small/glock_rot2.png", "img/small/glock_reverse.png", "img/medium/glock_rot1_reverse.png", "img/medium/glock_rot2_reverse.png"];
      return options[Math.floor(seed * options.length)];
    }
  }
});

start = [40.6294862, -74.022639];

toner_layer = new L.StamenTileLayer("toner-lite", {
  attribution: "Map tiles by <a href=\"http://stamen.com\">Stamen Design</a>, under <a href=\"http://creativecommons.org/licenses/by/3.0\">CC BY 3.0</a>. Data by <a href=\"http://openstreetmap.org\">OpenStreetMap</a>, under <a href=\"http://www.openstreetmap.org/copyright\">ODbL</a>."
});

map = new L.Map("map", {
  center: new L.LatLng(start[0], start[1]),
  zoom: 13,
  layers: [toner_layer]
});

map.on('zoomend', function() {
  var currentZoom;
  currentZoom = map.getZoom();
  return console.log(currentZoom);
});

markers = [];

marker_opacity = 0.4;

reqListener = function() {
  var data, i, j, len, results, x;
  data = JSON.parse(this.responseText);
  results = [];
  for (i = j = 0, len = data.length; j < len; i = ++j) {
    x = data[i];
    results.push(markers.push(L.marker([x.lat, x.long], {
      icon: death_icons.make("small_skull_jitter"),
      clickable: false,
      opacity: marker_opacity
    }).addTo(map)));
  }
  return results;
};

url = "motor_related_deaths.json";

oReq = new XMLHttpRequest();

oReq.addEventListener('load', reqListener);

oReq.open("get", url, true);

oReq.send();

reqListener = function() {
  var data, i, j, len, results, x;
  data = JSON.parse(this.responseText);
  results = [];
  for (i = j = 0, len = data.length; j < len; i = ++j) {
    x = data[i];
    results.push(markers.push(L.marker([x.latitude, x.longitude], {
      icon: death_icons.make("small_glock_skull_jitter"),
      riseOnHover: true,
      clickable: false,
      opacity: marker_opacity
    }).addTo(map)));
  }
  return results;
};

url = "murders.json";

oReq = new XMLHttpRequest();

oReq.addEventListener('load', reqListener);

oReq.open("get", url, true);

oReq.send();

//# sourceMappingURL=script.js.map
