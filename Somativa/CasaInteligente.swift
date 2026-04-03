/*
 ============================================================
 🏠 Projeto Somativo 1: Swift Essencial
 Sistema de Casa Inteligente (Console)
 ============================================================

 📋 Integrantes do Grupo:
 - Lucas Stopinski da Silva
 - Lucas Bruno e Silva

 📝 Divisão de Tarefas:
 - Lucas Stopinski da Silva: Passos 1 e 2 (enum TipoComando e protocolo
   Controlavel), Passo 3 (Protocol Extension com verificarConexao),
   desafios extras (mutating func alterarEstado e filtro por ambiente
   com .filter) e redação da documentação/respostas teóricas.
 - Lucas Bruno e Silva: Passo 4 (structs LuzRGB, Termostato e
   CameraSeguranca com implementação de processarComando e sobrescrita
   de verificarConexao na câmera), Passo 5 (instâncias, array
   redeSmartHome, loop polimórfico e comandos individuais), testes
   de execução no console e validação da saída esperada.

 💡 Como o Protocol Extension (Passo 3) ajudou a evitar duplicação:
 Ao definir o método verificarConexao() na extensão do protocolo
 Controlavel, fornecemos uma implementação padrão que é automaticamente
 herdada por todas as structs que conformam com o protocolo (LuzRGB e
 Termostato). Isso evita que cada dispositivo precise reescrever o
 mesmo código de verificação de conexão. Apenas a CameraSeguranca,
 que tem um comportamento diferente (conexão criptografada), precisou
 sobrescrever o método.

 📌 Respostas às Perguntas:

 1. Sobre Escalabilidade (Protocol Extensions):
 A principal vantagem prática é que os 50 novos dispositivos (Geladeira
 Inteligente, Fechadura, Robô Aspirador, etc.) já teriam automaticamente
 o método verificarConexao() funcionando sem precisar escrever uma
 única linha de código para ele. Bastaria criar a struct, conformar com
 o protocolo Controlavel e implementar apenas o processarComando() —
 que é o comportamento específico de cada aparelho. A extensão do
 protocolo elimina a necessidade de repetir código genérico em dezenas
 de structs, tornando o sistema muito mais escalável e fácil de manter.

 2. Sobre Arrays e Polimorfismo:
 O Swift permite misturar tipos diferentes no mesmo array porque
 declaramos o array como [Controlavel] — ou seja, o tipo do array é o
 protocolo, não uma struct específica. O compilador enxerga cada item
 como sendo do tipo Controlavel, independentemente de ser LuzRGB,
 Termostato ou CameraSeguranca. Isso funciona porque todas as structs
 assinam (conformam com) o protocolo, garantindo que todas possuem
 as propriedades e métodos exigidos. Quando chamamos um método no
 loop, o Swift usa dispatch dinâmico para executar a implementação
 correta de cada tipo concreto.

 3. Sobre Prioridade de Execução (Sobrescrita em POP):
 Isso nos ensina que quando um tipo conformante fornece sua própria
 implementação de um método que já tem uma implementação padrão na
 extensão do protocolo, a implementação do tipo concreto tem prioridade.
 O compilador Swift sempre prefere a implementação mais específica:
 primeiro verifica se o tipo (a struct) tem o método, e só depois recorre
 à implementação padrão da extensão. É assim que a CameraSeguranca
 conseguiu ter sua mensagem customizada de conexão criptografada,
 enquanto os outros dispositivos usaram a mensagem padrão de Wi-Fi.

 4. Sobre Arquitetura (POP vs OOP):
 A abordagem baseada em protocolos é útil porque define um "contrato"
 que qualquer tipo deve seguir, sem impor uma hierarquia rígida de
 herança. Com uma classe mãe Dispositivo, ficaríamos presos a uma
 cadeia de herança linear (e Swift só permite herança simples). Com
 protocolos, cada struct pode conformar com múltiplos protocolos
 independentes, misturando comportamentos de forma flexível. Além
 disso, structs são tipos de valor (mais seguras e eficientes em memória),
 enquanto classes são tipos de referência — e num sistema IoT com muitos
 dispositivos, a simplicidade e segurança das structs com protocolos
 é a escolha mais adequada.

 5. Sobre Structs (Value Types) - Desafio Extra:
 O Swift exige a palavra-chave mutating porque structs são tipos de
 valor. Quando uma variável é declarada com let, a struct inteira se
 torna imutável. A keyword mutating avisa o compilador que aquela
 função vai modificar o valor interno da struct, o que significa que
 ela só pode ser chamada em instâncias declaradas com var. Essa
 exigência é uma medida de segurança do Swift: garante que o
 programador tenha consciência de que está alterando o estado de um
 tipo de valor, prevenindo mutações acidentais e tornando o código
 mais previsível e seguro em ambientes concorrentes.

 ============================================================
*/

