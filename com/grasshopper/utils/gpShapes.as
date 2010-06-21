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
/*
drawPolygon method adapted from:
http://www.flepstudio.org/forum/tutorials/990-drawing-polygons-actionscript-3-0-a.html
*/

package com.grasshopper.utils {
	import flash.geom.Matrix;
	import flash.display.*;
	import flash.filters.DropShadowFilter;
	import com.grasshopper.utils.gpColorSchemes;

	public class gpShapes extends Sprite {
		private var _fill_colors:Array;
		private var _matrix_rotation:Number;
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
		private var _segments:int;
		private var _rotate_amt:int;
		
		public function gpShapes() {	
			
		}
		
		public function createShape(shape:Object):void {
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
				if ((_shape_type == 'circle') || (_shape_type == 'polygon')) {
					//matrix.createGradientBox(_nW*2,_nW*2,0,-_nW/2+(_nW/2),-_nW/2-(_nW/2));
					//matrix.createGradientBox(_nW,_nW,0,-_nW/2+(_nW/2),-_nW/2-(_nW/2));
					matrix.createGradientBox(_nW,_nW,_matrix_rotation,_nW/128,_nW/128);
				} else if (_shape_type == 'halfCircle') {
					if (_fill_type == GradientType.LINEAR) {
						matrix.createGradientBox(_nW/2,_nW/2,_matrix_rotation,_nW/128,_nW/128);
					} else {
						matrix.createGradientBox(_nW,_nW,_matrix_rotation,-_nW/2, -_nW/2);
					}
				} else {
					matrix.createGradientBox(_nW, _nH, _matrix_rotation, 0, 0);
				}
				
				graphics.beginGradientFill(_fill_type, _fill_colors, _fill_alphas, _fill_ratios, matrix);
			}
			if (_line_size != 0) {
				graphics.lineStyle(_line_size, _line_color, 1.0);
			}
			if ((_corners[0] == '') || (_corners[0] == '0')) {
				if ((_shape_type == 'rectangle') || (_shape_type == 'rightTriangle') || (_shape_type == 'pause')) {
					graphics.moveTo(0, 0);
				} else if (_shape_type == 'arrow') {
					graphics.moveTo(0, _nH/4); 
				} else if (_shape_type == 'checkMark') {
					graphics.moveTo((_nW/2)/3, _nH/2);
				} else {
					if (_shape_type != 'polygon') {
						graphics.moveTo(_nW/2, 0);
					}
					//graphics.moveTo(0, nH/2);
				}
			} else if (_corners.length == 4) {
				graphics.moveTo(_corners[0], 0);
			} else if (_corners.length == 3) {
				//triangle. don't do anything here
				// need to add curved triangle
			}
			switch (_shape_type) {
				case 'triangle':
					fin = drawTriangle();
					break;
				case 'rightTriangle':
					fin = drawRightTriangle();
					break;
				case 'diamond':
					fin = drawDiamond();
					break;
				case 'circle':
					fin = drawCircle();
					break;
				case 'halfCircle':
					fin = drawHalfCircle();
					break;
				case 'ellipse':
					fin = drawEllipse();
					break;
				case 'rectangle':
					fin = drawRect();
					break;
				case 'arrow':
					fin = drawArrow();
					break;
				case 'pause':
					fin = drawPause();
					break;
				case 'polygon':
					fin = drawPolygon();
					break;
				case 'checkMark':
					fin = drawCheckMark();
					break;	
			}
			graphics.endFill();
			if (shape.dropShadow) {
				createShadow(shape);
			}
		}
		
		protected function setValues(shape:Object):Boolean {
			_nX = (shape.nX) ? shape.nX : 0;
			_nY = (shape.nY) ? shape.nY : 0;
			_nW = (shape.nW) ? shape.nW : 0;
			_nH = (shape.nH) ? shape.nH : 0;
			_segments = (shape.segments) ? shape.segments : 0;
			_rotate_amt = (shape.rotation) ? shape.rotation : 0;
			_shape_type = (shape.shape_type) ? shape.shape_type : 'rectangle';
			_fill_type = GradientType.LINEAR;
			if (shape.fill_type) {
				if (shape.fill_type == "radial") {
					_fill_type = GradientType.RADIAL;
				}
			} 
			if (shape.fill_type == "radial") {
				_matrix_rotation = 0;
			} else {
				_matrix_rotation = (shape.gradient_rotation) ? degreesToRadians(shape.gradient_rotation) : Math.PI/2;
			}
			
			_corners = (shape.corners) ? shape.corners.split(",") : new Array('0');
			if (shape.colorSchemeName) {
				var c_rev:Boolean = (shape.colorSchemeReverse) ? true : false;
				var cScheme:gpColorSchemes = new gpColorSchemes(shape.colorSchemeName, c_rev);
				var colorScheme:Object = cScheme.getColorScheme();
				_fill_colors = colorScheme.bgColor;
				_line_color = colorScheme.brdrColor;
				_line_size = colorScheme.brdrSize;
				_fill_alphas = colorScheme.cAlphas;
				_fill_ratios = colorScheme.ratio;
			} else {
				_fill_colors = (shape.bgColor) ? shape.bgColor.split(",") : new Array('0');
				_line_color = (shape.borderColor) ? shape.borderColor : 0;
				_line_size = (shape.borderSize) ? shape.borderSize : 0;
				_fill_alphas = (shape.bgAlphas) ? shape.bgAlphas.split(",") : getAlphas(_fill_colors.length);
				_fill_ratios = getRatios(_fill_colors.length);
				
			}
			return true;
		}
		
		protected function drawRect():Boolean {
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
			nHt = (_corners.length == 4) ? _corners[3] : 0;
			graphics.lineTo(nHt, _nH);
			if (_corners.length == 4) {
				graphics.curveTo(0, _nH, 0, _nH-_corners[3]);
				graphics.lineTo(0, _nH-_corners[3]);
			}
			nHt = (_corners.length == 4) ? _corners[0] : 0;
			graphics.lineTo(0, nHt);
			if (_corners.length == 4) {
				graphics.curveTo(0, 0, _corners[0], 0);
				graphics.lineTo(_corners[0], 0);
			}
			return true;
		}
		
		protected function drawTriangle():Boolean {
			graphics.lineTo(_nW, _nH);
			graphics.lineTo(0, _nH);
			graphics.lineTo(_nW/2, 0);
			return true;
		}
		
		protected function drawRightTriangle():Boolean {
			graphics.lineTo(_nW, _nH);
			graphics.lineTo(0, _nH);
			graphics.lineTo(0, 0);
			return true;
		}
		
		protected function drawCircle():Boolean {
			/*graphics.curveTo(_nW, 0, _nW, _nH/2);
            graphics.curveTo(_nW, _nH, _nW/2, _nH);
            graphics.curveTo(0, _nH, 0, _nH/2);
            graphics.curveTo(0, 0, _nW/2, 0);*/
			var hW:Number = _nW/2;
			graphics.drawCircle(hW, hW, hW);
			return true;
		}
		
		protected function drawEllipse():Boolean {
			/*graphics.curveTo(nW, 0, nW, nH/2);
            graphics.curveTo(nW, nH, nW/2, nH);
            graphics.curveTo(0, nH, 0, nH/2);
            graphics.curveTo(0, 0, nW/2, 0);*/
			graphics.drawEllipse(0, 0, _nW, _nH);
			return true;
		}
		
		protected function drawHalfCircle():Boolean {
			/*graphics.curveTo(nW, 0, nW, nH/2);
            graphics.lineTo(0, nH/2);
            graphics.curveTo(0, 0, nW/2, 0);*/
			//graphics.curveTo(_nW, 0, _nW, _nH/2);
            //graphics.curveTo(_nW, _nH, _nW/2, _nH);
			var r:Number = _nW/2;
			var c1:Number=r*(Math.SQRT2-1);
			var c2:Number=r*Math.SQRT2/2;
			//this.moveTo(x+r,y);
			graphics.curveTo(x+r,y+c1,x+c2,y+c2);
			graphics.curveTo(x+c1,y+r,x,y+r);
			graphics.curveTo(x-c1,y+r,x-c2,y+c2);
			graphics.curveTo(x-r,y+c1,x-r,y);
			x = y = r;
			
			/*graphics.curveTo(x-r,y-c1,x-c2,y-c2);
			graphics.curveTo(x-c1,y-r,x,y-r);
			graphics.curveTo(x+c1,y-r,x+c2,y-c2);
			graphics.curveTo(x+r,y-c1,x+r,y);*/
			return true;
		}
		
		protected function drawDiamond():Boolean {
			var halfH:Number = _nH/2;
			var halfW:Number = _nW/2;
			graphics.lineTo(_nW, halfH);
            graphics.lineTo(halfW, _nH);
            graphics.lineTo(0, halfH);
            graphics.lineTo(halfW, 0);
			return true;
		}
		
		protected function drawArrow():Boolean {
			var halfH:Number = _nH/2;
			var halfW:Number = _nW/2;
			var frH:Number = _nH/4;
			var thfrH:Number = _nH*(3/4);
			graphics.lineTo(halfW, frH);
			graphics.lineTo(halfW, 0);
			graphics.lineTo(_nW, halfH);
			graphics.lineTo(halfW, _nH);
			graphics.lineTo(halfW, thfrH);
			graphics.lineTo(0, thfrH);
			graphics.lineTo(0, frH);
			return true;
		}
		
		protected function drawPause():Boolean {
			var thW:Number = _nW/3;
			var twthW:Number = _nW*(2/3);
			graphics.lineTo(thW, 0);
			graphics.lineTo(thW, _nH);
			graphics.lineTo(0, _nH);
			graphics.lineTo(0, 0);
			graphics.moveTo(twthW, 0);
			graphics.lineTo(_nW, 0);
			graphics.lineTo(_nW, _nH);
			graphics.lineTo(twthW, _nH);
			graphics.lineTo(twthW, 0);
			return true;
		}
		
		protected function drawPolygon():Boolean {
			var cnt:Number = 0;
			var centerX:Number = _nW/2;
			var centerY:Number = _nW/2;
			var radius:Number = _nW/2;
			var points:Array = new Array();
			var ratio:Number = 360/_segments;
			var top:Number = centerY-radius;
			for(var i:int=_rotate_amt;i<=360+_rotate_amt;i+=ratio) {
				var xx:Number=centerX+Math.sin(degreesToRadians(i))*radius;
				var yy:Number=top+(radius-Math.cos(degreesToRadians(i))*radius);
				points[cnt]=new Array(xx,yy);
				if(cnt>=1) {
					//drawing(cnt, points[cnt-1][0],points[cnt-1][1],points[cnt][0],points[cnt][1]);
					if (cnt == 1) {
						graphics.moveTo(points[cnt-1][0],points[cnt-1][1]);
					}
					graphics.lineTo(points[cnt][0],points[cnt][1]);
				}
				cnt++;
			}
			cnt=0;
			return true;
		}

		protected function drawCheckMark():Boolean {
			var hlfthrd:Number = (_nW/2)/3;
			graphics.lineTo(_nW/2, _nH - hlfthrd);
			graphics.lineTo(_nW - hlfthrd, 0);
			graphics.lineTo(_nW, hlfthrd);
			graphics.lineTo(_nW/2, _nH);
			graphics.lineTo(0, _nH/2 + hlfthrd);
			graphics.lineTo(hlfthrd, _nH/2);
			return true;
		}
		
		protected function getRatios(numColors:Number):Array {
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
		protected function getAlphas(numColors:Number):Array {
			var alphas:Array = new Array();
			for (var i:Number = 0; i < numColors; i++) {
				alphas.push(1);
			}
			return alphas;
		}
		//
		protected function createShadow(shape:Object):void {
			if (shape.dropShadow == 'true') {
				var filter:DropShadowFilter = new DropShadowFilter(5, 45, 0x0F0F0F, 1, 5, 5, 1, 3, false, false, false);
				var filterArray:Array = new Array();
				filterArray.push(filter);
				filters = filterArray;
			} else {
				filters = [getShadowOptions(shape.dropShadow)];
			}
		}
		
		protected function getShadowOptions(ds_options:String):Object {
			var filter:DropShadowFilter = new DropShadowFilter();
			var ar:Array = convertToArray(ds_options);
			for (var key:* in ar) {
				filter[key] = ar[key];
			}
			return filter;
		}
		
		protected function convertToArray(t:String):Array {
			var mFilters:Array = new Array();
			var a:Array = t.split(",");
			var nL:int = a.length;
			for (var i:int = 0; i < nL; i++) { 
				var props:Array = String(a[i]).split(":");
				mFilters[props[0]] = props[1];
			}
			return mFilters;
		}
		
		public function getXY():Array {
			return new Array(this.x, this.y);
		}
		
		public function removeShape():void {
			graphics.clear();
		}
		
		protected function degreesToRadians(n:Number):Number	{
			return(Math.PI/180*n);
		}
	}
}