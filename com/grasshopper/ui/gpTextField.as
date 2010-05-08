/*
 * 	 gpTextField - an AS3 Class
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

package com.grasshopper.ui {
	import flash.display.Sprite;
    import flash.text.StyleSheet;
    import flash.text.TextField;
	import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
    import flash.events.IOErrorEvent;
    import flash.events.Event;
    import flash.events.MouseEvent;

	public class gpTextField {
        		
		public static function createTextField(f_attrib:String, tFormat='', sheet=''):TextField {
		
			var tF:TextField = new TextField();
			var ob:Object = convertToObject(f_attrib);
			for (var key:* in ob) {
				if (key == 'autoSize') {
					tF[key] = getTextAutoSize(ob[key]);
				} else {
					tF[key] = ob[key];
				}
			}
			if (tFormat != '') {
				var tFrmat:TextFormat = getTextFormat(tFormat);
				tF.setTextFormat(tFrmat);
			}
			if (sheet != '') {
				tF.styleSheet = sheet;
			}
			return tF;
		}
		
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
		
		public static function getHtmlString(tag:String, txt:String, cls='', spanAfter='', spanBefore=''):String {
			var c:String = (cls == '') ? '' : ' class="'+cls+'" ';
			return '<'+ tag + c + '>'+ spanBefore + txt + spanAfter + '</' + tag + '>';
		}
		
		public static function getHref(txt:String, url:String, cls=''):String {
			var c:String = (cls == '') ? '' : ' class="'+cls+'" ';
			return '<a href="'+url+' "' + c + '>'+ txt + '</a>';
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