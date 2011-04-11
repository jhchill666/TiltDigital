package com.tiltdigital.swiz.beans.audio.controllers.adjustments
{
	import com.tiltdigital.log.*;
	import com.tiltdigital.swiz.beans.audio.controllers.adjustments.*;
	import com.tiltdigital.swiz.beans.audio.vo.AudioVO;
	import com.tiltdigital.tools.MathsTools;
	
	import gs.TweenLite;
	import gs.utils.tween.TweenLiteVars;

	public class AdjustmentBase implements IAdjustment
	{
		protected var _target			: AudioVO;
		protected var _property			: String;
		protected var _finish			: int;
		protected var _duration			: int;
		protected var _begin			: int;
		protected var _ease				: Function;
		protected var _callback			: Function;
		protected var _callbackParams	: Array;
		
		/**
		 * Constructor --
		 */
		public function AdjustmentBase( property:String, finish:Number = 0, duration:Number = 0, begin:Number = -1, ease:Function = null )
		{
			_property				= property;
			_finish					= finish;
			_duration				= duration;
			_begin					= begin;
			_ease					= ease;
		}
		
		
		
		/**
		 * Explicitly set the target of this IAdjustment
		 */
		public function setTarget( vo:AudioVO ) : IAdjustment
		{
			_target					= vo;
			
			_begin					= ( _begin == -1 ) ? _target[ _property ] : _begin;
			_begin					= MathsTools.clamp( _begin, 0, 1 );
			
			_target[ _property ] 	= _begin;
			
			return ( this as IAdjustment );
		}
		
		
		
		/**
		 * Explicitly set a callback method to be invoked when the adjustment is complete
		 * 
		 * @param callback		Callback method to invoke
		 * @param rest			Additional parameters to pass to the callback method
		 */
		public function setCallback( callback:Function, ...rest ) : IAdjustment
		{
			_callback				= callback;
			_callbackParams			= rest;
			
			return ( this as IAdjustment );
		}
		
		
		
		/**
		 * Get the property that will be effected by the IAdjustment
		 */
		public function getProp() : String
		{
			return _property;
		}
		

		
		/**
		 * Apply the IAdjustment to the target
		 */
		public function apply () : void
		{
			var tweenVars:TweenLiteVars;

			tweenVars 					= new TweenLiteVars();
			tweenVars.onComplete 		= _callback;
			tweenVars.onCompleteParams 	= _callbackParams;
			tweenVars.addProp( _property, _finish ); 
			
			TweenLite.to( _target, _duration, tweenVars );
		}
	}
}