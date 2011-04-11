package com.tiltdigital.swiz.beans.audio.controllers
{
	import com.tiltdigital.swiz.beans.audio.model.AudioChannels;
	import com.tiltdigital.swiz.beans.audio.model.AudioCache;
	import com.tiltdigital.swiz.beans.audio.vo.AudioVO;
	import org.swizframework.controller.*;
	import flash.media.SoundTransform;
	import flash.events.Event;
	import com.tiltdigital.swiz.beans.audio.controllers.adjustments.IAdjustment;
	import flash.media.*;
	import com.tiltdigital.log.*;

	public class AudioMixer extends AbstractController
	{	
		
		[Autowire( bean="audioModel", property="audio" )]
		public var audioCache 				: AudioCache;
		
		[Autowire( bean="audioModel", property="channels" )]
		public var channels 				: AudioChannels;
		
		
		/**
		 * Constructor --
		 */
		public function AudioMixer ()
		{
			super();
		}
		
		
		
		//____________________________________________________________________ PUBLIC METHODS
		
		
		
		/**
		 * Play an Audio file
		 * 
		 * @param id			Id of the audio file to play
		 * @param startTime		[optional] The initial position in milliseconds at which playback should start
		 * @param loops			[optional] Number of times a sound loops to the startTime before sound stops
		 * @param adj			[optional] Apply an IAjustment to the sound eg. to fade the sound in
		 * 
		 * @return AudioVO
		 */
		public function play ( id:String, startTime:int = 0, loops:int = 0, adj:IAdjustment = null ) : AudioVO
		{
			var vo:AudioVO	= audioCache.get( id ) as AudioVO;
			
			Logger.info( "Playing:"+id );

			vo.channel		= ( vo.sound as Sound ).play( startTime, loops );
			vo.transform	= new SoundTransform();
			vo.position		= 0; vo.loops = loops;
			
			channels.add( vo ); if( adj ) adjust( adj, id ); //add channel and apply an audio adjustment
			
			return ( vo as AudioVO );
		}
		
		
		
		/**
		 * Pause a playing Audio file ( plays a paused audio file! )
		 * 
		 * @param id			Id of the audio file to play
		 * @param adj			[optional] Apply an IAjustment to the sound eg. to fade the sound out
		 */
		public function pause ( id:String, adj:IAdjustment = null ) : void
		{
			var paused:Boolean, vo:AudioVO = channels.get( id ) as AudioVO;
			
			Logger.info( "Pause:"+id );
			
			if( vo != null ) 
			{	
				vo.position = vo.channel.position;
				
				if( adj != null )	
				{
					adj.setTarget	( vo );
					adj.setCallback	( stop, [ vo.id ] ).apply();
					
				} else stop( vo.id );
			
			} else
			
			{
				vo = audioCache.get( id ) as AudioVO;
				play( id, vo.position, vo.loops, adj );
			}
		}
		
		
		
		/**
		 * Stop all Audio files playing
		 * 
		 * @param adj			[optional] Apply an IAjustment to all sounds eg. to fade all sounds out
		 */
		public function stopAll ( adj:IAdjustment = null ) : void
		{
			Logger.info( "StopAll" );
			
			for each( var vo:AudioVO in channels.toArray() ) 
			{
				if( adj != null )
				{
					adj.setTarget	( vo );
					adj.setCallback	( stop, [ vo.id ] ).apply();
					
				} else stop( vo.id );
			}
		}
		
		
		
		/**
		 * Stops an Audio file playing
		 * 
		 * @param id			Id of the audio file to play, if none specified ALL audio will be stopped!
		 * @param adj			[optional] Apply an IAjustment to the sound eg. to fade the sound out
		 */
		public function stop ( id:String, adj:IAdjustment = null ) : void
		{
			var vo:AudioVO 			= channels.get( id ) as AudioVO;
			
			Logger.info( "Stop:"+id );
			
			if( vo != null );
			{
				if( adj != null )
				{
					adj.setTarget	( vo );
					adj.setCallback	( killChannel, [ vo ] ).apply();
					
				} else killChannel( vo );
			}
		}
		
		
		
		/**
		 * Apply an effect to one or all AudioVO's. The Sound will
		 * be started with the IEffect if not already playing
		 * 
		 * @param adj 			An IAdjustment audio adjustment to apply to the Sound
		 * @param id			Id for the Sound we want o apply the effect to
		 */
		public function adjust ( adj:IAdjustment, id:String ) : void
		{
			var vo:AudioVO 		= channels.get( id ) as AudioVO;
			
			Logger.info( "Adjust:"+id );
			
			if( vo != null )	adj.setTarget( vo ).apply();
			else 				play( id, 0, 0, adj );
		}
		
		
		
		//____________________________________________________________________ PRIVATE METHODS
		
		
		
		
		/**
		 * Kill a specific channel from the mixers current AudioChannels
		 */
		private function killChannel( vo:AudioVO ) : void
		{
			vo.channel.stop();
			
			try{ vo.sound.close(); } catch( er:* ) {}
			
			vo.channel 		= null;
			vo.transform 	= null;
	
			channels.remove( vo );	
		}
		
		
		
		/**
		 * Retrieve the target property froom the AudioVO to be adjusted
		 */
		private function getAdjustmentTarget ( adj:IAdjustment, vo:AudioVO ) : *
		{
			var target:*;
			
			switch( IAdjustment( adj ).getProp() )
			{
				case "volume" : 	target = vo.transform; 	break
				case "rightPeak" : 	target = vo.channel; 	break;
				case "leftPeak" : 	target = vo.channel; 	break;
				case "pan" : 		target = vo.transform; 	break;
			}
			return target;
		}
	}
}