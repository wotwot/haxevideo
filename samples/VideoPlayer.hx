/* ************************************************************************ */
/*																			*/
/*  haXe Video 																*/
/*  Copyright (c)2007 Nicolas Cannasse										*/
/*																			*/
/* This library is free software; you can redistribute it and/or			*/
/* modify it under the terms of the GNU Lesser General Public				*/
/* License as published by the Free Software Foundation; either				*/
/* version 2.1 of the License, or (at your option) any later version.		*/
/*																			*/
/* This library is distributed in the hope that it will be useful,			*/
/* but WITHOUT ANY WARRANTY; without even the implied warranty of			*/
/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU		*/
/* Lesser General Public License or the LICENSE file for more details.		*/
/*																			*/
/* ************************************************************************ */
package samples;

class VideoPlayer extends flash.media.Video {

	var nc : flash.net.NetConnection;
	var ns : flash.net.NetStream;
	var file : String;

	public function new(host,file) {
		super();
		trace("Connecting...");
		this.file = file;
		nc = new flash.net.NetConnection();
		nc.addEventListener(flash.events.NetStatusEvent.NET_STATUS,onEvent);
		nc.connect(host);
	}

	function onEvent(e) {
		trace(e.info);
		if( e.info.code == "NetConnection.Connect.Success" ) {
			ns = new flash.net.NetStream(nc);
			ns.addEventListener(flash.events.NetStatusEvent.NET_STATUS,onEvent);
			attachNetStream(ns);
			ns.play(file);
		}
	}

	public function stop() {
		if( ns != null )
			ns.close();
		nc.close();
	}

}
