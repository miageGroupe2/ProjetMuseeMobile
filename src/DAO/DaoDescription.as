package DAO
{
	import Controleur.ControleurPrincipal;
	
	import modele.Description;
	import modele.Oeuvre;
	
	import mx.collections.ArrayList;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import spark.components.TextInput;
	
	public class DaoDescription
	{
		
		private var httpService:HTTPService ;
		private var xmlList:XMLList;
		private var oeuvre:Oeuvre;
		private var resultatRequete:Object ;
		
		public function DaoDescription(oeuvre:Oeuvre)
		{

			this.oeuvre = oeuvre ;
			this.httpService = new HTTPService();
			
			this.httpService.addEventListener("result", httpResult);
			this.httpService.addEventListener("fault", httpFault); 
			this.httpService.resultFormat = "e4x"; 
			this.httpService.url = "http://localhost/linkProjetMusee.php?table=description&idOeuvre="+oeuvre.getId() ;
			this.httpService.send();
		}
		
		private function httpResult(event:ResultEvent):void { 
			
			this.resultatRequete = event.result ;
			
			var xml:XML= new XML(this.resultatRequete.toString());
			var xmlList: XMLList = xml.child("row");
			
			var id:int= xmlList[0].id ;
			var idOeuvre:int= xmlList[0].idOeuvre ;
			
			var tmp:String = xmlList[0].xml;
			var xmlDescription:XML= new XML(tmp) ;
			
			xmlList = xmlDescription.child("description");
			
			var annee:int = xmlDescription[0].annee;
			var type:String = xmlDescription[0].type;
			var histoire:String = xmlDescription[0].histoire;
			var auteur:String = xmlDescription[0].auteur;
			
			var description:Description = new Description(id, idOeuvre, annee, auteur, type, histoire);
			ControleurPrincipal.instance.afficherDescription(description);
		} 
		
		private function httpFault(event:FaultEvent):void { 
			var faultstring:String = event.fault.faultString; 
			 
		}
	}
}