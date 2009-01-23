﻿package com.flashdynamix.motion.plugins {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;	

	/**
	 * This plugin will be used when tweening MovieClips.<BR>
	 * This plugin also provides additional functionality to allow for tweening the currentFrame in a MovieClip.
	 */
	public class MovieClipTween extends AbstractTween {

		private var _current : MovieClip;
		protected var _to : MovieClipTweenObject;
		protected var _from : MovieClipTweenObject;

		public function MovieClipTween() {
			_to = new MovieClipTweenObject();
			_from = new MovieClipTweenObject();
		}

		override public function construct(...params : Array) : void {
			super.construct();
			
			_current = params[0];
		}

		override protected function set to(item : Object) : void {
			_to = item as MovieClipTweenObject;
		}

		override protected function get to() : Object {
			return _to;
		}

		override protected function set from(item : Object) : void {
			_from = item as MovieClipTweenObject;
		}

		override protected function get from() : Object {
			return _from;
		}

		override public function get current() : Object {
			return _current;
		}
		
		override public function match(item : AbstractTween) : Boolean {
			return (item is MovieClipTween && super.match(item));
		}

		override public function update(position : Number) : void {
			var q : Number = 1 - position;
			var propName:String;
			
			if(!inited && _propCount > 0) {
				for(propName in propNames) _from[propName] = _current[propName];
				inited = true;
			}
			
			for(propName in propNames) {
				
				if(propName == "x") {
					_current.x = _from.x * q + _to.x * position;
				} else if(propName == "y") {
					_current.y = _from.y * q + _to.y * position;
				} else if(propName == "width") {
					_current.width = _from.width * q + _to.width * position;
				} else if(propName == "height") {
					_current.height = _from.height * q + _to.height * position;
				} else if(propName == "scaleX") {
					_current.scaleX = _from.scaleX * q + _to.scaleX * position;
				} else if(propName == "scaleY") {
					_current.scaleY = _from.scaleY * q + _to.scaleY * position;
				} else if(propName == "alpha") {
					_current.alpha = _from.alpha * q + _to.alpha * position;
				} else if(propName == "rotation" ) {
					_current.rotation = _from.rotation * q + _to.rotation * position;
				} else if(propName == "currentFrame") {
					_current.gotoAndStop(Math.round(_from.currentFrame * q + _to.currentFrame * position));
				} else {
					_current[propName] = from[propName] * q + to[propName] * position;
				}
				
				if(timeline.snapToClosest) _current[propName] = Math.round(_current[propName]);
			}
		}

		override protected function translate(propName : String, value : *) : Number {
			var current : Number = _current[propName];
			var target : Number = super.translate(propName, value);
			
			if(propName == "rotation" && timeline.smartRotate) {
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

internal dynamic class MovieClipTweenObject {
	public var x : Number;
	public var y : Number;
	public var alpha : Number;
	public var width : Number;
	public var height : Number;
	public var scaleX : Number;
	public var scaleY : Number;
	public var rotation : Number;
	public var currentFrame : Number;
}