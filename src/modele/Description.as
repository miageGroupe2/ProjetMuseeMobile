package modele
{
	public class Description
	{
		private var id:int ;
		private var idOeuvre:int ;
		private var annee:int ;
		private var type:String;
		private var auteur:String;
		private var histoire:String;
		
		public function Description(id:int, idOeuvre:int, annee:int, auteur:String, type:String, histoire:String)
		{
			this.id = id ;
			this.idOeuvre = idOeuvre;
			this.annee = annee ;
			this.histoire = histoire;
			this.auteur = auteur;
			this.type = type;
			
		}
		
		public function getAnnee():int{
			
			return this.annee;
		}
		public function getType():String{
			
			return this.type;
		}
		public function getAuteur():String{
			
			return this.auteur;
		}
		public function getHistoire():String{
			
			return this.histoire;
		}
		
		
		public function toString():String{
			
			var retour:String = "toString description :"+this.annee;
			return retour ;
		}
	}
}