<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title></title>
</head>
<body>

<script>

    // add some test markers, cycles, polygons

    var circle = L.circle([0, 0], 0.01*maxWorldMeterReal, {
    color: 'red',
    fillColor: 'red',
    fillOpacity: 0.7
    }).addTo(map);
    var polygon = L.polygon([ [20, 30], [-50, 60], [70, 80] ], {
    color: 'blue',
    fillColor: 'blue',
    fillOpacity: 0.7
    }).addTo(map);
    // add some mouseclick info
    marker.bindPopup("<b>Hello world!</b><br>I am a popup.").openPopup();
    circle.bindPopup("I am a circle.");
    polygon.bindPopup("I am a polygon.");



    // add some test playertrails
    var playerTrail = L.polyline([
    [ -9.739583333, -101.484375 ],
    [ -9.739583333, -94.921875 ],
    [ -9.739583333, -94.921875 ],
    [ -9.62890625,  -94.453125 ],
    [ -9.850260417, -94.21875 ],
    [ -8.30078125,  -98.203125 ],
    [ -8.079427083, -98.90625 ],
    [ -6.751302083, -104.0625 ],
    [ -7.194010417, -109.921875 ],
    [ -6.97265625,  -114.609375 ],
    [ -6.640625,    -120.234375 ],
    [ -6.529947917, -120.9375 ],
    [ -4.537760417, -120.9375 ],
    [  1.328125,    -118.359375 ],
    [  3.850260417, -105.21875 ]
    ], {
    weight: 1,
    color: 'yellow'
    }
    ).addTo(map);
    playerTrail.bindPopup("Here is the trail.").openPopup();

    // add some test players
    var player = L.marker([3.850260417, -105.21875]).addTo(map);
    player.bindPopup("<b>Hello world!</b><br>I am a player.").openPopup();

    // add some test objects
    var obj1 = L.marker(map.options.crs.pointToLatLng(new L.Point(1198/maxWorldPxIngame,1-1220/maxWorldPxIngame))).addTo(map);
    var obj2 = L.marker(map.options.crs.pointToLatLng(new L.Point(882/maxWorldPxIngame,1-620/maxWorldPxIngame))).addTo(map);
    var obj4 = L.marker(map.options.crs.pointToLatLng(new L.Point(901/maxWorldPxIngame,1-575/maxWorldPxIngame))).addTo(map);
    obj1.bindPopup("obj1").openPopup();
    obj2.bindPopup("obj2").openPopup();
    obj4.bindPopup("obj4").openPopup();

    var polygon = L.polygon([ [20, 30] ], {
    color: 'orange',
    fillColor: 'blue',
    fillOpacity: 0.7,
    weight: Math.exp(map.getZoom()*2,5)
    }).addTo(map);
    polygon.bindPopup("point").openPopup();


    var polyList = [];
    var xxx;
    for (xxx = 0; xxx <= 100; xxx += 1) {
    var yyy;
    for (yyy = 0; yyy <= 100; yyy += 1) {
    var poly = [];
    poly.push(map.options.crs.pointToLatLng(new L.Point(xxx/100,yyy/100)));
    polyList.push(poly);
    }
    }
    var multipolygon2 = L.multiPolygon(polyList, {
    color: 'orange',
    fillColor: 'blue',
    fillOpacity: 0.7,
    weight: Math.exp(map.getZoom()*2,5)
    }).addTo(map);


    /*
     else if (result.map_data[i].Source == 'gp') {
     var pointLatLon = newLTPoint(result.map_data[i].PosX, result.map_data[i].PosY);
     var pointRoad = L.polygon([pointLatLon], {
     color: 'darkgrey',
     fillColor: 'darkgrey',
     fillOpacity: 0.5,
     weight: 4
     });
     layerRoads.addLayer(pointRoad);
     }
     */

function heightLayerSettings() {
    return {
        radius: 3,
        blur: 1,
        gradient: {
            0.0: 'rgb(153, 204, 255)',
            0.1: 'rgb(204, 236, 255)',
            0.2: 'rgb(255, 255, 255)',
            0.3: 'rgb(146, 208, 80)',
            0.4: 'rgb(204, 255, 102)',
            0.5: 'rgb(255, 255, 153)',
            0.6: 'rgb(255, 204, 102)',
            0.7: 'rgb(255, 153, 51)',
            0.8: 'rgb(204, 102, 0)',
            0.9: 'rgb(153, 51, 0)',
            1.0: 'rgb(255, 255, 255)'
        }
    }
}

</script>

<script type="text/javascript">
var u = new SpeechSynthesisUtterance();
u.text = 'Hello World';
u.lang = 'en-US';
u.rate = 1.2;
u.onend = function(event) { alert('Finished in ' + event.elapsedTime + ' seconds.'); }
speechSynthesis.speak(u);
</script>

</body>
</html>