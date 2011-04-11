package skins.progressBar
{
	import flash.display.Graphics;
	
	import mx.skins.halo.ProgressMaskSkin;

	public class TiltProgressMaskSkin extends ProgressMaskSkin
	{
		/**
		 *  Constructor.
		 */
		public function TiltProgressMaskSkin()
		{
			super();		
		}
	
	
	    /**
	     *  @private
	     */        
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			super.updateDisplayList(w, h);

	        // draw the mask
	        var g:Graphics = graphics;
	        g.clear();
	        g.beginFill(0xFFFF00);
	        g.drawRect(0, 0, w, h);
	        g.endFill();
		}
	}

}
