package com.flashdynamix.motion.plugins {	import flash.display.Sprite;	import flash.media.SoundChannel;	import flash.media.SoundTransform;		/**	 * This plugin will be used when tweening SoundTransforms.	 */	public class SoundTween extends AbstractTween {		private var _current : SoundTransform;		protected var _to : SoundTransform;		protected var _from : SoundTransform;		protected var _update : *;		public function SoundTween() {			_to = new SoundTransform();			_from = new SoundTransform();		}		override public function construct(...params : Array) : void {			super.construct();						_current = params[0];			_update = params[1];			apply();		}		override protected function set to(item : Object ) : void {			_to = item as SoundTransform;		}
		override protected function get to() : Object {			return _to;		}
		override protected function set from(item : Object) : void {			_from = item as SoundTransform;		}
		override protected function get from() : Object {			return _from;		}		override public function get key() : Object {			if(_update != null) return _update;						return _current;		}
		override protected function get current() : Object {			return _current;		}
		override public function toTarget(to : Object) : void {			if(to is SoundTransform) {				var st : SoundTransform = to as SoundTransform;							add("volume", st.volume, false);				add("pan", st.pan, false);			} else {				super.toTarget(to);			}		}
		override public function fromTarget(from : Object) : void {			if(from is SoundTransform) {				var st : SoundTransform = from as SoundTransform;							add("volume", st.volume, true);				add("pan", st.pan, true);			} else {				super.fromTarget(from);			}		}
		override public function update(position : Number) : void {			var q : Number = 1 - position;						if(!inited && _propCount > 0) {				for(propName in propNames) _from[propName] = _current[propName];				inited = true;			}						for(var propName:String in propNames) {								if(propName == "volume") {					_current.volume = _from.volume * q + _to.volume * position;				} else if(propName == "pan") {					_current.pan = _from.pan * q + _to.pan * position;				} else {					_current[propName] = _from[propName] * q + _to[propName] * position;				}								if(timeline.snapToClosest) _current[propName] = Math.round(_current[propName]);			}						apply();		}
		override public function apply() : void {			if(_update == null) return;						if(_update is Sprite) {				Sprite(_update).soundTransform = _current;			} else {				SoundChannel(_update).soundTransform = _current;			}		}		override public function dispose() : void {			_to = null;			_from = null;			_current = null;			_update = null;						super.dispose();		}	}}