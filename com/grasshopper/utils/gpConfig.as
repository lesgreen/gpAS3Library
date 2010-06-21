/*
 * 	 gpConfig - an AS3 Class
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
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.events.*;
	import flash.xml.*;
	
	public class gpConfig extends Sprite { 
		
		private var _config:XML;
		private var _xChild:XMLList;
		
		public function gpConfig(c:XML) {
			_config = c;
		}
		
		public function getChildByAttrib(parent_node:String, child:String, attrib:String, val:String):XMLList {
			return _config[parent_node].child(child).(@[attrib] == val);
		}
		
		public function getChildByAttribObject(parent_node:String, child:String, attrib:String, val:String):Object {
			var c:XMLList = _config[parent_node].child(child).(@[attrib] == val);
			return convertAttribsToObject(c);
		}
		
		public function setChildByAttrib(parent_node:String, child:String, attrib:String, val:String):void {
			_xChild = _config[parent_node].child(child).(@[attrib] == val);
		} 
		
		public function getChildAttribVal(attrib:String):String {
			return _xChild.@[attrib];
		}
		
		public function setChildAttribVal(attrib:String, val:String):void {
			_xChild.@[attrib] = val;
		}
		
		public function setAttribVal(parent_node:String, child:String, attrib:String, val:String):void {
			_config[parent_node].child(child).@[attrib] = val;
		}
		
		public function getChildObjectByAttrib(parent_node:String, child:String, attrib:String, val:String):Object {
			return convertAttribsToObject(_config[parent_node].child(child).(@[attrib] == val));
		}
		
		public function convertAttribsToObject(xml:XMLList):Object {
			var xList:XMLList = xml.@*;
			var nL:int = xList.length();
			var ob:Object = new Object();
			for (var i:int = 0; i < nL; i++) { 
				//trace(xList[i]);
				ob[xList[i].name().toString()] = xList[i];
			}
			return ob;
		}
	}
}