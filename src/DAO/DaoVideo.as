package DAO
{
	
	import Controleur.ControleurPrincipal;
	
	import modele.Oeuvre;
	import modele.Video;
	
	import mx.collections.ArrayList;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class DaoVideo
	{
		
		private var httpService:HTTPService ;
		private var xmlList:XMLList;
		
		private var resultatRequete:Object ;
		
		public function DaoVideo(oeuvre:Oeuvre)
		{
			this.httpService = new HTTPService();
			
			this.httpService.addEventListener("result", httpResult);
			this.httpService.addEventListener("fault", httpFault); 
			this.httpService.resultFormat = "e4x"; 
			this.httpService.url = "http://localhost/linkProjetMusee.php?table=video&idOeuvre="+oeuvre.getId() ;
			this.httpService.send();
		}
		
		private function httpResult(event:ResultEvent):void { 
			
			this.resultatRequete = event.result ;
			
			var xml:XML= new XML(this.resultatRequete.toString());
			var xmlList: XMLList = xml.child("row");
				
			var id:int= xmlList[0].id ;
			var nom:String = xmlList[0].nom ;
			var path:String= xmlList[0].path ;
			var description:String= xmlList[0].description ;
			var idOeuvre:int= xmlList[0].idOeuvre ;
			
			var video:Video = new Video(id, nom, path, description);
			ControleurPrincipal.instance.afficherVideo(video);
		} 
		
		private function httpFault(event:FaultEvent):void { 
			var faultstring:String = event.fault.faultString; 
		}
	}
}