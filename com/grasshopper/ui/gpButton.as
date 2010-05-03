/*
 * 	 gpButton - an AS3 Class (extends gpShape)
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
	
	import flash.text.TextField;
	import flash.events.*;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
    import flash.text.TextFieldAutoSize;

	import com.grasshopper.utils.gpShapes;
	import com.grasshopper.utils.gpGlobalUtils;
	
	public class gpButton extends gpShapes {
		private var _xBtn:XMLList;
		private var _sBtnText:String;
		private var _tBtnLabel:TextField;
		private var _text_format:TextFormat;
		private var _fontColor:Number;
		private var _bgColor:Number;
		private var _borderColor:Number;
		private var _aClickAction:Array;
		private var _oData:Object;
		
		public function gpButton() {
			buttonMode = true;
		}

		public function set btnData(oData:Object):void {
			_oData = oData;
		}
		
		public function get btnData():Object {
			return _oData;
		}
		//
		public function createButton(xBtn:XMLList, sBtnText:String):void {
			_xBtn = xBtn;
			_sBtnText = sBtnText;
			_bgColor = _xBtn.@bgColor;
			_borderColor = _xBtn.@borderColor;
			createShape(xBtn);
			if (_sBtnText != "") {
				createCaption();
			}
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		private function createCaption():void {
			_tBtnLabel = gpGlobalUtils.getTextField(_xBtn.@tProperties);
			_tBtnLabel.text = _sBtnText;
			var a:Array = getXY();
			_tBtnLabel.width = _xBtn.@nW;
			_tBtnLabel.height = _xBtn.@nH;
			var ly:Number = (Number(_xBtn.@nH)-_tBtnLabel.height)/2;
			var lx:Number = (Number(_xBtn.@nW)-_tBtnLabel.width)/2;
			_tBtnLabel.x = lx;
			_tBtnLabel.y = ly;
			if (_xBtn.attribute('tFormat').toString()) {
				_text_format = gpGlobalUtils.getTextFormat(_xBtn.@tFormat);
				_text_format.color = _xBtn.@fontColor;
				_tBtnLabel.setTextFormat(_text_format);
			}
			addChild(_tBtnLabel);
		}
		
		//
		private function onMouseOver(event:MouseEvent):void {
			var a:Array = getXY();
			_xBtn.@bgColor = _xBtn.@bgColorHover;
			_xBtn.@borderColor = _xBtn.@borderColorHover;
			_xBtn.@nX = a[0];
			_xBtn.@nY = a[1];
			graphics.clear();
			createShape(_xBtn);
			if (_sBtnText != "") {
				if (_xBtn.attribute('tFormat').toString()) {
					_text_format.color = _xBtn.@fontColorHover;
					_tBtnLabel.setTextFormat(_text_format);
				}
			}
			//this.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER));
		}
		private function onMouseOut(event:MouseEvent):void {
			var a:Array = getXY();
			_xBtn.@bgColor = _bgColor;
			_xBtn.@borderColor = _borderColor;
			_xBtn.@nX = a[0];
			_xBtn.@nY = a[1];
			graphics.clear();
			createShape(_xBtn);
			if (_sBtnText != "") {
				if (_xBtn.attribute('tFormat').toString()) {
					_text_format.color = _xBtn.@fontColor;
					_tBtnLabel.setTextFormat(_text_format);
				}
			}
			//this.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT));
		}
	}
}