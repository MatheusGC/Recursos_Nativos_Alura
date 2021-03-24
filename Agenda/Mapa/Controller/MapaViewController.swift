//
//  MapaViewController.swift
//  Agenda
//
//  Created by Matheus Golke Cardoso on 23/03/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit
import MapKit

class MapaViewController: UIViewController {
    
    
    //MARK: - IBOutlet
    
    
    @IBOutlet weak var mapa: MKMapView!
    
    //MARK: - Variavel
    
    var aluno:Aluno?
    lazy var localizacao = Localizacao()
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = getTitulo()
        localizacaoInicial()
        localizarAluno()
        mapa.delegate = localizacao
    }
    
    //MARK: - Metodos
    
    func getTitulo()->String{
        return "Localizar Alunos"
    }
    
    func localizacaoInicial(){
        Localizacao().converteEnderecoEmCoordenadas("Caelum - São Paulo") { (localizacaoEncontrada) in
            let pino = Localizacao().configuraPino("Caelum", localizacaoEncontrada, .black, UIImage(named: "icon_caelum"))
            let regiao = MKCoordinateRegionMakeWithDistance(pino.coordinate, 5000, 5000)
            self.mapa.setRegion(regiao, animated: true)
            self.mapa.addAnnotation(pino)
        }
    }
    
    func localizarAluno(){
        if let aluno = aluno{
            Localizacao().converteEnderecoEmCoordenadas(aluno.endereco!) { (localizacaoEncontrada) in
                let pino = Localizacao().configuraPino(aluno.nome!, localizacaoEncontrada, nil, nil)
                self.mapa.addAnnotation(pino)
            }
        }
        
    }
    
  
  

}
