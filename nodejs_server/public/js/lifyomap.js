/**
 * Created by andi on 11.05.2015.
 */

$(document).ready(function() {

    function y2lat(a) { return 180/Math.PI * (2 * Math.atan(Math.exp(a*Math.PI/180)) - Math.PI/2); }
    function lat2y(a) { return 180/Math.PI * Math.log(Math.tan(Math.PI/4+a*(Math.PI/180)/2)); }

    // settings
    var mapID = 'ritterspielgeyming.de';
    //var mapID = 'kingdom of arkhaya.com';
    var mapLanguage = 'de';
    var flagFollowPlayers = 0;
    var flagPlaySounds = 1;
    var maxLonAbs = 360;
    try {
        var maxLatAbs = Math.atan((Math.sinh(Math.PI))) * 360 / Math.PI || 170; // merkator projection max ~170°
    }
    catch(e){
        var maxLatAbs = 170; // IE fallback
    };
    var maxLon = maxLonAbs / 2;
    var maxLat = maxLatAbs / 2;
    var maxWorldMeterReal = 40800000;
    var maxWorldRadiusReal = 6378137;
    var maxWorldMeterIngame = 3000;
    var maxWorldPxIngame = 1533;
    var maxWorldPxMap = 2048;
    var maxWorldPxTile = 256;

    function MapIconsCollection(iconUrl){
        return {
            iconUrl: iconUrl,
            iconSize:     [32, 37], // size of the icon
            iconAnchor:   [16, 18], // point of the icon which will correspond to marker's location
            popupAnchor:  [0, 0] // point from which the popup should open relative to the iconAnchor
        }
    }
    var iconGuildLand   = L.icon(MapIconsCollection('icons/guildland.png'));
    var iconPlayer      = L.icon(MapIconsCollection('icons/player.png'));
    var iconKeep1       = L.icon(MapIconsCollection('icons/keep1.png'));
    var iconKeep2       = L.icon(MapIconsCollection('icons/keep2.png'));
    var iconKeep3       = L.icon(MapIconsCollection('icons/keep3.png'));
    var iconKeep4       = L.icon(MapIconsCollection('icons/keep4.png'));
    var iconKeep5       = L.icon(MapIconsCollection('icons/keep4.png'));

    // define attribution info and layer settings
    var attribInfo = 'Base map &copy; <a href="http://lif-tools.com">LiF-Tools.com</a> contributors, ' +
                      '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
                      'Game data &copy; <a href="http://creativecommons.org/licenses/by-sa/2.0/">BITBOX Ltd.</a>, ' +
                      'Icons &copy; <a href="https://mapicons.mapsmarker.com">Maps Icons Collection</a>, ' +
                      'Leaflet Panel Layers &copy; <a href="http://labs.easyblog.it/stefano-cudini">Stefano Cudini</a>, ' +
                      'Leaflet.heat &copy; <a href="https://github.com/mourner">Vladimir Agafonkin</a>, ' +
                      'Leaflet.MovingMarker &copy; <a href="https://github.com/ewoken">Ewoken</a>';

    var baseLayerSettings = {
        attribution: attribInfo,
        noWrap: true
    };
    var heatLayerSettings = {
        radius: 10,
        blur: 20
    };
    function dataLayerSettings(color, radius) {
        return {
            radius: radius || 2,
            blur: 1,
            gradient: {1: color}
        }
    }
    function getKeepIcon (keepTypeID){
        switch (keepTypeID){
            case 174:     return {icon: iconKeep1}; break;
            case 175:     return {icon: iconKeep2}; break;
            case 1092:    return {icon: iconKeep3}; break;
            case 176:     return {icon: iconKeep4}; break;
            case 177:     return {icon: iconKeep5}; break;
            default: break;
        }
    }

    // define tile layers (BASE)
    var layerTilesEmpty = L.tileLayer('', baseLayerSettings);
    var layerTilesWhite = L.tileLayer('map.5.white/tile_{z}_{x}-{y}.png', baseLayerSettings);
    var layerTilesGrey = L.tileLayer('map.5.grey/tile_{z}_{x}-{y}.png', baseLayerSettings);
    var layerTilesBlack = L.tileLayer('map.5.black/tile_{z}_{x}-{y}.png', baseLayerSettings);
    var layerTiles2048 = L.tileLayer('map.5.2048/tile_{z}_{x}-{y}.png', baseLayerSettings);
    var layerTiles8192 = L.tileLayer('map.5.8192/tile_{z}_{x}-{y}.png', baseLayerSettings);

    // prepare our empty data layers (OVERLAY)
    var layerGuildLands = new L.layerGroup();
    var layerRoads = new L.heatLayer([[0,0,0]], dataLayerSettings('darkgrey'));
    var layerUnmovables = new L.heatLayer([[0,0,0]], dataLayerSettings('red'));
    var layerMovables = new L.heatLayer([[0,0,0]], dataLayerSettings('brown'));

    // nature
    var radiusHeightMap = 2;
    var layerHeight01   = new L.heatLayer([[0,0,0]], dataLayerSettings('rgb(153, 204, 255)', radiusHeightMap) );
    var layerHeight02   = new L.heatLayer([[0,0,0]], dataLayerSettings('rgb(204, 236, 255)', radiusHeightMap) );
    var layerHeight03   = new L.heatLayer([[0,0,0]], dataLayerSettings('rgb(255, 255, 255)', radiusHeightMap) );
    var layerHeight04   = new L.heatLayer([[0,0,0]], dataLayerSettings('rgb(095, 146, 039)', radiusHeightMap) );
    var layerHeight05   = new L.heatLayer([[0,0,0]], dataLayerSettings('rgb(146, 205, 080)', radiusHeightMap) );
    var layerHeight06   = new L.heatLayer([[0,0,0]], dataLayerSettings('rgb(205, 255, 102)', radiusHeightMap) );
    var layerHeight07   = new L.heatLayer([[0,0,0]], dataLayerSettings('rgb(255, 255, 153)', radiusHeightMap) );
    var layerHeight08   = new L.heatLayer([[0,0,0]], dataLayerSettings('rgb(255, 230, 125)', radiusHeightMap) );
    var layerHeight09   = new L.heatLayer([[0,0,0]], dataLayerSettings('rgb(255, 197, 103)', radiusHeightMap) );
    var layerHeight10   = new L.heatLayer([[0,0,0]], dataLayerSettings('rgb(255, 153, 051)', radiusHeightMap) );
    var layerHeight11   = new L.heatLayer([[0,0,0]], dataLayerSettings('rgb(204, 102, 000)', radiusHeightMap) );
    var layerHeight12   = new L.heatLayer([[0,0,0]], dataLayerSettings('rgb(153, 051, 000)', radiusHeightMap) );
    var layerHeight13   = new L.heatLayer([[0,0,0]], dataLayerSettings('rgb(120, 040, 000)', radiusHeightMap) );
    var layerHeight14   = new L.heatLayer([[0,0,0]], dataLayerSettings('rgb(088, 029, 000)', radiusHeightMap) );
    var layerHeight15   = new L.heatLayer([[0,0,0]], dataLayerSettings('rgb(060, 020, 000)', radiusHeightMap) );
    var layerHeight16   = new L.heatLayer([[0,0,0]], dataLayerSettings('rgb(234, 234, 234)', radiusHeightMap) );
    var layerHeight     = new L.LayerGroup([layerHeight01, layerHeight02, layerHeight03, layerHeight04, layerHeight05, layerHeight06, layerHeight07, layerHeight08,
                                            layerHeight09, layerHeight10, layerHeight11, layerHeight12, layerHeight13, layerHeight14, layerHeight15, layerHeight16]);
    var layerForestH    = new L.heatLayer([[0,0,0]], dataLayerSettings('limegreen'));
    var layerForestM    = new L.heatLayer([[0,0,0]], dataLayerSettings('yellow'));
    var layerForestS    = new L.heatLayer([[0,0,0]], dataLayerSettings('orange'));
    var layerForest     = new L.LayerGroup([layerForestH, layerForestM, layerForestS]);
    var layerSwamp      = new L.heatLayer([[0,0,0]], dataLayerSettings('saddlebrown'));
    var layerSnow       = new L.heatLayer([[0,0,0]], dataLayerSettings('snow'));

    var layerKeeps      = new L.layerGroup();
    var layerWalls1     = new L.heatLayer([[0,0,0]], dataLayerSettings('saddlebrown'));
    var layerWalls2     = new L.heatLayer([[0,0,0]], dataLayerSettings('grey'));
    var layerWalls3     = new L.heatLayer([[0,0,0]], dataLayerSettings('white'));
    var layerKeepsWalls = new L.LayerGroup([layerKeeps, layerWalls1, layerWalls2, layerWalls3]);

    var layerPlayerMarkers = new L.layerGroup();
    var layerPlayerLiveTrail = new L.layerGroup();
    var layerPlayerHistTrail = new L.layerGroup();
    var layerPlayerComplete = new L.LayerGroup([layerPlayerMarkers, layerPlayerLiveTrail, layerPlayerHistTrail]);

    // resources
    var layerClay       = new L.heatLayer([[0,0,0]], dataLayerSettings('chocolate'));
    var layerCopper     = new L.heatLayer([[0,0,0]], dataLayerSettings('peru'));
    var layerIron       = new L.heatLayer([[0,0,0]], dataLayerSettings('saddlebrown'));
    var layerIron2      = new L.heatLayer([[0,0,0]], dataLayerSettings('saddlebrown'));
    var layerSilver     = new L.heatLayer([[0,0,0]], dataLayerSettings('silver'));
    var layerGold       = new L.heatLayer([[0,0,0]], dataLayerSettings('goldenrod'));

    // prepare our empty heat map leyers (OVERLAY)
    var layerHmDeaths = new L.layerGroup();
    var layerHmFights = new L.layerGroup();
    var layerHmBuilders = new L.layerGroup();
    var layerHmMovement = new L.heatLayer([[0,0,0]], heatLayerSettings);
    var layerHmDigging = new L.heatLayer([[0,0,0]], heatLayerSettings);

    // group the layers using leaflet-panel-layers plugin
    var baseLayers = [{
        group: "Base Layers",
        layers: [
            { name: "Empty",            layer: layerTilesEmpty },
            { name: "White",            layer: layerTilesWhite },
            { name: "Gray",             layer: layerTilesGrey },
            { name: "Black",            layer: layerTilesBlack },
            { name: "Tilemap 2048",     layer: layerTiles2048 },
            { name: "Tilemap 8192",     layer: layerTiles8192 }
        ]
    }];
    var overLayers = [{
        group: "Player made",
        layers: [
            { name: "Guild Lands",      layer: layerGuildLands },
            { name: "Players",          layer: layerPlayerComplete },
            { name: "Buildings",        layer: layerUnmovables },
            { name: "Keeps Walls",      layer: layerKeepsWalls},
            { name: "Movables",         layer: layerMovables },
            { name: "Roads",            layer: layerRoads }
        ]
    },{
        group: "Nature",
        layers: [
            { name: "Forest",           layer: layerForest },
        //    { name: "Swamp",        layer: layerSwamp },
        //    { name: "Snow",         layer: layerSnow },
            { name: "Height",           layer: layerHeight }
        ]
    },{
        group: "Resources",
        layers: [
            { name: "Clay",             layer: layerClay },
            { name: "Copper",           layer: layerCopper }
        //    { name: "Iron",         layer: layerIron },
        //    { name: "Silver",       layer: layerSilver },
        //    { name: "Gold",         layer: layerGold }
        ]
    },{
        group: "Heatmaps",
        layers: [
        //    { name: "Deaths",       layer: layerHmDeaths },
        //    { name: "Fights",       layer: layerHmFights },
        //    { name: "Builders",     layer: layerHmBuilders },
            { name: "Movement",         layer: layerHmMovement },
            { name: "Digging",          layer: layerHmDigging }
        ]
    }];
    var panelLayers = new L.Control.PanelLayers(baseLayers, overLayers);



    // ----------------------------
    // create and show the map and layer control
    //
    var map = L.map('map', {
//        layers: [layerTiles8192, layerUnmovables]
        layers: [layerTilesBlack, layerGuildLands, layerPlayerComplete, layerHeight],
        minZoom: 2,
        maxZoom: 5
    }).setView([0, 0], 2);
    map.addControl(panelLayers);



    // disable dragging and grey area at zoom level 1
    var bounds = L.latLngBounds([[-maxLat, -maxLon], [maxLat, maxLon]]);
    map.setMaxBounds(bounds);
    map.on('drag', function() {
        map.panInsideBounds(bounds, { animate: false });
    });

    function zoomToLatLng(latLng){
        var cM = map.project(latLng);
        map.setView(map.unproject(cM), map.options.maxZoom, {animate: true});
    }

    // temporary debug info when clicking on map
    var clickInfo = L.popup();
    function onMapClick(e) {
        var clickPoint = map.options.crs.latLngToPoint( e.latlng);
        clickPoint.y = 1 - clickPoint.y;
        var cartPoint = clickPoint.multiplyBy(maxWorldPxIngame).round();
        var request = { time: new Date(), "filter": {PosX: cartPoint.x, PosY: cartPoint.y} };
        socket.emit('requestGeoID', request);
        socket.on('resultGeoID', function (resultGeoID) {
            clickInfo
                .setLatLng(e.latlng)
                .setContent(
                "You clicked the map at<br>" +
                "latlng = "     + e.latlng.toString() + "<br>" +
                "layerPoint = "    + e.layerPoint.toString() + "<br>" +
                "containerPoint = " + e.containerPoint.toString() + "<br>" +
                "cartPoint = " + cartPoint.toString()  + "<br>" +
                "GeoID = " + resultGeoID.GeoID  + "<br>" +
                ""
            ).openOn(map);
        });
    }
    map.on('click', onMapClick);
    map.on('popupopen', function(clickedMarker) {
        zoomToLatLng(clickedMarker.popup._latlng);
    });





    // socket connection to map server
    var socket = io.connect();

    // function for building up filter record and sending request
    window.requestMapDataFilter = function requestMapDataFilter(Source){
        socket.emit('requestMapData', {
            time: new Date(),
            "filter": {MapID: mapID, Source: Source}
        });
    };


    // function for request all map data
    // we fire several async calls over the socket to profit from parallel processing
    window.requestMapDataAll = function requestMapDataAll(){
        requestMapDataFilter('gl');
        requestMapDataFilter('c');
        requestMapDataFilter('mo');
        requestMapDataFilter('uo');
        requestMapDataFilter('uo_kw');
        requestMapDataFilter('f');
        requestMapDataFilter('gp_c');
        //requestMapDataFilter('gp_oc');
        //requestMapDataFilter('gp_og');
        //requestMapDataFilter('gp_oi');
        //requestMapDataFilter('gp_os');
        requestMapDataFilter('gp_r');
        //requestMapDataFilter('gp_sn');
        //requestMapDataFilter('gp_sw');
        // hm_d, hm_f, hm_b
        requestMapDataFilter('alt');
        requestMapDataFilter('hm_cp');
        requestMapDataFilter('hm_gp');
    };


    // correct cartesian radius on different zoom levels
    var myZoom = {
        start:  map.getZoom(),
        end: map.getZoom(),
        diff: map.getZoom()
    };
    map.on('zoomstart', function(e) {
        myZoom.start = map.getZoom();
    });
    map.on('zoomend', function(e) {
        myZoom.end = map.getZoom();
        myZoom.diff = myZoom.end - myZoom.start;
        layerGuildLands.eachLayer(function (layer) {
            try {
                layer.setRadius(layer.getRadius() * Math.pow(2, myZoom.diff));
            }
            catch(e){}
        });
    });

    // method to add a new point xy to map
    window.newLTPoint = function newLTPoint(PosX, PosY){
        var pointXY = new L.Point(PosX / maxWorldPxIngame, 1 - PosY / maxWorldPxIngame);
        var pointLatLng = map.options.crs.pointToLatLng(pointXY);
        return pointLatLng;
    };
    // method to add a new heat xy with strength in altitude to map
    // logarithmic formula gives good results in most cases because we always have lots of points with low count and only few "hot" points with high count
    // also we "move" the graph of the log on the x-axis to overweight the points with less count value
    window.newLTPointHeat = function newLTPoint(PosX, PosY, Count, MaxCount, maxStrength, origAlt){
        var pointXY = new L.Point(PosX / maxWorldPxIngame, 1 - PosY / maxWorldPxIngame);
        var pointLatLng = map.options.crs.pointToLatLng(pointXY);
        if (origAlt >= 0){
            pointLatLng.alt = origAlt;
        }
        else if (maxStrength > 0){
            pointLatLng.alt = maxStrength;
        }
        else {
            pointLatLng.alt = Math.log(Count + MaxCount / 3) / Math.log(MaxCount + MaxCount / 3);
        }
        return pointLatLng;
    };


    // add a complete heat map data array to a heat layer at once to avoid multiple calls to redraw
    window.addMapDataToHeatLayer = function addMapDataToHeatLayer(mapData, heatLayer, maxStrength){
        var maxCount = Math.max.apply(Math,mapData.map(function(row){return row.Count;}));
        var pointLatLngs = [];
        for (var i in mapData) {
            // var pointLatLng = new L.latLng();
            var pointLatLng = newLTPointHeat(mapData[i].PosX, mapData[i].PosY, mapData[i].Count, maxCount, maxStrength);
            pointLatLngs.push(pointLatLng);
        }
        heatLayer.setLatLngs(pointLatLngs);
    };

    // add a complete heat map data array to a heat layer at once to avoid multiple calls to redraw
    window.addGrdDataToHeatLayer = function addGrdDataToHeatLayer(mapData, heatLayer){
        var pointLatLngs = [];
        for (var i in mapData) {
            var pointLatLng = newLTPointHeat(mapData[i].PosX, mapData[i].PosY, 0, 0, 0, mapData[i].Grd);
            pointLatLngs.push(pointLatLng);
        }
        heatLayer.setLatLngs(pointLatLngs);
    };

    // split the alt results to our different height layers
    window.splitAltToHeightLayers = function splitAltToHeightLayers(mapData, heatLayer){
        var pointLatLngs = [];
        while(pointLatLngs.push([]) <= 16);
        for (var i in mapData){
            var pointLatLng = newLTPointHeat(mapData[i].PosX, mapData[i].PosY, 0, 0, 1);
            pointLatLngs[mapData[i].Lvl-1].push(pointLatLng);
        }
        heatLayer.eachLayer(function (layer) {
            layer.setLatLngs(pointLatLngs[layer._leaflet_id-1]);
        });
    };

    // split forest to our different hard-soft-types
    window.splitForestToHardSoftLayers = function splitForestToHardSoftLayers(mapData){
        var pointLatLngsH = [];
        var pointLatLngsM = [];
        var pointLatLngsS = [];
        for (var i in mapData){
            var pointLatLng = newLTPointHeat(mapData[i].PosX, mapData[i].PosY, 0, 0, 1);
            switch (mapData[i].HardSoft) {
                case 'H': pointLatLngsH.push(pointLatLng); break;
                case 'M': pointLatLngsM.push(pointLatLng); break;
                case 'S': pointLatLngsS.push(pointLatLng); break;
                default: break;
            }
        }
        layerForestH.setLatLngs(pointLatLngsH);
        layerForestM.setLatLngs(pointLatLngsM);
        layerForestS.setLatLngs(pointLatLngsS);
    };

    // split forest to our different hard-soft-types
    window.splitKeepsWallsToLayers = function splitKeepsWallsToLayers(mapData){
        var pointLatLngs1 = [];
        var pointLatLngs2 = [];
        var pointLatLngs3 = [];
        for (var i in mapData){
            var pointLatLng = newLTPointHeat(mapData[i].PosX, mapData[i].PosY, 0, 0, 1);
            switch (mapData[i].ParentID) {
                case 130:
                    var keepMarker = L.marker(pointLatLng, getKeepIcon(mapData[i].TypeID) ).bindPopup(mapData[i].Name);
                    layerKeeps.addLayer(keepMarker);
                    break;
                case 171: pointLatLngs1.push(pointLatLng); break;
                case 172: pointLatLngs2.push(pointLatLng); break;
                case 173: pointLatLngs3.push(pointLatLng); break;
                default: break;
            }
        }
        layerWalls1.setLatLngs(pointLatLngs1);
        layerWalls2.setLatLngs(pointLatLngs2);
        layerWalls3.setLatLngs(pointLatLngs3);
    };

    function playSound(audioId){
        if (flagPlaySounds && map.hasLayer(layerPlayerComplete)){
            document.getElementById(audioId).play();
        }
    }

    function speakText(input){
        if (flagPlaySounds){
            var u = new SpeechSynthesisUtterance();
            u.text = input;
            if (mapLanguage === 'de'){
                u.lang = 'de-DE';
            }
            else {
                u.lang = 'en-GB';
            }
            u.rate = 1.2;
            speechSynthesis.speak(u);
        }
    }

    function speakTextLayer(input, layer){
        if (map.hasLayer(layer)){
            speakText(input);
        }
    }

    // add and update player information
    function searchUpdatePlayerData(playerID, pointLatLng) {
        var retVal = -1;
        layerPlayerMarkers.eachLayer(function (layer) {
            if (layer.options.ID === playerID) {
                //layer.setLatLng(pointLatLng);
                if (layer.getLatLng().lat != pointLatLng.lat || layer.getLatLng().lng != pointLatLng.lng ){
                    if (flagFollowPlayers){
                        zoomToLatLng(layer.getLatLng());
                    }
                    setTimeout(function(){
                        playSound('footstep_human_soil');
                        layer.moveTo(pointLatLng, 1000);
                        layerPlayerLiveTrail.eachLayer(function (layer) {
                            if (layer.options.ID === playerID) {
                                layer.addLatLng(pointLatLng);
                            }
                        });
                    },1000);
                }
                retVal = 1;
                return retVal;
            }
        });

        return retVal;
    }

    var playerCount = 0;
    window.addUpdPlayerToLayer = function addUpdPlayerToLayer(mapData){
        for (var i in mapData) {
            var pointLatLng = newLTPoint(mapData[i].PosX, mapData[i].PosY);
            var oldMarkerFound = searchUpdatePlayerData(mapData[i].ID, pointLatLng);
            if (oldMarkerFound === -1) {
                playerCount++;
                if (mapData[i].Source === 'c_x') {
                    if (mapLanguage === 'de') {
                        speakTextLayer(mapData[i].Name + ' hat sich verbunden', layerPlayerMarkers);
                        speakTextLayer(playerCount + ' Chars sind jetzt im Spiel', layerPlayerMarkers);
                    }
                    else {
                        speakTextLayer(mapData[i].Name + ' connected', layerPlayerMarkers);
                        speakTextLayer(playerCount + ' players are now connected', layerPlayerMarkers);
                    }
                 }
                var playerMarker = L.Marker.movingMarker([pointLatLng] , 1000, { ID: mapData[i].ID, icon: iconPlayer, title: mapData[i].Name}).bindPopup(mapData[i].Name);
                layerPlayerMarkers.addLayer(playerMarker);
                var playerTrail = L.polyline([pointLatLng], { ID: mapData[i].ID, weight: 2, color: 'lime' }).bindPopup(mapData[i].Name);
                layerPlayerLiveTrail.addLayer(playerTrail);
            }
        }
        if (mapData[i].Source === 'c') {
            if (mapLanguage === 'de') {
                speakTextLayer(mapData.length + ' Chars sind aktuell im Spiel', layerPlayerMarkers);
            }
            else {
                speakTextLayer(mapData.length + ' players are currently connected', layerPlayerMarkers);
            }
        }
    };

    // add guild lands to layer
    window.addGuildLandsToLayer = function addGuildLandsToLayer(mapData){
        for (var i in mapData) {
            var pointLatLng = newLTPoint(mapData[i].PosX, mapData[i].PosY);
            var guildLand = L.circleMarker(pointLatLng, {
                color: 'blue',
                fillColor: 'blue',
                fillOpacity: 0.2,
                weight: 1,
                radius: mapData[i].Radius / maxWorldMeterIngame * Math.pow(2, map.getZoom()) * maxWorldPxTile
            });
            var guildLandMarker = L.marker(pointLatLng, {icon: iconGuildLand}).bindPopup(mapData[i].Name);
            layerGuildLands.addLayer(guildLand);
            layerGuildLands.addLayer(guildLandMarker);
        }
    };

    // incoming map data
    socket.on('mapData', function (result) {
        $('#messages').empty();
        switch (result.map_data[0].Source) {
            case 'c':       addUpdPlayerToLayer(result.map_data);                           break;
            case 'c_x':     addUpdPlayerToLayer(result.map_data);                           break;
            case 'gl':      addGuildLandsToLayer(result.map_data);                          break;
            case 'gp_c':    addMapDataToHeatLayer(result.map_data, layerClay, 1);           break;
            case 'gp_oc':   addMapDataToHeatLayer(result.map_data, layerCopper, 1);         break;
            case 'gp_og':   addMapDataToHeatLayer(result.map_data, layerGold, 1);           break;
            case 'gp_oi':   addMapDataToHeatLayer(result.map_data, layerIron, 1);           break;
            case 'gp_os':   addMapDataToHeatLayer(result.map_data, layerSilver, 1);         break;
            case 'gp_r':    addMapDataToHeatLayer(result.map_data, layerRoads, 1);          break;
            case 'gp_sn':   addMapDataToHeatLayer(result.map_data, layerSnow, 1);           break;
            case 'gp_sw':   addMapDataToHeatLayer(result.map_data, layerSwamp, 1);          break;
            case 'f':       splitForestToHardSoftLayers(result.map_data);                   break;
            case 'uo':      addMapDataToHeatLayer(result.map_data, layerUnmovables, 1);     break;
            case 'uo_kw':   splitKeepsWallsToLayers(result.map_data);                       break;
            case 'mo':      addMapDataToHeatLayer(result.map_data, layerMovables, 1);       break;
            case 'alt':     splitAltToHeightLayers(result.map_data, layerHeight);           break;
            case 'hm_cp':   addMapDataToHeatLayer(result.map_data, layerHmMovement);        break;
            case 'hm_gp':   addMapDataToHeatLayer(result.map_data, layerHmDigging);         break;
            default:        break;
        }
    });

    // get map data from the server
    requestMapDataAll();
    if (mapLanguage === 'de'){
        speakText('Willkommen auf der Karte von '+ mapID);
    }
    else {
        speakText('Welcome to the interactive map of '+mapID);
    }

});