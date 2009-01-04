package com.flashdynamix.motion.plugins {
	import com.flashdynamix.motion.TweensyTimeline;	

	/**
	 * This plugin is the default plugin and will be used when tweening Objects which don't have a custom plugin.
	 */
	public class ObjectTween extends AbstractTween {

		private var _current : Object;
		protected var _to : Object;
		protected var _from : Object;

		public function ObjectTween() {
			_to = {};
			_from = {};
		}

		override public function construct(...params : Array) : void {
			super.construct();
			
			_current = params[0];
		}

		override protected function set to(item : Object) : void {
			_to = item;
		}

		override protected function get to() : Object {
			return _to;
		}

		override protected function set from(item : Object) : void {
			_from = item;
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

		override public function removeOverlap(item : AbstractTween) : void {
			if(item is ObjectTween) super.removeOverlap(item);
		}

		override public function update(position : Number) : void {
			var q : Number = 1 - position;
			
			if(!inited && _propCount > 0) {
				for(propName in propNames) _from[propName] = _current[propName];
				inited = true;
			}
			
			for(var propName:String in propNames) {
				
				_current[propName] = from[propName] * q + to[propName] * position;
				
				if(timeline.snapToClosest) _current[propName] = Math.round(_current[propName]);
			}
		}

		override public function dispose() : void {
			_to = null;
			_from = null;
			_current = null;
			
			super.dispose();
		}
	}
}
