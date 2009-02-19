﻿package com.flashdynamix.motion.plugins {
	import com.flashdynamix.motion.TweensyTimeline;	

	/**
	 * This abstract tween class provides necessary functionality to the typed plugin
	 * tweens.
	 */
	public class AbstractTween {

		protected var inited : Boolean = false;
		public var timeline : TweensyTimeline;
		/** @private */
		internal var propNames : Array;
		protected var _propCount : int = 0;

		public function AbstractTween() {
			propNames = [];
		}

		public function construct(currentObj : Object, updateObj : Object) : void {
			inited = false;
		}

		public function set to(item : Object) : void {
		}

		public function get to() : Object {
			return null;
		}

		public function set from(item : Object) : void {
		}

		public function get from() : Object {
			return null;
		}

		public function get current() : Object {
			return null;
		}

		public function get instance() : Object {
			return current;
		}

		protected function get properties() : Number {
			return _propCount;
		}

		public function get hasAnimations() : Boolean {
			return (_propCount > 0);
		}

		public function get toProps() : Object {
			var obj : Object = {};
			
			for each(var propName:String in propNames) obj[propName] = to[propName];
			
			return obj;
		}
		
		public function get fromProps() : Object {
			var obj : Object = {};
			
			for each(var propName:String in propNames) obj[propName] = from[propName];
			
			return obj;
		}

		public function toTarget(toObj : Object) : void {
			for(var propName:String in toObj) {
				trace(propName);
				addTo(propName, toObj[propName]);
			}
			
			apply();
		}

		public function fromTarget(fromObj : Object) : void {
			for(var propName:String in fromObj) {
				addFrom(propName, fromObj[propName]);
			}
			
			apply();
		}

		public function fromToTarget(fromObj : Object, toObj : Object) : void {
			for(var propName:String in fromObj) {
				addFromTo(propName, fromObj[propName], toObj[propName]);
			}
			
			apply();
		}

		public function updateTo(position : Number, toObj : Object) : Array {
			var updated : Array = [];
			
			for(var propName:String in toObj) {
				if(has(propName)) {
					var target : Number = translate(current[propName], toObj[propName]);
					var change : Number = (target - current[propName]) * (1 / (1 - position));
					
					from[propName] = target - change;
					to[propName] = target;
					updated.push(propName);
				}
			}
			
			return updated;
		}

		public function removeOverlap(item : AbstractTween) : void {
			if(match(item)) {
				stop.apply(null, item.propNames);
			}
		}

		public function updateOverlap(position : Number, item : AbstractTween) : Array {
			if(match(item)) {
				return updateTo(position, item.toProps);
			}
			
			return null;
		}

		public function stop(...props : Array) : void {
			
			if(props.length == 0) {
				stopAll();
			} else {
				var len : int = props.length;
				var i : int;
			
				for(i = 0;i < len; i++) remove(props[i]);
			}
		}

		public function stopAll() : void {
			propNames.length = 0;
			
			_propCount = 0;
		}

		public function update(position : Number) : void {
		}

		public function swapToFrom() : void {
			var toCopy : Object = to;
			
			to = from;
			from = toCopy;
		}

		public function addTo(propName : String, target : *) : void {
			to[propName] = translate(current[propName], target);
			
			propNames[_propCount] = propName;
			_propCount++;
		}

		public function addFrom(propName : String, target : *) : void {
			to[propName] = current[propName];
			current[propName] = translate(current[propName], target);
			
			propNames[_propCount] = propName;
			_propCount++;
		}

		public function addFromTo(propName : String, fromTarget : *, toTarget : *) : void {
			current[propName] = translate(current[propName], fromTarget);
			to[propName] = translate(current[propName], toTarget);
			
			propNames[_propCount] = propName;
			_propCount++;
		}

		public function remove(propName : String) : void {
			var index : int = propNames.indexOf(propName);
			if(index != -1) {
				propNames.splice(index, 1);
				_propCount--;
			}
		}

		public function clear() : void {
			stopAll();
			timeline = null;
		}

		protected function has(propName : String) : Boolean {
			return propNames.indexOf(propName) >= 0;
		}

		protected function match(item : AbstractTween) : Boolean {
			return item.instance == instance;
		}

		protected function apply() : void {
		}

		protected function translate(current : Number, value : *) : Number {
			
			var target : Number;
			
			if(value is String) {
				var values : Array = String(value).split(",");
				if(values.length == 1) {
					target = current + parseFloat(value);
				} else {
					var start : Number = parseFloat(values[0]), end : Number = parseFloat(values[1]);
					target = current + start + (Math.random() * (end - start));
				}
			} else {
				target = value;
			}
			
			return target;
		}

		protected function smartRotate(currentAngle : Number, targetAngle : Number) : Number {
			var pi : Number = 180;
			var pi2 : Number = pi * 2;
				
			currentAngle = (Math.abs(currentAngle) > pi2) ? (currentAngle < 0) ? currentAngle % pi2 + pi2 : currentAngle % pi2 : currentAngle;

			targetAngle = (Math.abs(targetAngle) > pi2) ? (targetAngle < 0) ? targetAngle % pi2 + pi2 : targetAngle % pi2 : targetAngle;
			targetAngle += (Math.abs(targetAngle - currentAngle) < pi) ? 0 : (targetAngle - currentAngle > 0) ? -pi2 : pi2;
			
			return targetAngle;
		}

		public function dispose() : void {
			propNames = null;
			timeline = null;
		}
	}
}