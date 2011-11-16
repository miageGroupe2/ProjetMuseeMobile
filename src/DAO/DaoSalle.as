package DAO
{
	import Controleur.ControleurPrincipal;
	
	import flash.xml.XMLDocument;
	
	import modele.Salle;
	
	import mx.collections.ArrayList;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class DaoSalle
	{
		
		
		private var httpService:HTTPService ;
		private var xmlList:XMLList;
		private var listeSalle:ArrayList ;
		private var controleurPrincipal:ControleurPrincipal ;
		private var resultatRequete:Object ;
		
		
		public function DaoSalle(controleurPrincipal:ControleurPrincipal)
		{
			this.controleurPrincipal = controleurPrincipal ;
			this.httpService = new HTTPService();
			this.httpService.url = "http://localhost/linkProjetMusee.php?table=salle" ;
			this.httpService.addEventListener("result", httpResult);
			this.httpService.addEventListener("fault", httpFault); 
			this.httpService.resultFormat = "e4x"; 
		
			
		}
		
		public function getSalleByIdOeuvre(idOeuvre:int):Salle{
			
			var length:int = this.listeSalle.length ;
			
			for (var i:Number = 0; i<length; i++) {
					
				var salleCourante:Salle = Salle(this.listeSalle.getItemAt(i));
				
				if (salleCourante.getIdOeuvre() == idOeuvre){
					
					return salleCourante ;
				}				
			}
			
			return null ;
		}
		public function getSalleByNom(nom:String):Salle{
			
			var length:int = this.listeSalle.length ;
			
			for (var i:Number = 0; i<length; i++) {
			
				var salleCourante:Salle = Salle(this.listeSalle.getItemAt(i));
				if (salleCourante.getNom() == nom){
					return salleCourante ;
				}
				
			}
			return null ;
		}
		
		public function getToutesLesSalles():void{
			
			
			this.httpService.send();
		}
		
		private function httpResult(event:ResultEvent):void { 
			
			this.resultatRequete = event.result ;
			
			this.listeSalle = new ArrayList();
			
			var xml:XML= new XML(this.resultatRequete.toString());
			var listSalle: XMLList = xml.child("row");
			
			for (var i:Number = 0; i<listSalle.length(); i++) {
				
				var id:int= listSalle[i].id ;
				var nom:String = listSalle[i].nom ;
				var idOeuvre:int= listSalle[i].idOeuvre ;
				
				var salle:Salle = new Salle(id, nom, idOeuvre);
				this.listeSalle.addItem(salle);
			}
			ControleurPrincipal.instance.chargerListeDesSalles(this.listeSalle);
		} 
				
		private function httpFault(event:FaultEvent):void { 
			var faultstring:String = event.fault.faultString; 
		}
	}
}