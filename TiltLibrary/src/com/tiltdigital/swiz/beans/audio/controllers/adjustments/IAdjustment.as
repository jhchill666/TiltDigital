package com.tiltdigital.swiz.beans.audio.controllers.adjustments
{
	import com.tiltdigital.swiz.beans.audio.controllers.adjustments.IAdjustment;
	import com.tiltdigital.swiz.beans.audio.vo.AudioVO;
	
	/**
	 * @author Jamie.Hill
	 */
	public interface IAdjustment
	{
		/**
		 * Explicitly set the target of this IAdjustment
		 */
		function setTarget ( vo:AudioVO ) : IAdjustment
		
		/**
		 * Explicitly set a callback method to be invoked when the adjustment is complete
		 * 
		 * @param callback		Callback method to invoke
		 * @param rest			Additional parameters to pass to the callback method
		 */
		function setCallback ( callback:Function, ...rest ) : IAdjustment;
		
		/**
		 * Get the property that will be effected by the IAdjustment
		 */
		function getProp () : String;
		
		/**
		 * Apply the IAdjustment to the target
		 */
		function apply () : void;
	}
}