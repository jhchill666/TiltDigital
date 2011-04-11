package com.tiltdigital.swiz.beans.audio.controllers.adjustments
{
	import com.tiltdigital.tools.MathsTools;
	import flash.media.SoundTransform;
	import mx.effects.easing.*;
	import com.tiltdigital.swiz.beans.audio.controllers.adjustments.*;
	import com.tiltdigital.swiz.beans.audio.vo.AudioVO;
	
	public class Pan extends AdjustmentBase
	{
		/**
		 * Constructor --
		 * 
		 * The Pan IAdjustment represents an adjustment applied to a Sounds SoundTransform object.
		 * 
		 * @param target		The target SoundTransform to apply the IAdjustment to
		 * @param duration 		The duration of the IAdjustment ( use seconds )
		 * @param finish		The value you want to finish the IAdjustment at
		 * @param begin			[optional] The value you want to start the IAdjustment from
		 * @param ease			[optional] Easing function 
		 */
		public function Pan( finish:Number, duration:Number = 0, begin:Number = 0, ease:Function = null )
		{
			var finishValue:int, easing:Function;
			
			finishValue	= MathsTools.clamp( finish, -1, 1 );
			begin		= MathsTools.clamp( begin,  -1, 1 );
			easing		= ( ease != null ) ? ease : Linear.easeNone;
			
			super( "pan", finishValue, duration, begin, easing );
		}
		
		
		
		/**
		 * Explicitly set the target of this IAdjustment
		 */
		override public function setTarget( vo:AudioVO ) : IAdjustment
		{
			_target					= vo;
			_target[ _property ] 	= _begin;
			
			return ( this as IAdjustment );
		}
	}
}