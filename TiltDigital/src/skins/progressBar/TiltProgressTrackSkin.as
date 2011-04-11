package skins.progressBar
{
	import mx.skins.halo.ProgressTrackSkin;

	public class TiltProgressTrackSkin extends ProgressTrackSkin
	{
		/**
		 *  Constructor.
		 */
		public function TiltProgressTrackSkin()
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
				[ 0x40777d, 0x40777d ], 1,
				verticalGradientMatrix(0, 0, w, h));
		}
	}
}
