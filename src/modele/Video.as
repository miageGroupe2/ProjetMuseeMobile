package modele
{
	public class Video
	{
		private var id:int ;
		private var nom:String ;
		private var path:String ;
		private var description:String ;
		
		public function Video(id:int, nom:String, path:String, description:String)
		{
			this.id = id ;
			this.nom = nom ;
			this.path = path ;
			this.description = description ;
		}
		
		public function toString():String{
			
			var retour:String = "toString video :"+this.nom;
			return retour ;
		}
		
		public function getPath():String{
			
			return this.path;
		}
		
		public function getNom():String{
			
			return this.nom ;
		}
		public function getDescription():String{
			
			return this.description ;
		}
	}
}