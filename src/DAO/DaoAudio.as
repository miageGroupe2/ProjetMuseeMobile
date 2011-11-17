package DAO
{
	import Controleur.ControleurPrincipal;
	
	import modele.Audio;
	import modele.Oeuvre;
	import modele.Video;
	
	import mx.collections.ArrayList;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class DaoAudio
	{
		private var httpService:HTTPService ;
		private var xmlList:XMLList;
		
		private var resultatRequete:Object ;
		
		public function DaoAudio(oeuvre:Oeuvre)
		{
			this.httpService = new HTTPService();
			
			this.httpService.addEventListener("result", httpResult);
			this.httpService.addEventListener("fault", httpFault); 
			this.httpService.resultFormat = "e4x"; 
			this.httpService.url = "http://localhost/linkProjetMusee.php?table=audio&idOeuvre="+oeuvre.getId() ;
			this.httpService.send();
		}
		
		private function httpResult(event:ResultEvent):void { 
			
			this.resultatRequete = event.result ;
			
			var xml:XML= new XML(this.resultatRequete.toString());
			var xmlList: XMLList = xml.child("row");
			
			var id:int= xmlList[0].id ;
			var path:String= xmlList[0].path ;
			var idOeuvre:int= xmlList[0].idOeuvre ;
			
			var audio:Audio = new Audio(id, path);
			ControleurPrincipal.instance.jouerAudio(audio);
		} 
		
		private function httpFault(event:FaultEvent):void { 
			var faultstring:String = event.fault.faultString; 
			 
		}
	}
}