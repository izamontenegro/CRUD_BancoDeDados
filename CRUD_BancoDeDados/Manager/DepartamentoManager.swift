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
    
    static func verificarExclusividade(nome: String) -> Bool {
        if departamentos.contains(where: { $0.nome == nome }) {
            print("Erro: Já existe um departamento com o nome \(nome).")
            return false
        }
        
        return true
    }
    
}
