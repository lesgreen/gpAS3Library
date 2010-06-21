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
	import com.grasshopper.ui.gpTextField;
	
	public class gpButton extends gpShapes {
		protected var _xBtn:Object;
		protected var _sBtnText:String;
		private var _tBtnLabel:TextField;
		private var _text_format:TextFormat;
		private var _fontColor:String;
		protected var _bgColor:String;
		protected var _borderColor:String;
		protected var _dropShadow:String;
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
		public function createButton(xBtn:Object, sBtnText:String):void {
			_xBtn = xBtn;
			_sBtnText = sBtnText;
			_bgColor = _xBtn.bgColor;
			_dropShadow = _xBtn.dropShadow;
			_borderColor = _xBtn.borderColor;
			createShape(xBtn);
			if (_sBtnText != "") {
				createCaption();
			}
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		private function createCaption():void {
			_tBtnLabel = gpTextField.createTextField(_xBtn.tProperties);
			_tBtnLabel.text = _sBtnText;
			var a:Array = getXY();
			_tBtnLabel.width = _xBtn.nW;
			_tBtnLabel.height = _xBtn.nH;
			var ly:Number = (Number(_xBtn.nH)-_tBtnLabel.height)/2;
			var lx:Number = (Number(_xBtn.nW)-_tBtnLabel.width)/2;
			_tBtnLabel.x = lx;
			_tBtnLabel.y = ly;
			if (_xBtn.tFormat) {
				_text_format = gpTextField.getTextFormat(_xBtn.tFormat);
				_text_format.color = _xBtn.fontColor;
				_tBtnLabel.setTextFormat(_text_format);
			}
			addChild(_tBtnLabel);
		}
		
		//
		protected function onMouseOver(event:MouseEvent):void {
			_xBtn.bgColor = _xBtn.bgColorHover;
			_xBtn.borderColor = _xBtn.borderColorHover;
			if (_xBtn.dropShadowHover) {
				_xBtn.dropShadow = _xBtn.dropShadowHover;
			}
			recreateShape();
			ifText('over');
			//this.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER));
		}
		
		protected function onMouseOut(event:MouseEvent):void {
			// unselect is same as mouse out. 
			// changes button back to original state
			doUnSelected();
			//this.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT));
		}
		
		private function onMouseClick(event:MouseEvent):void {
			doSelected();
		}
		
		public function doSelected():void {
			if (_xBtn.bgColorSelected) {
				_xBtn.bgColor = _xBtn.bgColorSelected;
			}
			if (_xBtn.borderColorSelected) {
				_xBtn.borderColor = _xBtn.borderColorSelected;
			}
			if (_xBtn.dropShadowSelected) {
				_xBtn.dropShadow = _xBtn.dropShadowSelected;
			}
			if ((_xBtn.bgColorSelected) || (_xBtn.borderColorSelected)) {
				recreateShape();
			}
			ifText('selected');
			//this.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER));
		}
		
		public function doUnSelected():void {
			_xBtn.bgColor = _bgColor;
			_xBtn.borderColor = _borderColor;
			_xBtn.dropShadow = _dropShadow;
			recreateShape();
			ifText('out');
		}
		
		private function recreateShape():void {
			var a:Array = getXY();
			_xBtn.nX = a[0];
			_xBtn.nY = a[1];
			removeShape();
			createShape(_xBtn);
		}
		
		private function ifText(mouseType:String):void {
			if (_sBtnText != "") {
				var clr:Number = getFontColor(mouseType);
				if (_xBtn.tFormat) {
					_text_format.color = clr;
					_tBtnLabel.setTextFormat(_text_format);
				} else {
					_tBtnLabel.textColor = clr;
				}
			}
		}
		
		private function getFontColor(type:String):Number {
			var rVal:Number = _xBtn.fontColor;
			switch(type) {
                case "over":
					rVal = _xBtn.fontColorHover;
					break;
				case "selected":
					rVal = (_xBtn.fontColorSelected) ? _xBtn.fontColorSelected : _xBtn.fontColor;
					break;
			}
			return rVal;
		}
	}
}