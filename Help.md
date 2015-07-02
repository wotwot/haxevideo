# Installation #

In order to run the haXeVideo server, you need first to download install haXe from http://haxe.org/download.

You can then download the latest haXeVideo release from the **Downloads** section.

You'll also have to install the `format` library to compile haxevideo. Run the following command from the commandline :

```
haxelib install format
```

# Testing #

Once you have the source releases, run _haxe video.hxml_, this will compile a _server.n_ and a _video.swf_ file. You can start the server on localhost by executing :

> neko server.n localhost 1935

You can open the _video.html_ file to display the _videos/test.flv_ file in realtime streaming.

Although the haXeVideo FLV server works for all Flash versions, displaying the _video.swf_ requires Flash Player 9, so make sure it is installed.

# Usages #

Here's some code usages about how to perform various commands from Flash using haxeVideo. Code is given in haXe

## Playing a Video ##

Videos are stored by default in the _./videos/_ folder relative to the place the server is running. In order to play a video you need first to connect to the server by using a _flash.net.NetConnection_ and then create a _flash.net.NetStream_. You can start playing the video by using the _ns.play("myvideo.flv")_ command. You can pause with _.pause()_, seek with _.seek(absoluteTime)_ and stop with _.stop()_.

## Recording a Video ##

If a webcam and/or a microphone are connected, it's possible to record the audio/video stream sent by the FlashPlayer into a _FLV_ file. First you need to connect to the server and create a stream. Then you can link the NetStream to the camera with _ns.attachCamera(flash.media.Camera.getCamera())_ and to the microphone with _ns.attachAudio(flash.media.Microphone.getMicrophone())_.

You can now send audio+video data to the server by calling _ns.publish("record.flv")_ which will create _./videos/record.flv_ file.

## Live Streaming ##

In order to live stream some published data, you need first to give the stream a shared by calling _ns.publish("record.flv","sharedName")_. Then, from another client or NetConnection/NetStream pair, you can connect to the live stream by calling _ns.play("#sharedName")_ (the name of the shared stream prefixed with a sharp char in order to tell that it's a livestream).

You can pause/resume a live stream but you can't seek it.

## Metadatas ##

Metadatas present in the FLV file are transmitted to the client reading the stream. In Flash9, they can be intercepted by setting the _ns.client_ field.

## Sending live data ##

Once you have published a live stream, you can send live messages by using the _ns.send_ command. For example _ns.send("onMetaData",{ hello : "World" })_ will be similar as if some metadata was found in the FLV.

## Shared Object ##

Shared object is a persistent storage that can be used for storing some informations on the server. There is only untested protocol support for it right now, so it's not yet fully implemented.

## FLV Indexing ##

While seeking into a FLV, haXeVideo currently reopen the FLV file an browse through it to find the matching keyframe. This could be done faster by creating and cashing an FLV keyframe index but this will be done in next version.

# Troubleshooting #

If the player can't connect to the server, try allowing access from the SWF by using the [Flash Settings Manager](http://www.macromedia.com/support/documentation/en/flashplayer/help/settings_manager04.html).

By default, the server is running on _localhost_, which means it's not available for access from other machines. Please change it in both _server.bat_ (or the neko command you're running) and _video.html_ (two times) with your network IP (such as 192.168.0.1) and open the port 1935 of your firewall in order to make the server accessible from the network.