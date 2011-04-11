package model
{
	public class ApplicationViewModel
	{
		public static const PRELOAD_VIEW			: int = 0;
		public static const SITE_VIEW				: int = 1;
		
		[Bindable] public var message				: String = "";
		[Bindable] public var mainViewIndex			: int = PRELOAD_VIEW;
	}
}