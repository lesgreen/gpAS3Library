package com.grasshopper.utils {
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	import flash.events.*;
	
	public class gpPreLoader extends Sprite { 
	
		//private var _mContainer:Sprite;
		private var _numCircles:Number = 15;
		//private var _color:Number;
		//private var centerX:Number = 200;
		//private var centerY:Number = 100;
		private var _radius:Number = 20;
		private var _angle:Number = _numCircles / 180;
		private var _radians:Number = (360 / _numCircles) * Math.PI / 180;
		private var _cnt:Number = 1;
		private var _circles:Array;
	
		public function gpPreLoader() {
			
		}
		
		public function init(nX:Number, nY:Number, radius:Number, color:Number):void {
			//_mContainer = new Sprite();
			//addChild(_mContainer);
			//_mContainer.x = 0;
			//_mConainter.y = 0;
			_radius = radius;
			_circles = new Array();
			for (var i = 0; i < _numCircles; i++) {
				_circles[i] = new Sprite();
				_circles[i].name = 'circle' + i;
				addChild(_circles[i]);
				drawCircle(_circles[i],2,color,100);
				_circles[i].x = nX + Math.sin(_radians * i) * _radius;
				_circles[i].y = nY + Math.cos(_radians * i) * _radius;
				_circles[i].alpha = 100 - i * (100 / _numCircles);
			}
			addEventListener( Event.ENTER_FRAME, onFrameUpdate );
			addEventListener(Event.REMOVED_FROM_STAGE, removeEvents, false, 0, true);
		}
		
		protected function onFrameUpdate(e:Event):void {
			for (var i = 0; i < _numCircles; i++) {
				if (_circles[i].alpha <= 0) {
					_circles[i].alpha = 100;
				}
				_circles[i].alpha -= 7;
			}
		}
		
		protected function drawCircle(sp:Sprite, radius:Number, fillColor:Number, fillAlpha:Number):void {
			var nX:Number = radius;
			var nY:Number = radius;
			with (sp) {
				graphics.beginFill(fillColor,fillAlpha);
				graphics.moveTo(nX + radius,nY);
				graphics.curveTo(radius + nX,Math.tan(Math.PI / 8) * radius + nY,Math.sin(Math.PI / 4) * radius + nX,Math.sin(Math.PI / 4) * radius + nY);
				graphics.curveTo(Math.tan(Math.PI / 8) * radius + nX,radius + nY,nX,radius + nY);
				graphics.curveTo(-Math.tan(Math.PI / 8) * radius + nX,radius + nY,-Math.sin(Math.PI / 4) * radius + nX,Math.sin(Math.PI / 4) * radius + nY);
				graphics.curveTo(-radius + nX,Math.tan(Math.PI / 8) * radius + nY,-radius + nX,nY);
				graphics.curveTo(-radius + nX,-Math.tan(Math.PI / 8) * radius + nY,-Math.sin(Math.PI / 4) * radius + nX,-Math.sin(Math.PI / 4) * radius + nY);
				graphics.curveTo(-Math.tan(Math.PI / 8) * radius + nX,-radius + nY,nX,-radius + nY);
				graphics.curveTo(Math.tan(Math.PI / 8) * radius + nX,-radius + nY,Math.sin(Math.PI / 4) * radius + nX,-Math.sin(Math.PI / 4) * radius + nY);
				graphics.curveTo(radius + nX,-Math.tan(Math.PI / 8) * radius + nY,radius + nX,nY);
				graphics.endFill();
			}
		}
		
		protected function removeEvents(e:Event):void {
			e.target.removeEventListener( Event.ENTER_FRAME, onFrameUpdate );
		}
	}
}