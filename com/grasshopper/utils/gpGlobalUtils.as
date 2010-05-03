/*
 * 	 gpGlobalUtils - an AS3 Class
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
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	
	public class gpGlobalUtils {
		
		//private static var instance:gpGlobalUtils;
		
		/*public static function getInstance():gpGlobalUtils {
			if ( !instance ) {
					instance = new gpGlobalUtils();
			}
			return instance;
        }*/
		
		
		public static function getTextFormat(f_attrib:String):TextFormat {
			var tF:TextFormat = new TextFormat();
			var ob:Object = convertToObject(f_attrib);
			for (var key:* in ob) {
				if (key == 'align') {
					tF[key] = getTextAlign(ob[key]);
				} else {
					tF[key] = ob[key];
				}
			}
			return tF;
		}
		
		public static function getTextField(f_attrib:String):TextField {
			var tF:TextField = new TextField();
			var ob:Object = convertToObject(f_attrib);
			for (var key:* in ob) {
				if (key == 'autoSize') {
					tF[key] = getTextAutoSize(ob[key]);
				} else {
					tF[key] = ob[key];
				}
			}
			return tF;
		}
		
		/*public static function getLabel(f_attrib:String):Label {
			var tF:Label = new Label();
			var ob:Object = convertToObject(f_attrib);
			for (var key:* in ob) {
				tF[key] = ob[key];
			}
			return tF;
		}*/
		
		public static function stripChars(str:String, searchFor:String, replaceWith:String):String {
			var sub:String;
			var index:Number;
			var len:Number = searchFor.length;
			while (str.indexOf(searchFor) != -1) {
				index = str.indexOf(searchFor);
				sub = str.substring(0, index) + replaceWith;
				str = sub + str.substr(index+len, str.length);
			}
			return str;
		}
		
		public static function centerObj(nStartVal:Number, nContVal:Number, nObjVal:Number):Number {
			var nCenter:Number = nStartVal + (nContVal - nObjVal)/2;
			return nCenter;
		}
		
		public static function getImageSizeAdjust(nCurSize:Number, nMaxSize:Number):Number {
			var nPerc:Number = (Number(nCurSize) > nMaxSize) ? nMaxSize/nCurSize : 1; 
			return nPerc;
		}
		public static function getNewSize(nW:Number, nH:Number, nMaxSize:Number):Array {
			var imgSize:Array = new Array();
			var nPerc:Number = getImageSizeAdjust(nH, nMaxSize);
			var newH:Number = nH*nPerc;
			var newW:Number = nW*nPerc;
			imgSize.push(newW);
			imgSize.push(newH);
			return imgSize;
		}
		
		private static function convertToObject(t:String):Object {
			var ob:Object = new Object();
			var a:Array = t.split(",");
			var nL:int = a.length;
			for (var i:int = 0; i < nL; i++) { 
				var props:Array = String(a[i]).split(":");
				ob[props[0]] = props[1];
			}
			return ob;
		}
		
		private static function getTextAutoSize(val:String):String {
			var rVal:String = TextFieldAutoSize.NONE;
			switch(val) {
                case "center":
					rVal = TextFieldAutoSize.CENTER;
					break;
				case "left":
					rVal = TextFieldAutoSize.LEFT;
					break;
				case "right":
					rVal = TextFieldAutoSize.RIGHT;
					break;
			}
			return rVal;
		}
		
		private static function getTextAlign(val:String):String {
			var rVal:String = TextFormatAlign.LEFT;
			switch(val) {
                case "center":
					rVal = TextFormatAlign.CENTER;
					break;
				case "justify":
					rVal = TextFormatAlign.JUSTIFY;
					break;
				case "left":
					rVal = TextFormatAlign.LEFT;
					break;
				case "right":
					rVal = TextFormatAlign.RIGHT;
					break;
			}
			return rVal;
		}
	}
}