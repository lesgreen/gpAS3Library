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