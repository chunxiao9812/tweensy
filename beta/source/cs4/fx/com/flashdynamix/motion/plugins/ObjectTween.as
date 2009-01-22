package com.flashdynamix.motion.plugins {
	import com.flashdynamix.motion.TweensyTimeline;	

	/**
	 * This plugin is the default plugin and will be used when tweening Objects which don't have a custom plugin.
	 */
	public class ObjectTween extends AbstractTween {

		public static var key : Class = Object;

		private var _current : Object;
		protected var _to : Object;
		protected var _from : Object;
		internal var updateObject : Object;

		public function ObjectTween() {
			_to = {};
			_from = {};
		}

		override public function construct(currentObj : Object, updateObj : Object) : void {
			inited = false;
			_current = currentObj;
			updateObject = updateObj;
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

		override public function get current() : Object {
			return _current;
		}

		override public function get instance() : Object {
			return _current;
		}

		override public function toTarget(toObj : Object) : void {
			if(_current.hasOwnProperty("length")) {
				for(var i : int = 0;i < _current.length; i++) {
					if(!(_current[i] is Number) || !(_current[i] is String)) {
						timeline.to(_current[i], toObj, updateObject);
					} else {
						addTo(i.toString(), toObj[i]);
					}
				}
			} else {
				super.toTarget(toObj);
			}
		}

		override public function fromTarget(fromObj : Object) : void {
			if(_current.hasOwnProperty("length")) {
				for(var i : int = 0;i < _current.length; i++) {
					if(!(_current[i] is Number) || !(_current[i] is String)) {
						timeline.from(_current[i], fromObj, updateObject);
					} else {
						addFrom(i.toString(), fromObj[i]);
					}
				}
			
				apply();
			} else {
				super.fromTarget(fromObj);
			}
		}

		override public function fromToTarget(fromObj : Object, toObj : Object) : void {
			if(_current.hasOwnProperty("length")) {
				for(var i : int = 0;i < _current.length; i++) {
					if(!(_current[i] is Number) || !(_current[i] is String)) {
						timeline.fromTo(_current[i], fromObj, toObj, updateObject);
					} else {
						addFromTo(i.toString(), fromObj[i], toObj[i]);
					}
				}
			
				apply();
			} else {
				super.fromToTarget(fromObj, toObj);
			}
		}

		override public function update(position : Number) : void {
			var q : Number = 1 - position, propName : String, i : int = 0;
			
			if(!inited && _propCount > 0) {
				for(i = 0;i < _propCount; i++) {
					propName = propNames[i];
					_from[propName] = _current[propName];
				}
				inited = true;
			}
			
			for(i = 0;i < _propCount; i++) {
				propName = propNames[i];
				
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
