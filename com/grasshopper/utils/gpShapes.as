/*
 * 	 gpShapes - an AS3 Class
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
	import flash.geom.Matrix;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.filters.DropShadowFilter;
	import com.grasshopper.utils.gpColorSchemes;

	public class gpShapes extends Sprite {
		private var _fill_colors:Array;
		private var _line_color:Number;
		private var _line_size:Number;
		private var _fill_alphas:Array;
		private var _fill_ratios:Array;
		private var _nX:uint;
		private var _nY:uint;
		private var _nW:Number;
		private var _nH:Number;
		private var _shape_type:String;
		private var _fill_type:String;
		private var _corners:Array;
		
		public function gpShapes() {	
			
		}
		
		public function createShape(shape:XMLList):void {
			var fin:Boolean;
			fin = setValues(shape);
			x = _nX;
			y = _nY;
			if (_fill_colors.length == 1) {
				//if fill colors == 0, then the shape will have a border only
				if (_fill_colors[0] != 0) {
					graphics.beginFill(_fill_colors[0], _fill_alphas[0]);
				}
			} else if (_fill_colors.length >= 2) {
				//var spreadMethod:String = "reflect";
				//var interpolationMethod:String = "linearRGB";
				//var focalPointRatio:Number = .3;
				var matrix = new Matrix();
				matrix.createGradientBox(_nW, _nH, Math.PI/2, 0, 0);
				graphics.beginGradientFill(_fill_type, _fill_colors, _fill_alphas, _fill_ratios, matrix);
			}
			if (_line_size != 0) {
				graphics.lineStyle(_line_size, _line_color, 1.0);
			}
			if ((_corners[0] == 'null') || (_corners[0] == '0')) {
				if ((_shape_type == 'rectangle') || (_shape_type == 'rightTriangle')) {
					graphics.moveTo(0, 0);
				} else {
					graphics.moveTo(_nW/2, 0);
					//graphics.moveTo(0, nH/2);
				}
			} else if (_corners.length == 4) {
				graphics.moveTo(_corners[0], 0);
			} else if (_corners.length == 3) {
				//triangle. don't do anything here
			}
			if (_shape_type == 'triangle') {
				fin = drawTriangle();
			} else if (_shape_type == 'rightTriangle') {
				fin = drawRightTriangle();
			} else if (_shape_type == 'diamond') {
				fin = drawDiamond();	
			} else if (_shape_type == 'circle') {
				fin = drawCircle();
			} else if (_shape_type == 'halfCircle') {
				fin = drawHalfCircle();	
			} else if (_shape_type == 'ellipse') {
				fin = drawEllipse();	
			} else if (_shape_type == 'rectangle') {
				fin = drawRect();
			}
			graphics.endFill();
			if (shape.@create_shadow == true) {
				createShadow();
			}
		}
		
		private function setValues(shape:XMLList):Boolean {
			_nX = (shape.attribute('nX').toString()) ? shape.@nX : 0;
			_nY = (shape.attribute('nY').toString()) ? shape.@nY : 0;
			_nW = (shape.attribute('nW').toString()) ? shape.@nW : 0;
			_nH = (shape.attribute('nH').toString()) ? shape.@nH : 0;
			_shape_type = (shape.attribute('shape_type').toString()) ? shape.@shape_type : 'rectangle';
			_fill_type = (shape.attribute('fill_type').toString()) ? shape.@fill_type : 'linear';
			_corners = (shape.attribute('corners')) ? shape.@corners.toString().split(",") : new Array();

			if (shape.attribute("colorSchemeName").toString()) {
				var c_rev:Boolean = (shape.attribute('colorSchemeReverse')) ? true : false;
				var cScheme:gpColorSchemes = new gpColorSchemes(shape.@colorSchemeName, c_rev);
				var colorScheme:Object = cScheme.getColorScheme();
				_fill_colors = colorScheme.bgColor;
				_line_color = colorScheme.brdrColor;
				_line_size = colorScheme.brdrSize;
				_fill_alphas = colorScheme.cAlphas;
				_fill_ratios = colorScheme.ratio;
			} else {
				_fill_colors = (shape.attribute('bgColor').toString()) ? shape.@bgColor.toString().split(",") : new Array();
				_line_color = shape.@borderColor;
				_line_size = (shape.attribute('borderSize').toString()) ? shape.@borderSize : 0;
				_fill_alphas = (shape.attribute('bgAlphas').toString()) ? shape.@bgAlphas.toString().split(",") : getAlphas(_fill_colors.length);
				_fill_ratios = getRatios(_fill_colors.length);
			}
			return true;
		}
		
		private function drawRect():Boolean {
			var nWid:Number = (_corners.length == 4) ? _nW-_corners[1] : _nW;
			graphics.lineTo(nWid, 0);
			if (_corners.length == 4) {
				graphics.curveTo(_nW, 0, _nW, _corners[1]);
				graphics.lineTo(_nW, _corners[1]);
			}
			var nHt:Number = (_corners.length == 4) ? _nH-_corners[2] : _nH;
			nWid = _corners.length == 4 ? _nW-_corners[2] : _nW;
			graphics.lineTo(_nW, nHt);
			if (_corners.length == 4) {
				graphics.curveTo(_nW, _nH, nWid, _nH);
				graphics.lineTo(nWid, _nH);
			}
			nHt = (_corners.length == 4) ? _corners[3] : _nH;
			graphics.lineTo(nHt, _nH);
			if (_corners.length == 4) {
				graphics.curveTo(0, _nH, 0, _nH-_corners[3]);
				graphics.lineTo(0, _nH-_corners[3]);
			}
			nHt = (_corners.length == 4) ? _corners[0] : _nH;
			graphics.lineTo(0, nHt);
			if (_corners.length == 4) {
				graphics.curveTo(0, 0, _corners[0], 0);
				graphics.lineTo(_corners[0], 0);
			}
			return true;
		}
		
		private function drawTriangle():Boolean {
			graphics.lineTo(_nW, _nH);
			graphics.lineTo(0, _nH);
			graphics.lineTo(_nW/2, 0);
			return true;
		}
		
		private function drawRightTriangle():Boolean {
			graphics.lineTo(_nW, _nH);
			graphics.lineTo(0, _nH);
			graphics.lineTo(0, 0);
			return true;
		}
		
		public function drawCircle():Boolean {
			/*graphics.curveTo(_nW, 0, _nW, nH/2);
            graphics.curveTo(_nW, nH, _nW/2, nH);
            graphics.curveTo(0, nH, 0, nH/2);
            graphics.curveTo(0, 0, _nW/2, 0);*/
			graphics.drawCircle(0, 0, _nW/2);
			return true;
		}
		
		private function drawEllipse():Boolean {
			/*graphics.curveTo(nW, 0, nW, nH/2);
            graphics.curveTo(nW, nH, nW/2, nH);
            graphics.curveTo(0, nH, 0, nH/2);
            graphics.curveTo(0, 0, nW/2, 0);*/
			graphics.drawEllipse(0, 0, _nW, _nH);
			return true;
		}
		
		private function drawHalfCircle():Boolean {
			/*graphics.curveTo(nW, 0, nW, nH/2);
            graphics.lineTo(0, nH/2);
            graphics.curveTo(0, 0, nW/2, 0);*/
			graphics.curveTo(_nW, 0, _nW, _nH/2);
            graphics.curveTo(_nW, _nH, _nW/2, _nH);
			return true;
		}
		
		private function drawDiamond():Boolean {
			graphics.lineTo(_nW, _nH/2);
            graphics.lineTo(_nW/2, _nH);
            graphics.lineTo(0, _nH/2);
            graphics.lineTo(_nW/2, 0);
			return true;
		}
		
		private function getRatios(numColors:Number):Array {
			var ratios:Array = new Array();
			var inc_amt:int = Math.floor(256/numColors);
			var rat:int = 0;
			if (numColors == 2) {
				ratios = [0, 255];
			} else {
				for (var i:Number = 1; i <= numColors; i++) {
					if (i == 1) {
						ratios.push(0);
					} else if (i == numColors) {
						ratios.push(255);
					} else {
						rat = rat + inc_amt;
						ratios.push(rat);
					}
				}
			}
			return ratios;
		}
		//
		private function getAlphas(numColors:Number):Array {
			var alphas:Array = new Array();
			for (var i:Number = 0; i < numColors; i++) {
				alphas.push(1);
			}
			return alphas;
		}
		//
		private function createShadow():void {
			var filter:DropShadowFilter = new DropShadowFilter(15, 45, 0x0F0F0F, 1, 10, 10, 1, 3, false, false, false);
				var filterArray:Array = new Array();
				filterArray.push(filter);
				filters = filterArray;
		}
		
		public function getXY():Array {
			return new Array(this.x, this.y);
		}
		//
		//private function animateOver():Void {
			//var recTween:Tween = new Tween(this, "_width", Strong.easeOut, 0 , _nWidth, 3, true);
		//}
		//
	}
}
