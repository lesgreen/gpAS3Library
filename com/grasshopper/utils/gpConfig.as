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
			return convertChildToObject(_config[parent_node].child(child).(@[attrib] == val));
		}
		
		public function convertChildToObject(xml=''):Object {
			var xList:XMLList = (xml == '') ? _xChild : xml;
			var nL:int = xList.length();
			var ob:Object = new Object();
			for (var i:int = 0; i < nL; i++) { 
				ob[xList[i].name()] = xList[i];
			}
			return ob;
		}
		
		public function getTextFormat(parent_node:String, child:String, attrib:String, val:String, format_attrib:String):TextFormat {
			var xList:XMLList = getChildByAttrib(parent_node, child, attrib, val);
			return gpGlobalUtils.getTextFormat(xList.@[format_attrib]);
		}
		
		//public function getTextField(parent_node:String, child:String, attrib:String, val:String, format_attrib:String):TextField {
			/*var tF:TextField = new TextField();
			var xList:XMLList = getChildByAttrib(parent_node, child, attrib, val);
			var f_attrib:String = xList.@[format_attrib];
			var ob:Object = convertToObject(f_attrib);
			for (var key:* in ob) {
				tF[key] = ob[key];
			}
			return tF;*/
			//var xList:XMLList = getChildByAttrib(parent_node, child, attrib, val);
			//return gpGlobalUtils.getTextField(xList.@[format_attrib]);
		//}
		
		/*private function convertToObject(t:String):Object {
			var ob:Object = new Object();
			var a:Array = t.split(",");
			var nL:int = a.length;
			for (var i:int = 0; i < nL; i++) { 
				var props:Array = String(a[i]).split(":");
				ob[props[0]] = props[1];
			}
			return ob;
		}*/
	}
	
}