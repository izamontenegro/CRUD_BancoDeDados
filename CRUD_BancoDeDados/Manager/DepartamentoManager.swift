//
//  DepartamentoManager.swift
//  CRUD_BancoDeDados
//
//  Created by Izadora de Oliveira Albuquerque Montenegro on 28/04/25.
//

class DepartamentoManager {
    static var departamentos: [Departamento] = FileHelper.load(from: "departamentos.txt")

    static func create(nome: String, projetos: [Projeto], nomeFuncionarioGerente: String) {        
        let departamento = Departamento(nome: nome, projetos: projetos, funcionarioGerente: nomeFuncionarioGerente)
        departamentos.append(departamento)
        FileHelper.save(departamentos, to: "departamentos.txt")
    }
}
