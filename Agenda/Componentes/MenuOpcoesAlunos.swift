//
//  MenuOpcoesAlunos.swift
//  Agenda
//
//  Created by Matheus Golke Cardoso on 23/03/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit

enum ManuActionSheetAluno {
    case sms
    case ligacao
    case waze
    case mapa
}

class MenuOpcoesAlunos: NSObject {
    
    func configuraMenuDeOpcoesDoAluno(completion:@escaping(_ opcao:ManuActionSheetAluno)->Void)->UIAlertController{
        let menu = UIAlertController(title: "Atencao", message: "escolha uma das opcoes abaixo", preferredStyle: .actionSheet)
        let sms = UIAlertAction(title: "enviar sms", style: .default) { (acao) in
            completion(.sms)
        }
        menu.addAction(sms)
        
        let ligacao = UIAlertAction(title: "ligar", style: .default) { (acao) in
            completion(.ligacao)
        }
        menu.addAction(ligacao)
        
        let waze = UIAlertAction(title: "localizar no waze", style: .default) { (acao) in
            completion(.waze)
        }
        menu.addAction(waze)
        
        let mapa = UIAlertAction(title: "localizar no mapa", style: .default) { (acao) in
            completion(.mapa)
        }
        menu.addAction(mapa)
        
        
        let cancelar = UIAlertAction(title: "cancelar", style: .cancel, handler: nil)
        menu.addAction(cancelar)
        return menu
    }

}
