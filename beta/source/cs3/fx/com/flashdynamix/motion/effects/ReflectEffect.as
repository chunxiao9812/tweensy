package com.flashdynamix.motion.effects {	import flash.display.BitmapData;	import flash.display.BlendMode;	import flash.display.GradientType;	import flash.display.Graphics;	import flash.display.InterpolationMethod;	import flash.display.Shape;	import flash.display.SpreadMethod;	import flash.geom.ColorTransform;	import flash.geom.Matrix;	import flash.geom.Point;	import flash.geom.Rectangle;	import com.flashdynamix.motion.effects.IEffect;		/**	 * @author FlashDynamix	 */	public class ReflectEffect implements IEffect {		public var floorArea : Rectangle;		public var ct : ColorTransform;		public var theMask : Shape;		private var pt : Point;		public function ReflectEffect(floorArea : Rectangle, ct : ColorTransform, alphas : Array = null, ratios : Array = null) {			this.floorArea = floorArea;			this.ct = ct;						alphas = (alphas) ? alphas : [0,1];			ratios = (ratios) ? ratios : [0,0xFF];						var colors : Array = [];			for(var i : int = 0;i < alphas.length; i++) colors.push(0xFF0000);						pt = new Point();			theMask = new Shape();						var mtx : Matrix = new Matrix();			mtx.createGradientBox(floorArea.width, floorArea.height, 90 * (Math.PI / 180));						var vector : Graphics = theMask.graphics;			vector.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, mtx, SpreadMethod.PAD, InterpolationMethod.RGB);			vector.drawRect(0, 0, floorArea.width, floorArea.height);			vector.endFill();		}		public function render(bmd : BitmapData) : void {			var mtx : Matrix = new Matrix();			mtx.scale(1, -1);			mtx.ty = floorArea.y * 2;						var transMtx : Matrix = new Matrix();			transMtx.ty = floorArea.y - floorArea.height;			var floorBmd : BitmapData = bmd.clone();			floorBmd.draw(theMask, transMtx, null, BlendMode.ALPHA);						bmd.draw(floorBmd, mtx, ct);		}
	}}