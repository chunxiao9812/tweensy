package {	import flash.display.BlendMode;	import flash.display.Sprite;	import flash.events.Event;	import flash.filters.BlurFilter;	import flash.geom.ColorTransform;	import flash.geom.Matrix;	import flash.utils.getDefinitionByName;		import com.flashdynamix.motion.effects.core.*;	import com.flashdynamix.motion.extras.Emitter;	import com.flashdynamix.motion.layers.BitmapLayer;	import com.flashdynamix.utils.SWFProfiler;		/**	 * @author shanem	 */	public class ElectroBoltFX extends Sprite {		private var emit1 : Emitter;		private var emit2 : Emitter;		public function ElectroBoltFX() {						SWFProfiler.init(this);						//stage.quality = StageQuality.LOW;			var Lightning1 : Class = getDefinitionByName("Lightning1") as Class;			var Lightning2 : Class = getDefinitionByName("Lightning2") as Class;			var Swirl1 : Class = getDefinitionByName("Swirl1") as Class;						var obj : Object = {alpha:0, rotation:"-180, 180"};			emit1 = new Emitter(Lightning1, obj, 1, 0.5, "0,360", 20, 1);			emit1.blendMode = BlendMode.ADD;			emit1.alpha = 0.3;			emit1.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 23, -50, 50);			emit2 = new Emitter(Swirl1, obj, 1, 0.5, "0,360", 50, 1);			emit2.blendMode = BlendMode.ADD;			emit2.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 150, -200, 200);						var layer : BitmapLayer = new BitmapLayer(150, 150, 1, 0x000000, false, false);						layer.x = 200;			layer.y = 125;						var mtx : Matrix = new Matrix();			mtx.tx = 75;			mtx.ty = 75;						layer.add(new ColorEffect(new ColorTransform(1, 1, 1, 0.97)));			layer.add(new FilterEffect(new BlurFilter(8, 8, 2)));						layer.draw(emit2.holder, mtx);			layer.draw(emit1.holder, mtx);						addChild(layer);						this.addEventListener(Event.ENTER_FRAME, draw);		}		private function draw(e : Event) : void {			emit1.rotation = -180 + 360 * Math.random();			emit2.rotation = -180 + 360 * Math.random();		}	}}