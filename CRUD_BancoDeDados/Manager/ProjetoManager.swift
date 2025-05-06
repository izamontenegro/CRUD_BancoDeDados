//
//  ProjetoManager.swift
//  CRUD_BancoDeDados
//
//  Created by Izadora de Oliveira Albuquerque Montenegro on 28/04/25.
//

enum MenuOpcoes: Int {
    case CriarProjeto = 1
    case EditarProjeto
    case VerProjeto
    case RemoverProjeto
    case Sair
}

enum ProjetoAttributes: String, CaseIterable {
    case nome
    case local
    case funcionarios
    
    var displayName: String {
        switch self {
        case .nome: return "Nome"
        case .local: return "Local"
        case .funcionarios: return "Funcionários"
        }
    }
}

class ProjetoManager {
    static var projetos: [Projeto] = FileHelper.load(from: "projetos.txt")
    
    // MARK: Create

    static func create(nome: String, local: String, funcionarios: [Funcionario]) {
        let projeto = Projeto(nome: nome, local: local, funcionarios: funcionarios)
        FileHelper.save(projetos, to: "projetos.txt")
        
        projetos.append(projeto)
        FileHelper.save(projetos, to: "projetos.txt")
    }
    
    // MARK: Menu
    
    static func menuProjeto() {
        var shouldContinue = true
        while shouldContinue {
            print("""
                \nMENU
                ---------------------------
                Selecione uma opção:
                1. Criar projeto
                2. Editar projeto
                3. Ver projeto
                4. Remover projeto
                5. Encerrar programa
                
                """)
            guard let input = readLine(), let opcaoInt = Int(input), let opcao = MenuOpcoes(rawValue: opcaoInt) else {
                print("\nEntrada inválida. Tente novamente.\n")
                continue
            }
            switch opcao {
            case .CriarProjeto:
                print("Criar projeto")
            case .EditarProjeto:
                update()
            case .VerProjeto:
                print("Ver projeto")
            case .RemoverProjeto:
                removeProjeto()
            case .Sair:
                shouldContinue = false
            }
        }
    }
    
    //MARK: remover projeto
    
    static func removeProjeto() {
        if projetos.isEmpty {
            print("\nNenhum projeto cadastrado.\n")
            return
        }
        print("\nEscolha um projeto para remover: (Digite aqui o número do projeto)\n")
        for(index, projeto) in projetos.enumerated() {
            print("\(index + 1). \(projeto.nome)")
        }
        print("\n")
        
        guard let input = readLine(), let chooseIndex = Int(input),(1...projetos.count).contains(chooseIndex) else {
            print("\nOpção inválida.\n")
            return
        }
        
        let projetoRemovido = projetos.remove(at: chooseIndex - 1)
        FileHelper.save(projetos, to: "projetos.txt")
        print("\nProjeto \(projetoRemovido.nome) removido com sucesso.\n")
        
    }
    
    // MARK: update
    
    static func updateProjeto(projetoAntigo: Projeto, projetoNovo: Projeto) {
        var projetos: [Projeto] = FileHelper.load(from: "projetos.txt")
        if let index = projetos.firstIndex(where: { $0.nome == projetoAntigo.nome }) {
            projetos[index] = projetoNovo
            FileHelper.save(projetos, to: "projetos.txt")
            print("Projeto atualizado com sucesso.")
            self.projetos = projetos
        } else {
            print("Projeto não encontrado.")
        }
    }
    
    static func update() {
        var shouldContinue = true
        guard let projeto = getProjectUI() else {
            return
        }
        
        while shouldContinue {
            
            guard let attribute = selectAttributeToUpdateUI(projeto: projeto) else {
                shouldContinue = false
                continue
            }
            
            let newProjeto = editAttributeUI(projeto: projeto, attribute: attribute)
            updateProjeto(projetoAntigo: projeto, projetoNovo: newProjeto)
            
        }
    }
    
    static func editAttribute(attribute: ProjetoAttributes, for input: String, projeto: Projeto) -> Projeto {
        var newProjeto: Projeto = projeto
        switch attribute {
        case .nome:
            newProjeto.nome = input
        case .local:
            newProjeto.local = input
        default:
            break
        }
        return newProjeto
    }
    
    static func selectAttributeToUpdate(by index: Int) -> ProjetoAttributes {
       return ProjetoAttributes.allCases[index - 1]
    }
    
    static func getProject(by numeroProjeto: Int) -> Projeto {
            return projetos[numeroProjeto - 1]
    }
    
    static func removeAllFuncionarios(projeto: Projeto) -> Projeto {
        var newProjeto: Projeto = projeto
        newProjeto.funcionarios.removeAll()
        return newProjeto
    }
    
    static func addFuncionario(projeto: Projeto, funcionario: Funcionario) -> Projeto {
        var novo = projeto
        novo.funcionarios.append(funcionario)
        return novo
    }
    
    static func outFuncionarios(newProjeto: Projeto) -> [Funcionario] {
        var outFuncionarios = [Funcionario]()
        for (_, funcionario) in FuncionarioManager.funcionarios.enumerated() {
            let jaAdicionado = newProjeto.funcionarios.contains(where: { $0.nome.primeiroNome == funcionario.nome.primeiroNome && $0.nome.ultimoNome == funcionario.nome.ultimoNome })
            if !jaAdicionado {
                outFuncionarios.append(funcionario)
                
            }
        }
        return outFuncionarios
    }
    
    // MARK: updateUI
    
    static func getProjectUI() -> Projeto? {
        if projetos.isEmpty {
            print("\nNão há projetos para atualizar.\n")
            return nil
        }
        print("\nEscolha um projeto para atualizar: (Digite o número do projeto)")
        for (index, projeto) in projetos.enumerated() {
            print("\(index + 1). \(projeto.nome)")
        }
        print("\n")
        guard let input = readLine(), let choice = Int(input),
              (1...projetos.count).contains(choice) else {
            print("Opção inválida.\n")
            return nil
        }
        return getProject(by: choice)
    }
    
