//
//  FuncionarioManager.swift
//  CRUD_BancoDeDados
//
//  Created by Izadora de Oliveira Albuquerque Montenegro on 28/04/25.
//

class FuncionarioManager {
    static var funcionarios: [Funcionario] = FileHelper.load(from: "funcionarios.txt")

    static func create(primeiroNome: String, inicialDoMeio: String?, ultimoNome: String, cpf: String, salario: Double, genero: GenderOptions, endereco: String, dataDeNascimento: String, departamento: Departamento?, projetos: [Projeto]?) {
        

        let funcionario = Funcionario(nome: NomeFuncionario(primeiroNome: primeiroNome, inicialDoMeio: inicialDoMeio, ultimoNome: ultimoNome), cpf: cpf, salario: salario, endereco: endereco, genero: genero, dataDeNascimento: dataDeNascimento, departamento: departamento, projetos: projetos)

        funcionarios.append(funcionario)
        FileHelper.save(funcionarios, to: "funcionarios.txt")
    }
}
