

	//
	// MODULES & CONFIG
	//
	var conf    = require('./config.json');
	var express = require('express');
	var app     = express();
	var server  = require('http').createServer(app);
	var io      = require('socket.io').listen(server);
	var mysql   = require('mysql');
	var dbpool  = mysql.createPool({
					 connectionLimit : conf.mysqllimit,
					 host     : conf.mysqlhost,
					 user     : conf.mysqluser,
					 password : conf.mysqlpw,
					 database : conf.mysqldb
				  });



	// to enable listener and loop
	//var connectedSockets = { };
	var clients = [];
	var pushInterval = 10; // seconds
	var mapID;


	//
	// CLIENT
	//
	app.use(express.static(__dirname + '/public'));
	app.get('/', function (request, response) {
       response.sendfile(__dirname + '/public/index.html');
	});


	//
	// FUNCTIONS
	//

	function collectMapData(request, mapData) {
		dbpool.getConnection(function(err,connection){
			if (err) {
				connection.release();
				mapData.json({"code" : 100, "status" : "Error in connection database"});
				return;
			}
            switch (request.filter.Source) {
				case 'alt':		var sql = 'SELECT Source, PosX, PosY, Lvl from $lt_v_alt_lvl'; break;
				case 'f':  		var sql = 'SELECT Source, PosX, PosY, HardSoft from $lt_v_coords_forest'; break;
				case 'c':  		var sql = 'SELECT Source, PosX, PosY, ID, Name from $lt_v_coords_char'; break;
				case 'c_x':  	var sql = 'SELECT "c_x" as Source, PosX, PosY, ID, Name from $lt_v_coords_char_trails '+
										   'WHERE MoveTimestamp >= current_timestamp - interval ' + pushInterval + ' second '; break;
				case 'gl':		var sql = 'SELECT Source, PosX, PosY, ID, Name, TypeID, Radius from $lt_v_coords_guild_lands'; break;
				case 'mo':  	var sql = 'SELECT Source, PosX, PosY from $lt_v_coords_mo'; break;
				case 'uo':  	var sql = 'SELECT Source, PosX, PosY from $lt_v_coords_uo_map'; break;
				case 'uo_kw':  	var sql = 'SELECT Source, PosX, PosY, TypeID, Name, ParentID from $lt_v_coords_uo_kw'; break;
				case 'gp_c':  	var sql = 'SELECT Source, PosX, PosY from $lt_v_coords_gp_clay'; break;
				case 'gp_r':  	var sql = 'SELECT Source, PosX, PosY from $lt_v_coords_gp_roads'; break;
				case 'gp_sn':  	var sql = 'SELECT Source, PosX, PosY from $lt_v_coords_gp_snow'; break;
				case 'gp_sw':  	var sql = 'SELECT Source, PosX, PosY from $lt_v_coords_gp_swamp'; break;
				case 'gp_oc':  	var sql = 'SELECT Source, PosX, PosY from $lt_v_coords_gp_ore_copper'; break;
				case 'gp_og':  	var sql = 'SELECT Source, PosX, PosY from $lt_v_coords_gp_ore_gold'; break;
				case 'gp_oi':  	var sql = 'SELECT Source, PosX, PosY from $lt_v_coords_gp_ore_iron'; break;
				case 'gp_os':  	var sql = 'SELECT Source, PosX, PosY from $lt_v_coords_gp_ore_silver'; break;
				case 'hm_cp': 	var sql = 'SELECT Source, PosX, PosY, Count from $lt_v_hm_char_positions'; break;
				case 'hm_gp': 	var sql = 'SELECT Source, PosX, PosY, Count from $lt_v_hm_geo_patch'; break;
				default: 		var sql = 'select 1 from dual';
			}
			// console.log(sql);
			connection.query(sql, function(err,rows){
				connection.release();
				if(!err) {
					if (request.filter.Source === 'c_x' ){
						console.log('Filter MapID = ' + request.filter.MapID + ' Source = ' + request.filter.Source + ' PlayerTrailUpdate = ' + rows.length);
					} else {
						console.log('Filter MapID = ' + request.filter.MapID + ' Source = ' + request.filter.Source + ' Count = ' + rows.length);
					}
					mapData(rows);
				}
			});
			connection.on('error', function(err) {
				console.log(err);
				mapData.json({"code" : 100, "status" : "Error in connection database"});
			});
		});
	}

	function convertLTPointToGeoID(request, GeoID) {
		var l_BlockID, l_BlockX, l_BlockY, l_TerainID, l_GeoID, l_PosX, l_PosY;
		var l_TerWidth = 511;
		var l_TerIDMin = 441;
		l_PosX = request.filter.PosX;
		l_PosY = request.filter.PosY;
		l_BlockID = Math.ceil(l_PosX / l_TerWidth) + (Math.ceil(l_PosY / l_TerWidth) - 1) * 3;
		l_BlockX = l_PosX % l_TerWidth;
		l_BlockY = l_PosY % l_TerWidth;
		l_TerainID = l_BlockID + l_TerIDMin;
		l_GeoID = ((l_TerainID << 18) | (l_BlockY << 9) | l_BlockX);
		console.log('GeoID = ' + l_GeoID);
		GeoID(l_GeoID);
	}


	//
	// SOCKET listener
	//
	io.sockets.on('connection', function (socket) {
		//connectedSockets[socket.id] = socket;
		clients.push(socket);
		console.log('Client connected. Count = ' + clients.length);
		socket.on('requestMapData', function (request) {
			mapID = request.filter.MapID;
			collectMapData(request, function(mapData) {
			  if (mapData.length) {
				  socket.emit('mapData', { time: new Date(), filter: request.filter, map_data: mapData } );
			  }
			  else {
				  socket.emit('feedback', {time: new Date(), message: 'Error during getting map data.'});
			  }
		   });
		});
		socket.on('requestGeoID', function (request) {
			console.log('Request PosX = ' + request.filter.PosX + ' PosY = ' + request.filter.PosY);
			convertLTPointToGeoID(request, function(GeoID) {
				//if (GeoID.length) {
					socket.emit('resultGeoID', { time: new Date(), GeoID: GeoID } );
				//}
				//else {
				//	socket.emit('feedback', {time: new Date(), message: 'Error during getting GeoID.'});
				//}
			});
		});
		socket.on('disconnect', function() {
			clients.splice(clients.indexOf(socket), 1);
			console.log('Client disconnected. Count = ' + clients.length);
		});
	});


	//
	// SERVER
	//
	server.listen(conf.port);
	console.log('Server running on http://127.0.0.1:' + conf.port + '/');


	setInterval(function() {
		var request = {
			time: new Date(),
			"filter": {MapID: mapID, Source: 'c_x'}
		};
		if (clients.length){
			//console.log('Clients connected = ' + clients.length);
			collectMapData( request, function(mapData) {
				if (mapData.length) {
					clients.forEach(function(client, index) {
						client.emit('mapData', {time: new Date(), map_data: mapData});
					});
				}
			})
		}
	}, pushInterval * 1000 );



	//
	// CLEAN UP
	//