    static func selectAttributeToUpdateUI(projeto: Projeto) -> ProjetoAttributes? {
        print("\nProjeto escolhido: \(projeto.nome)")
        print("\nEscolha um atributo para atualizar:")
        for (index, attribute) in ProjetoAttributes.allCases.enumerated() {
            print("\(index + 1). \(attribute.displayName)")
        }
        print("4. Retornar \n")
        if let input = readLine(), let choice = Int(input) {
                if choice == ProjetoAttributes.allCases.count + 1 {
                    return nil
                } else if (1...ProjetoAttributes.allCases.count).contains(choice) {
                    return selectAttributeToUpdate(by: choice)
                } else {
                    print("Opção inválida.\n")
                    return selectAttributeToUpdateUI(projeto: projeto) // Chama novamente até input válido
                }
        } else {
            print("Opção inválida.\n")
            return selectAttributeToUpdateUI(projeto: projeto) // Chama novamente até input válido
        }
    }
    
    static func editAttributeUI(projeto: Projeto, attribute: ProjetoAttributes) -> Projeto {
        var newProjeto: Projeto = projeto
        if attribute == .nome {
            print("\nNome atual: \(projeto.nome)")
            print("Digite o novo \(attribute.displayName):\n")
            if let input = readLine() {
                newProjeto = editAttribute(attribute: attribute, for: input, projeto: projeto)
            }
        } else if attribute == .local {
            print("\nLocal atual: \(projeto.local)\n")
            print("Digite o novo \(attribute.displayName):\n")
            if let input = readLine() {
                newProjeto = editAttribute(attribute: attribute, for: input, projeto: projeto)
            }
        } else {
            newProjeto = editFuncionariosUI(projeto: projeto)
        }
        
        return newProjeto
    }
    
    static func editFuncionariosUI(projeto: Projeto) -> Projeto {
        var newProjeto = projeto
        var shouldContinue = true
        
        while(shouldContinue) {
            print("""
                \n--- Edição de Funcionários ---
                1. Adicionar novo funcionário
                2. Remover funcionário
                3. Ver lista atual de funcionários
                4. Retornar\n
                """)
            guard let input = readLine(), let choice = Int(input) else {
                print("Opção inválida.\n")
                continue
            }
            switch choice {
            case 1:
                newProjeto = addFuncionarioUI(projeto: newProjeto)
            case 2:
                newProjeto = removeFuncionarioUI(projeto: newProjeto)
            case 3:
                if newProjeto.funcionarios.isEmpty {
                    print("Nenhum funcionário adicionado ainda.\n")
                } else {
                    print("Funcionários atuais:")
                    for f in newProjeto.funcionarios {
                        print("\(f.nome.primeiroNome)\(f.nome.inicialDoMeio ?? "") \(f.nome.ultimoNome)")
                    }
                }
            case 4:
                shouldContinue = false
            default:
                print("Opção inválida.\n")
            }
        }
        return newProjeto
    }
    
    static func addFuncionarioUI(projeto: Projeto) -> Projeto {
        var newProjeto = projeto
        
        guard !outFuncionarios(newProjeto: projeto).isEmpty else {
            print("Nenhum funcionário a ser adicionado.\n")
            return newProjeto
        }
        
        if !newProjeto.funcionarios.isEmpty {
            print("Funcionários no projeto:")
            for (index, funcionario) in newProjeto.funcionarios.enumerated() {
                print("\(index + 1). \(funcionario.nome.primeiroNome) \(funcionario.nome.ultimoNome)")
            }
            print("\n")
        } else {
            print("Não há funcionários adicionados.\n")
        }
        
        
        print("Digite o número do funcionário a ser adicionado:")
        var i = 0
        for (_, funcionario) in FuncionarioManager.funcionarios.enumerated() {
            
            let jaAdicionado = newProjeto.funcionarios.contains(where: { $0.nome.primeiroNome == funcionario.nome.primeiroNome && $0.nome.ultimoNome == funcionario.nome.ultimoNome })
            if !jaAdicionado {
                print("\(i + 1). \(funcionario.nome.primeiroNome) \(funcionario.nome.ultimoNome)")
                i += 1
            }
        }
        if let input = readLine(), let idFuncionario = Int(input) {
            if idFuncionario < 1 || idFuncionario > FuncionarioManager.funcionarios.count {
                print("Opção inválida.\n")
                return newProjeto
            } else {
                newProjeto.funcionarios.append(FuncionarioManager.funcionarios[idFuncionario - 1])
                print("Funcionário adicionado com sucesso.\n")
            }
        }
        return newProjeto
    }
    
    static func removeFuncionarioUI(projeto: Projeto) -> Projeto {
        var newProjeto = projeto
        
        guard !newProjeto.funcionarios.isEmpty else {
            print("Nenhum funcionário a ser removido.\n")
            return newProjeto
        }
        
        print("Funcionários no projeto:")
        for (index, funcionario) in newProjeto.funcionarios.enumerated() {
            print("\(index + 1). \(funcionario.nome.primeiroNome) \(funcionario.nome.ultimoNome)")
        }
        print("\n")
        print("Digite o número do funcionário a ser removido:")
        
        if let input = readLine(), let escolha = Int(input),
           escolha >= 1, escolha <= newProjeto.funcionarios.count {
            newProjeto.funcionarios.remove(at: escolha - 1)
            print("Funcionário removido com sucesso.\n")
        } else {
            print("Opção inválida.\n")
        }
        
        return newProjeto
    }
}
