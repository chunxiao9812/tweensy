package com.flashdynamix.motion.plugins {
	import flash.display.DisplayObject;		
	/**
	 * This plugin will be used when tweening DisplayObjects.
	 */
	public class DisplayTween extends AbstractTween {
		private var _current : DisplayObject;
		protected var _to : DisplayTweenObject;
		protected var _from : DisplayTweenObject;
		public function DisplayTween() {
			_to = new DisplayTweenObject();
			_from = new DisplayTweenObject();
		}
		override public function construct(...params : Array) : void {
			super.construct();
			
			_current = params[0];
		}
		override protected function set to(item : Object) : void {
			_to = item as DisplayTweenObject;
		}
		override protected function get to() : Object {
			return _to;
		}
		override protected function set from(item : Object) : void {
			_from = item as DisplayTweenObject;
		}
		override protected function get from() : Object {
			return _from;
		}
		override public function get key() : Object {
			return _current;
		}
		override protected function get current() : Object {
			return _current;
		}
		override public function update(position : Number) : void {
			var q : Number = 1 - position;
			var propName : String;
			
			if(!inited && _propCount > 0) {
				for(propName in propNames) _from[propName] = _current[propName];
				inited = true;
			}
			
			for(propName in propNames) {

				if(propName == "x") {
					_current.x = _from.x * q + _to.x * position;
				} else if(propName == "y") {
					_current.y = _from.y * q + _to.y * position;
				} else if(propName == "z") {
					_current.z = _from.z * q + _to.z * position;
				}else if(propName == "width") {
					_current.width = _from.width * q + _to.width * position;
				} else if(propName == "height") {
					_current.height = _from.height * q + _to.height * position;
				} else if(propName == "scaleX") {
					_current.scaleX = _from.scaleX * q + _to.scaleX * position;
				} else if(propName == "scaleY") {
					_current.scaleY = _from.scaleY * q + _to.scaleY * position;
				} else if(propName == "scaleZ") {
					_current.scaleZ = _from.scaleZ * q + _to.scaleZ * position;
				} else if(propName == "alpha") {
					_current.alpha = _from.alpha * q + _to.alpha * position;
				} else if(propName == "rotation" ) {
					_current.rotation = _from.rotation * q + _to.rotation * position;
				} else if(propName == "rotationX" ) {
					_current.rotationX = _from.rotationX * q + _to.rotationX * position;
				} else if(propName == "rotationY" ) {
					_current.rotationY = _from.rotationY * q + _to.rotationY * position;
				} else if(propName == "rotationZ" ) {
					_current.rotationZ = _from.rotationZ * q + _to.rotationZ * position;
				} else {
					_current[propName] = _from[propName] * q + _to[propName] * position;
				}
				
				if(timeline.snapToClosest) _current[propName] = Math.round(_current[propName]);
			} 
		}
		override protected function translate(propName : String, value : *) : Number {
			var current : Number = _current[propName];
			var target : Number = super.translate(propName, value);
			
			if(propName == "rotation" && timeline.useSmartRotate) {
				target = smartRotate(current, target);
			}
			
			return target;
		}
		override public function dispose() : void {
			_to = null;
			_from = null;
			_current = null;
			
			super.dispose();
		}
	}
}
internal dynamic class DisplayTweenObject {
	public var x : Number;
	public var y : Number;
	public var z : Number;
	public var alpha : Number;
	public var width : Number;
	public var height : Number;
	public var scaleX : Number;
	public var scaleY : Number;
	public var scaleZ : Number;
	public var rotation : Number;
	public var rotationX : Number;
	public var rotationY : Number;
	public var rotationZ : Number;
}