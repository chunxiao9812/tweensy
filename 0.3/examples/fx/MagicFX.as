﻿package {	import flash.display.*;	import flash.events.*;	import flash.filters.BlurFilter;	import flash.geom.ColorTransform;	import flash.utils.getDefinitionByName;		import com.flashdynamix.motion.*;	import com.flashdynamix.motion.effects.core.*;	import com.flashdynamix.motion.extras.Emitter;	import com.flashdynamix.motion.layers.BitmapLayer;	import com.flashdynamix.utils.SWFProfiler;	/**	 * @author shanem	 */	public class MagicFX extends Sprite {		private var tween : TweensyGroup;		private var emittor : Emitter;		private var layer : BitmapLayer;		private var ct : ColorTransform;		private var bf : BlurFilter;		private var tx : Number;		private var ty : Number;		public function MagicFX() {			SWFProfiler.init(this);						tween = new TweensyGroup(false, true);			bf = new BlurFilter(10, 10, 2);			ct = new ColorTransform(1, 1, 1, 1, -115, -30, 70);						layer = new BitmapLayer(550, 400);			layer.add(new ColorEffect(new ColorTransform(1, 1, 1, 0.9)));			layer.add(new FilterEffect(bf));						stage.quality = StageQuality.LOW;						tx = 275;			ty = 200;						var Box : Class = getDefinitionByName("Box") as Class;						emittor = new Emitter(Box, null, 2, 1, "0, 360", "1, 110", 1, BlendMode.ADD);			emittor.transform.colorTransform = ct;			emittor.endColor = new ColorTransform(1, 1, 1, 1, 255, -255, -70, -255);						layer.draw(emittor.holder);						addChildAt(layer, 0);						addEvent(stage, Event.ENTER_FRAME, draw);			addEvent(stage, MouseEvent.MOUSE_MOVE, move);		}				private function move(e : MouseEvent) : void {			tx = stage.mouseX;			ty = stage.mouseY;		}		private function draw(e : Event) : void {			emittor.rotation += 20;			emittor.x += (tx - emittor.x) / 4;			emittor.y += (ty - emittor.y) / 4;		}		protected function addEvent(item : EventDispatcher, type : String, liststener : Function, priority : int = 0, useWeakReference : Boolean = true) : void {			item.addEventListener(type, liststener, false, priority, useWeakReference);		}		protected function removeEvent(item : EventDispatcher, type : String, listener : Function) : void {			item.removeEventListener(type, listener);		}	}}