// MARK: - Passo 1: O Modelo de Comandos (Enums)

enum TipoComando {
    case ligar
    case desligar
    case ajustar
}

// MARK: - Passo 2: O Contrato da Casa (Protocol Controlavel)

protocol Controlavel {
    var nome: String { get }
    var ambiente: String { get }
    var estaLigado: Bool { get set }
    func processarComando(tipo: TipoComando, valor: String)
    func verificarConexao()
    mutating func alterarEstado()
}

// MARK: - Passo 3: A Magia do POP (Protocol Extensions)

extension Controlavel {
    func verificarConexao() {
        print("\(nome) localizado em \(ambiente): Sinal Wi-Fi Estável")
    }

    mutating func alterarEstado() {
        estaLigado.toggle()
        if estaLigado {
            print("\(nome) foi ligado!")
        } else {
            print("\(nome) foi desligado!")
        }
    }
}

// MARK: - Passo 4: Os Dispositivos (Conformidade com Structs)

struct LuzRGB: Controlavel {
    var nome: String
    var ambiente: String
    var estaLigado: Bool = false

    func processarComando(tipo: TipoComando, valor: String) {
        switch tipo {
        case .ligar:
            print("\(nome) na \(ambiente) foi ligada.")
        case .desligar:
            print("\(nome) na \(ambiente) foi desligada.")
        case .ajustar:
            print("\(nome) na \(ambiente) mudou a cor/brilho para: \(valor)")
        }
    }
}

struct Termostato: Controlavel {
    var nome: String
    var ambiente: String
    var estaLigado: Bool = false

    func processarComando(tipo: TipoComando, valor: String) {
        print("\(nome) na \(ambiente) recebeu comando \(tipo). Temperatura alvo: \(valor) graus")
    }
}

struct CameraSeguranca: Controlavel {
    var nome: String
    var ambiente: String
    var estaLigado: Bool = false

    func verificarConexao() {
        print("CÂMERA \(nome) na \(ambiente): Conexão Segura e Criptografada Ativa")
    }

    func processarComando(tipo: TipoComando, valor: String) {
        print("Câmera \(nome) na \(ambiente) processando: \(tipo) (Parâmetro: \(valor))")
    }
}

// MARK: - Passo 5: A Central de Controle (Array e Polimorfismo)

var luz = LuzRGB(nome: "Luz Principal", ambiente: "Sala")
var termostato = Termostato(nome: "Ar Condicionado", ambiente: "Quarto")
var camera = CameraSeguranca(nome: "Frontal", ambiente: "Garagem")

var redeSmartHome: [Controlavel] = [luz, termostato, camera]

// Loop: verificarConexao + processarComando ligar
for dispositivo in redeSmartHome {
    dispositivo.verificarConexao()
    print()
    dispositivo.processarComando(tipo: .ligar, valor: "Padrão")
    print()
}

// Comandos individuais fora do loop
redeSmartHome[0].processarComando(tipo: .ajustar, valor: "Azul")
print()
redeSmartHome[1].processarComando(tipo: .ajustar, valor: "22")

// MARK: - Desafio Extra 1: mutating func alterarEstado()

print("\n========== DESAFIO EXTRA: alterarEstado() ==========\n")

luz.alterarEstado()
print("Luz está ligada? \(luz.estaLigado)")
luz.alterarEstado()
print("Luz está ligada? \(luz.estaLigado)")

// MARK: - Desafio Extra 2: Filtro por Ambiente

print("\n========== DESAFIO EXTRA: Filtro por Ambiente ==========\n")

func filtrarPorAmbiente(rede: [Controlavel], ambiente: String) -> [Controlavel] {
    return rede.filter { $0.ambiente == ambiente }
}

let dispositivosSala = filtrarPorAmbiente(rede: redeSmartHome, ambiente: "Sala")
print("Dispositivos na Sala:")
for dispositivo in dispositivosSala {
    print("- \(dispositivo.nome)")
}

let dispositivosQuarto = filtrarPorAmbiente(rede: redeSmartHome, ambiente: "Quarto")
print("\nDispositivos no Quarto:")
for dispositivo in dispositivosQuarto {
    print("- \(dispositivo.nome)")
}

let dispositivosGaragem = filtrarPorAmbiente(rede: redeSmartHome, ambiente: "Garagem")
print("\nDispositivos na Garagem:")
for dispositivo in dispositivosGaragem {
    print("- \(dispositivo.nome)")
}
