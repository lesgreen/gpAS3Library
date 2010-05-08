/*
 * 	 gpUrlLoader - an AS3 Class
 * 	 @author Les Green
 * 	 Copyright (C) 2010 Intriguing Minds, Inc.
 *   Version 0.5
 * 
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   Demo and Documentation can be found at:   
 *   http://www.grasshopperpebbles.com
 *   
 */


package com.grasshopper.utils {
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.text.StyleSheet;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.utils.ByteArray;
	import flash.net.URLLoaderDataFormat;
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import com.adobe.serialization.json.JSON;
	
	public class gpUrlLoader extends EventDispatcher { 
		public var urlLoader:URLLoader;
		private var loader:Loader;
		private var sheet:StyleSheet;
		private var sheet_nonparsed:String;
		private var xml:XML;
		private var json:Object;
		private var json_nonparsed:String;
		private var snd:Sound;
		private var txt:String;
		private var loadType:String;
		public static var LOADERROR:String = "error";
		
		public function gpUrlLoader() {
			
		}
		
		public function init(url:String, lType:String):void {
			loadType = lType;
			urlLoader = new URLLoader();
			if ((lType == 'image') || (lType == 'swf')) {
				urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			} else if (lType == 'text') {
				urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			}
			if (lType == 'sound') {
				snd = new Sound();
				var context:SoundLoaderContext = new SoundLoaderContext(30000, false);
				snd.addEventListener(Event.COMPLETE, onComplete);
				snd.addEventListener(IOErrorEvent.IO_ERROR, onError);
				snd.addEventListener(Event.OPEN, onOpen);
				snd.addEventListener(ProgressEvent.PROGRESS, onProgress);
				snd.load(new URLRequest(url));
			} else if ((lType == 'image') || (lType == 'swf')) {
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
				loader.contentLoaderInfo.addEventListener(Event.OPEN, onOpen);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
				loader.load(new URLRequest(url));
			} else {
				urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
				urlLoader.addEventListener(Event.OPEN, onOpen);
				urlLoader.addEventListener(Event.COMPLETE, onComplete);
				urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);
				urlLoader.load(new URLRequest(url));
			}
		}
		
		private function onOpen(e:Event):void {
			dispatchEvent(new Event(Event.OPEN));
		}
		
		private function onProgress(event:ProgressEvent):void {
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
		}
		
		private function onComplete(e:Event):void {
			if ((loadType == 'image') ||(loadType == 'swf')) {
				//loader = new Loader();
				//loader.loadBytes(urlLoader.data);
				//trace(loader.width);
			} else if (loadType == 'text') {
				txt = e.target.data as String;
			} else if (loadType == 'xml') {
				xml = new XML(e.target.data);
			} else if (loadType == 'stylesheet') {
				sheet = new StyleSheet();
				sheet.parseCSS(urlLoader.data);
				sheet_nonparsed = urlLoader.data;
			} else if (loadType == 'json') {
				json = JSON.decode(urlLoader.data);
				json_nonparsed = urlLoader.data;
			} else if (loadType == 'sound') {
				//
			} 
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function onError(e:ErrorEvent):void {
            doError();
        }
		
	    public function doError():void {
			dispatchEvent(new Event(LOADERROR));
		}
		
		public function getXML():XML {
			return xml;
		}
		
		public function getImage():Loader {
			return loader;
		}
		
		public function getSWF():Loader {
			return loader;
		}
		
		public function getStyleSheet():StyleSheet {
			return sheet;
		}
		
		public function getStyleSheetNonParsed():String {
			return sheet_nonparsed;
		}
		
		public function getJson():Object {
			return json;
		}
		
		public function getJsonNonParsed():String {
			return json_nonparsed;
		}
		
		public function getSound():Sound {
			return snd;
		}
		
		public function getText():String {
			return txt;
		}
	}
}