package com.tiltdigital.swiz.beans.audio.controllers.adjustments
{
	import com.tiltdigital.tools.MathsTools;
	import flash.media.SoundTransform;
	import mx.effects.easing.*;
	import com.tiltdigital.swiz.beans.audio.controllers.adjustments.*;
	import com.tiltdigital.swiz.beans.audio.vo.AudioVO;
	import gs.*;
	import gs.utils.tween.*;
	import gs.easing.*;
	import com.tiltdigital.log.*;
	
	public class Mute extends AdjustmentBase
	{
		/**
		 * Constructor --
		 * 
		 * The Mute IAdjustment represents a mute adjustment applied to a Sounds SoundTransform object.
		 * 
		 * @param finish		True to mute the audio, false to unmute
		 * @param duration		Length of fade in/out.  Default set to nominally small amount to prevent 'mute click!'
		 */
		public function Mute( finish:Boolean = true, duration:Number = 0.7 )
		{
			super( "mute", int( !finish ), duration );
		}
		
		
		
		/**
		 * Explicitly set the target of this IAdjustment
		 */
		override public function setTarget( vo:AudioVO ) : IAdjustment
		{
			_target	= vo;
			
			return ( this as IAdjustment );
		}
	}
}