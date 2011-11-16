package DAO
{
	import Controleur.ControleurPrincipal;
	
	import flash.xml.XMLDocument;
	
	import modele.Oeuvre;
	import modele.Salle;
	
	import mx.collections.ArrayList;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class DaoOeuvre
	{
		
		private var httpService:HTTPService ;
		private var xmlList:XMLList;
		private var listeOeuvre:ArrayList ;
		
		private var resultatRequete:Object ;
		private var salle:Salle ;
		private var typeRequete:String ;
		
		public function DaoOeuvre()
		{
			
			this.listeOeuvre = new ArrayList();
			this.httpService = new HTTPService();
			
			this.httpService.addEventListener("result", httpResult);
			this.httpService.addEventListener("fault", httpFault); 
			this.httpService.resultFormat = "e4x"; 
			
			
		}
		public function getOeuvreById(id:int):void{
			
			this.typeRequete = "getOeuvreById";
			this.httpService.url = "http://localhost/linkProjetMusee.php?table=oeuvre&idOeuvre="+id ;
			this.httpService.send();
			
		}
		
		public function getSalleByNomRecherche(recherche:String):void{
			
			this.typeRequete = "getSalleByNomRecherche";
			//si y'a des "'" dans le string ca plante donc on les enleve
			recherche = recherche.replace("'", "");
			this.httpService.url = "http://localhost/linkProjetMusee.php?table=oeuvre&nom="+recherche ;
			this.httpService.send();
			
		}
		
		private function httpResult(event:ResultEvent):void { 
			
			this.resultatRequete = event.result ;
			
			var xml:XML= new XML(this.resultatRequete.toString());
			var xmlList: XMLList = xml.child("row");
			
			if(this.typeRequete == "getSalleByNomRecherche"){
				
				if (xmlList.length() == 0){
					
					ControleurPrincipal.instance.lancerRechercheEtape2(-1);
					return ;
				}
			}
			
			var id:int= xmlList[0].id ;
			var nom:String = xmlList[0].nom ;
			var path:String= xmlList[0].path ;
			
			if(this.typeRequete == "getSalleByNomRecherche"){
				
				ControleurPrincipal.instance.lancerRechercheEtape2(id);	
			}else{
				
				var oeuvre:Oeuvre = new Oeuvre(id, nom, path);
				ControleurPrincipal.instance.chargerOeuvre(oeuvre);	
			}
			
		} 
		
		private function httpFault(event:FaultEvent):void { 
			var faultstring:String = event.fault.faultString; 
 
		}
		
	}
}