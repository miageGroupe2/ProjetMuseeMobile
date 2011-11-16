package modele
{
	public class Audio
	{
				
		private var id:int ;
		private var path:String ;
		
		public function Audio(id:int, path:String)
		{
			this.id = id ;
			this.path = path ;
		}
		
		
		public function getPath():String{
			
			return this.path;
		}
		
		
	}
}