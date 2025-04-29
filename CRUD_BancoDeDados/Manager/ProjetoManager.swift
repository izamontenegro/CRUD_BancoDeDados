//
//  ProjetoManager.swift
//  CRUD_BancoDeDados
//
//  Created by Izadora de Oliveira Albuquerque Montenegro on 28/04/25.
//

class ProjetoManager {
    static var projetos: [Projeto] = FileHelper.load(from: "projetos.txt")

    static func create(nome: String, local: String, funcionarios: [Funcionario]) {
        let projeto = Projeto(nome: nome, local: local, funcionarios: funcionarios)
        FileHelper.save(projetos, to: "projetos.txt")
        
        projetos.append(projeto)
        FileHelper.save(projetos, to: "projetos.txt")
    }
}
