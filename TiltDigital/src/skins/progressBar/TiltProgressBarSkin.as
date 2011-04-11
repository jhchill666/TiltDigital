package skins.progressBar
{
	import mx.skins.halo.ProgressBarSkin;
	
	public class TiltProgressBarSkin extends ProgressBarSkin
	{
		/**
		 *  Constructor.
		 */
		public function TiltProgressBarSkin()
		{
			super();	
		}
	
	
	    /**
	     *  @private
	     */        
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			super.updateDisplayList(w, h);
	
			graphics.clear();

			drawRoundRect(
				0, 0, w, h, 0,
				[ 0xfc2137, 0xfc2137 ], 1,
				verticalGradientMatrix(0, 0, w - 2, h - 2));
		}
	}
}
