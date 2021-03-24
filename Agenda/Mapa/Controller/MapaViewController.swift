//
//  MapaViewController.swift
//  Agenda
//
//  Created by Matheus Golke Cardoso on 23/03/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit
import MapKit

class MapaViewController: UIViewController, CLLocationManagerDelegate {
    
    
    //MARK: - IBOutlet
    
    
    @IBOutlet weak var mapa: MKMapView!
    
    //MARK: - Variavel
    
    var aluno:Aluno?
    lazy var localizacao = Localizacao()
    lazy var gerenciadorDeLocalizacao = CLLocationManager()
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = getTitulo()
        verificaAutorizacaoDoUsuario()
        localizacaoInicial()
        localizarAluno()
        mapa.delegate = localizacao
        gerenciadorDeLocalizacao.delegate = self
    }
    
    //MARK: - Metodos
    
    func getTitulo()->String{
        return "Localizar Alunos"
    }
    
    func verificaAutorizacaoDoUsuario(){
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                let botao = Localizacao().configuraBotaoLocalizacaoAtual(mapa: mapa)
                mapa.addSubview(botao)
                gerenciadorDeLocalizacao.startUpdatingLocation()
                break
            case .notDetermined:
                gerenciadorDeLocalizacao.requestWhenInUseAuthorization()
                break
            case .denied:
                
                break
            default:
                break
            }
        }
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
    
    //MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            let botao = Localizacao().configuraBotaoLocalizacaoAtual(mapa: mapa)
            mapa.addSubview(botao)
            gerenciadorDeLocalizacao.startUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
  
  

}
