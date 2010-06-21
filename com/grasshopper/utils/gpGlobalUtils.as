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
	import flash.xml.*;
	
	public class gpGlobalUtils {
		
		//private static var instance:gpGlobalUtils;
		
		/*public static function getInstance():gpGlobalUtils {
			if ( !instance ) {
					instance = new gpGlobalUtils();
			}
			return instance;
        }*/
		
		/*public function getSwfParam(name:String, defaultValue:String):String {
			var paramObj:Object = LoaderInfo(stage.loaderInfo).parameters;
			if(paramObj[name] != null && paramObj[name] != "") {
				return paramObj[name];
			} else {
				return defaultValue;
			}
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
		
		public static function getRandom(mult=''):Number {
			return (mult == '') ? Math.random() : Math.floor(Math.random() * Number(mult));
		}
		
		public static function isEven(n:Number):Boolean {
			//return (n % 2 == 0) ? true : false;
			return ((n & 1) == 0) ? true : false;
		}
		
		public static function getChildrenByAttribute(xmlData:XML, parent_node:String, attrib:String, val:String):XMLList {
			var xList:XMLList = xmlData[parent_node].(@[attrib] == val).children();
			return xList;
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
		
		public function getNumCols(nContainerW:Number, nItemW:Number, nSpacing=0):Number {
		var nNumCols:Number = Math.floor(nContainerW/(nItemW + Number(nSpacing)));
		return nNumCols;
		}
		//
		public function getNumRows(nContainerH:Number, nItemH:Number, nSpacing=0):Number {
			var nNumRows:Number = Math.floor(nContainerH/(nItemH + Number(nSpacing)));
			return nNumRows;
		}
		//change to xmltoobject
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
	}
}