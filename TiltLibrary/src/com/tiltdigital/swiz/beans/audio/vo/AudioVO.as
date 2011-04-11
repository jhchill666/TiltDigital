package com.tiltdigital.swiz.beans.audio.vo 
{
	import flash.media.*;
	import com.tiltdigital.swiz.beans.audio.model.AudioSettings;
	import com.tiltdigital.log.*;

	/**
	 * @author Jamie.Hill
	 */
	
	[Bindable]
	public class AudioVO
	{
		public var sound 					: Sound;
		public var id						: String;
		public var channel					: SoundChannel;
		public var transform				: SoundTransform;
		
		public var paused					: Boolean		= false;
		public var position					: Number		= 0;
		public var loops					: Number		= 0;

		private var _volume					: Number		= AudioSettings.DEFAULT_VOLUME;
		private var _mute					: Number		= AudioSettings.DEFAULT_MUTE;
		private var _pan					: Number		= AudioSettings.DEFAULT_PAN;
		private var _leftPeak				: Number		= AudioSettings.DEFAULT_VOLUME;
		private var _rightPeak				: Number		= AudioSettings.DEFAULT_VOLUME;
		
		
		/**
		 * Constructor --
		 */
		public function AudioVO( sound:Sound, id:String )
		{
			this.sound		= sound;
			this.id			= id;
		}
		
		
		
		/**
		 * Set/get the volume of the Sound
		 */
		public function set volume( val:Number ) : void
		{
			if( val == _volume ) return;
			
			_volume = val;
		
			setTransform( "volume", ( val * mute ));
		}
		public function get volume() : Number { return _volume; }
		
		
		
		/**
		 * Set/get whether the Sound is muted
		 */
		public function set mute( val:Number ) : void
		{
			if( val == _mute ) return;
					
			setTransform( "volume", ( volume * val ));

			_mute = val;
		}
		public function get mute() : Number { return _mute; }
		
		
		
		/**
		 * Set/get the pan of the Sound
		 */
		public function set pan( val:Number ) : void
		{
			if( val == _pan ) return;
		
			setTransform( "pan", _pan = val );
		}
		public function get pan() : Number { return _volume; }
		
		
		
		/**
		 * Set/get the left channel amplitude of the Sound
		 */
		public function set leftPeak( val:Number ) : void
		{
			if( val == _leftPeak ) return;
		
			_leftPeak = val;
		
			setTransform( "leftPeak", _leftPeak );
			setTransform( "rightPeak", _leftPeak );
		}
		public function get leftPeak() : Number { return _volume; }
		
		
		
		/**
		 * Set/get the right channel amplitude of the Sound
		 */
		public function set rightPeak( val:Number ) : void
		{
			if( val == _rightPeak ) return;
			
			_rightPeak = val;
		
			setTransform( "leftPeak", _rightPeak );
			setTransform( "rightPeak", _rightPeak );
		}
		public function get rightPeak() : Number { return _volume; }
		
		
		//_____________________________________________________________________ PRIVATE METHODS
		
		
		/**
		 * Set the new transform to the channels SoundTransform Object
		 * 
		 * @param prop				SoundTransform property to affect
		 * @param value				Value to set as the new property
		 */
		private function setTransform( prop:String, value:Number ) : void
		{
//			Logger.error( "AudioVO - "+prop +" : "+ value );
			
			var trans:SoundTransform		= transform;
			trans[ prop ] 					= value;
			channel.soundTransform 			= trans;
		}
	}
}



