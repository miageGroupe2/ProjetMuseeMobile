package Controleur
{
	import DAO.DaoAudio;
	import DAO.DaoDescription;
	import DAO.DaoOeuvre;
	import DAO.DaoSalle;
	import DAO.DaoVideo;
	
	import Vue.VueSalle;
	
	import flash.utils.setTimeout;
	
	import modele.Audio;
	import modele.Description;
	import modele.Oeuvre;
	import modele.Salle;
	import modele.Video;
	
	import mx.collections.ArrayList;
	
	import spark.components.Label;
	import spark.components.TextInput;

	public class ControleurPrincipal
	{
		
		public static var instance:ControleurPrincipal ;
		private var daoSalle:DaoSalle ;
		private var daoOeuvre:DaoOeuvre ;
		private var listeSalles:ArrayList ;
		
		private var vueSalle:VueSalle ;
		//la salle affichée par la vue
		private var salleAffichee:Salle;
		
		public function ControleurPrincipal(myNewView:VueSalle)
		{
			this.vueSalle = myNewView ;
			this.daoSalle = new DaoSalle(this);
			this.daoOeuvre = new DaoOeuvre();
			instance = this ;
		}
		
		public function chargerSalle(nomSalle:String):Salle{
			
			this.salleAffichee = this.daoSalle.getSalleByNom(nomSalle) ;
			
			this.daoOeuvre.getOeuvreById(this.salleAffichee.getIdOeuvre());
			return this.salleAffichee;
		}
		
		public function chargerListeDesSalles(listeSalle:ArrayList):void{
					
			this.listeSalles = listeSalle;
			this.vueSalle.afficherListeDesSalles(this.listeSalles);
			
		}
		public function demanderChargerListeDesSalles():void{
			
			this.daoSalle.getToutesLesSalles();
		}
		
		public function chargerOeuvre(oeuvre:Oeuvre):void{
			
			this.salleAffichee.setOeuvre(oeuvre);
			this.vueSalle.vueOeuvre.afficherOeuvre(oeuvre);
			
		}
		public function lancerRecherche(recherche:String):void{
			
			this.daoOeuvre.getSalleByNomRecherche(recherche);
		}
		
		//permet d'afficher le resultat d'une recherche : DAOOeuvre renvoie l'id 
		// de l'oeuvre recherchée. -1 si aucun résultat
		public function lancerRechercheEtape2(id:int):void{
			
			if (id == -1){
				this.vueSalle.afficherResultatRecherche("aucun résultat");
			}else{
				
				var s:Salle = this.daoSalle.getSalleByIdOeuvre(id);
				
				var n:String = s.getNom();
				
				this.vueSalle.afficherResultatRecherche("Aller dans la salle :" + n);
			}
		}
		
		public function demanderVideo():void{
			
			new DaoVideo(this.salleAffichee.getOeuvre());
		}
		public function afficherVideo(video:Video):void{
			
			this.vueSalle.vueVideo.afficherVideo(video);
		}
		
		public function demanderAudio():void{
			
			new DaoAudio(this.salleAffichee.getOeuvre());
		}
		
		public function jouerAudio(audio:Audio):void{
			
			this.vueSalle.vueOeuvre.jouerAudio(audio);
		}
		
		public function demanderDescription():void{
			
			new DaoDescription(this.salleAffichee.getOeuvre());
		}
		
		public function afficherDescription(description:Description):void{
			
			this.vueSalle.vueDescription.afficherDescription(this.salleAffichee.getOeuvre().getNom(), description);
		}
			
		public function getSalleAffichee():Salle{
			
			return this.salleAffichee ;
		}
		
		
	}
}