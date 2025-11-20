#set page(
  paper: "a4",
  margin: (
    left: 3cm,
    top: 3cm,
    right: 2cm,
    bottom: 2cm,
  ),
)

#set text(
  font: "Times New Roman",
  size: 12pt,
  lang: "pt",
  region: "BR",
)

#set par(
  justify: true,
  first-line-indent: (amount: 1.25cm, all: true),
  leading: 0.5em, // ABNT: 1.5 spacing (12pt font + 6pt leading = 18pt baseline skip)
)

#let cover = (
  title: "NetProbe",
  instituition: "Universidade São Judas Tadeu",
  department: "Gestão e Qualidade de Software",
  authors: (
    "Gabriel Almeida Portela - 825233281",
    "Daniel Almeida Portela - 825234443",
  ),
  work: "Documentação do Produto de Software",
  degree: "Bacharel em Ciência da Computação",
  advisor: "Prof. MSc. Fernando M. Bettine",
  coadvisor: "",
  city: "São Paulo",
  year: 2025,
)

#set heading(numbering: "1.")

// ABNT: Caption above figure, Source below
#show figure: it => {
  align(center)[
    #{
      set par(leading: 0.2em)
      it.caption
    }
    #v(0.5em)
    #it.body
  ]
}

#show: doc => {
  // Cover page (Capa)
  page(
    [
      #align(center)[
        #v(0.5fr)
        #text(size: 14pt)[#upper(cover.instituition)]
        #linebreak()
        #text(size: 14pt)[#upper(cover.department)]
        #v(2fr)
        #par(first-line-indent: 0pt)[
          #for author in cover.authors {
            text(size: 14pt)[#author]
            linebreak()
          }
        ]
        #v(2fr)
        #text(16pt, weight: "bold")[
          #upper(cover.title)
        ]
        #v(3fr)
        #cover.city
        #linebreak()
        #cover.year
        #v(0.5fr)
      ]
    ],
  )

  pagebreak()

  // Title Page (Folha de rosto)
  page(
    [
      #align(center)[
        #v(0.5fr)
        #par(first-line-indent: 0pt)[
          #for author in cover.authors {
            text(size: 14pt)[#author]
            linebreak()
          }
        ]
        #v(2fr)
        #text(16pt, weight: "bold")[
          #upper(cover.title)
        ]
        #v(2fr)
      ]

      // Ajuste NBR 14724: bloco com recuo (inset left) ~8cm para natureza do trabalho
      #block(inset: (left: 8cm))[
        #par(first-line-indent: 0pt, justify: true)[
          #cover.work apresentado à Unidade Curricular de #cover.department da #cover.instituition, como requisito parcial para obtenção do grau de #cover.degree.
          #linebreak()
          #if cover.advisor != "" {
            [*Orientador:* #cover.advisor]
            linebreak()
          }
          #if cover.coadvisor != "" {
            [Coorientador: #cover.coadvisor]
          }
        ]
      ]

      #align(center)[
        #v(2fr)
        #cover.city
        #linebreak()
        #cover.year
        #v(0.5fr)
      ]
    ],
  )

  page(
    [
      #align(center)[
        #text(weight: "bold")[#upper("Resumo")]
      ]
      #v(0.5fr)
      #par(first-line-indent: 0pt)[
        Este documento apresenta a documentação do produto de _software_ *NetProbe*, um analisador de tráfego de rede desenvolvido para monitorar e analisar pacotes em tempo real. O sistema é composto por um _backend_ em C++ responsável pela captura e processamento dos pacotes, e um _frontend_ _web_ que exibe os dados de forma dinâmica e interativa. A comunicação entre o _backend_ e o _frontend_ é realizada utilizando WebAssembly, garantindo alta performance e eficiência. O documento detalha os requisitos funcionais e não-funcionais do sistema, o modelo de qualidade adotado, o protótipo de interface, o plano de gestão de configuração do _software_, e a estratégia de testes implementada para garantir a qualidade do produto final.
      ]
      #v(0.5fr)
      #par(first-line-indent: 0pt)[
        Palavras-chave: Documentação de Software; Engenharia de Software; Monitoramento de Redes; NetProbe.
      ]
    ],
  )

  pagebreak()

  page(
    [
      #align(center)[
        #text(weight: "bold")[#upper("Sumário")]
      ]
      #v(0.75fr)
      #outline(title: none)
    ],
  )

  pagebreak()

  // Page counting starts from the folha de rosto (no number printed yet)
  // ABNT: Numbering starts appearing from Introduction (usually page 3 or 4), but counts from Folha de Rosto
  set page(numbering: "1", number-align: top + right)
  counter(page).update(6)
  doc
}

= INTRODUÇÃO
== Tema
O _software_ *NetProbe* é uma solução inovadora focada em segurança, eficiência e confiabilidade em redes de computadores, que serve como base para toda solução digital moderna. Este projeto também alinha-se com o objetivo 9 da ONU, que busca construir infraestruturas resilientes, promover a industrialização inclusiva e sustentável, e fomentar a inovação.

== Objetivos
O *NetProbe*, como projeto, tem como objetivo desenvolver um analisador de tráfego de rede que seja capaz de monitorar o tráfego de rede em tempo real, e tem como publico-alvo estudantes de ciência/engenharia da computação, entusiastas de redes, e educadores.

== Escopo Principal
=== Atores do Sistema
- *Usuário*: Entusiasta de redes que irá se registrar, autenticar e utilizar o sistema para monitorar e analisar o tráfego da rede local.

=== Casos de Uso
==== Cadastrar-se no Sistema
- *Código*: UC01
- *Ator Principal*: Usuário
- *Pré-condições*: O usuário não possui uma conta de acesso ao sistema.
- *Gatilho*: O usuário acessa a página inicial e decide criar uma nova conta para acessar o _dashboard_.
- *Cenário de Sucesso Principal*: *1.* O usuário acessa a interface _web_ do sistema. *2.* O sistema exibe a página de _login_ e apresenta uma opção para "Cadastro". *3.* O usuário seleciona a opção de cadastro. *4.* O sistema exibe um formulário solicitando informações como e-mail e senha. *5.* O usuário preenche o formulário com dados válidos e o submete. *6.* O sistema valida os dados, cria a conta de usuário e armazena as informações de forma segura. *7.* O sistema redireciona o usuário para a página de _login_ com uma mensagem de sucesso, indicando que o cadastro foi concluído.

- *Exceções*: *6a.* Se o e-mail fornecido já estiver cadastrado, o sistema exibe uma mensagem de erro informando que o usuário já existe. *6b.* Se os dados fornecidos forem inválidos (ex: formato de e-mail incorreto, senha fora do padrão exigido), o sistema exibe uma mensagem de erro e solicita a correção.

==== Autenticar-se no Sistema (_Login_)
- *Código*: UC02
- *Ator Principal*: Usuário
- *Pré-condições*: O usuário deve ter uma conta previamente cadastrada no sistema.
- *Gatilho*: O usuário deseja acessar o _dashboard_ de monitoramento de rede.
- *Cenário de Sucesso Principal*: *1.* O usuário acessa a página de _login_ do sistema. *2.* O usuário insere suas credenciais (e-mail e senha) nos campos correspondentes. *3.* O usuário submete o formulário de _login_. *4.* O sistema valida as credenciais. *5.* Após a autenticação bem-sucedida, o sistema concede acesso e exibe o _dashboard_ principal de monitoramento de rede.

- *Exceções*: *4a.* Se as credenciais estiverem incorretas, o sistema exibe uma mensagem de "Usuário ou senha inválidos" e permite que o usuário tente novamente.

==== Monitorar Tráfego de Rede em Tempo Real
- *Código*: UC03
- *Ator Principal*: Usuário
- *Pré-condições*: O usuário está autenticado e na página do _dashboard_ _web_. O _backend_ em C++ está ativo e capturando pacotes da rede local.
- *Gatilho*: O usuário acessa o _dashboard_ para visualizar a atividade da rede.
- *Cenário de Sucesso Principal*: *1.* Após o _login_, o usuário visualiza o _dashboard_ principal. *2.* O _backend_ em C++, integrado ao _frontend_ via WebAssembly, captura os pacotes da rede. *3.* O _dashboard_ exibe uma tabela ou lista que é atualizada em tempo real com os pacotes capturados. *4.* Para cada pacote, o sistema exibe informações essenciais como: endereço IP de origem, endereço IP de destino, porta de origem, porta de destino, protocolo (TCP, UDP, ICMP, etc.) e o volume de dados (tamanho do pacote).

- *Exceções*: *3a.* Caso o _backend_ em C++ não consiga capturar o tráfego (ex: falta de permissões), o _dashboard_ exibe uma mensagem de erro informando sobre a falha na captura de pacotes.

==== Filtrar Tráfego de Rede
- *Código*: UC04
- *Ator Principal*: Usuário
- *Pré-condições*: O usuário está autenticado e visualizando o tráfego em tempo real no _dashboard_.
- *Gatilho*: O usuário deseja isolar e visualizar pacotes específicos para uma análise mais focada.
- *Cenário de Sucesso Principal*: *1.* No _dashboard_, o usuário localiza os campos ou a seção de filtros. *2.* O usuário preenche um ou mais critérios de filtro, como: protocolo (ex: "HTTP"), endereço IP específico (origem ou destino) ou número de porta. *3.* O usuário aplica o filtro. *4.* O sistema processa a regra de filtro e atualiza a exibição do tráfego, mostrando apenas os pacotes que correspondem aos critérios definidos. *5.* O usuário tem a opção de modificar ou limpar os filtros para retornar à visualização completa.

- *Exceções*: *4a.* Se o usuário inserir um valor de filtro inválido (ex: um endereço IP mal formatado), o sistema exibe uma notificação de erro e não aplica o filtro até que seja corrigido.

==== Analisar Pacote de Dados
- *Código*: UC05
- *Ator Principal*: Usuário
- *Pré-condições*: O usuário está autenticado e visualizando a lista de pacotes no _dashboard_.
- *Gatilho*: O usuário identifica um pacote de interesse e deseja inspecionar seus detalhes técnicos.
- *Cenário de Sucesso Principal*: *1.* O usuário seleciona (clica em) um pacote específico na lista de tráfego. *2.* O sistema exibe uma visualização detalhada do pacote selecionado em uma janela modal ou em um painel lateral. *3.* Esta visualização apresenta o conteúdo decodificado do pacote, dividido por camadas, como o cabeçalho Ethernet, cabeçalho IP, cabeçalho do protocolo de transporte (TCP/UDP) e a carga útil (_payload_) dos dados. *4.* O usuário analisa as informações detalhadas para entender a natureza da comunicação. *5.* O usuário fecha a visualização de detalhes para retornar à lista principal de tráfego.

- *Exceções*: *3a.* Se o conteúdo do pacote estiver criptografado ou em um formato que não possa ser decodificado, o sistema exibirá as informações que conseguir interpretar (como os cabeçalhos) e indicará que a carga útil não é legível.


== Fatores de Qualidade
Os fatores de qualidade de McCall é um modelo que fornece uma estrutura para inspecionar e garantir a qualidade de um produto de _software_. O modelo separa qualidade em 3 categorias --- Operação, Revisão e Transição do produto --- essas categorias são dividias em 11 fatores de qualidades. Essa seção aplica o modelo de qualidade de McCall para o _software_ NetProbe.

=== Operação do Produto
==== Correção (_Correctness_)
- O sistema exibe corretamente os IPs de origem e destino, portas e protocolos de cada pacote?
- A função de cadastro e _login_ operam exatamente como especificado nos requisitos (RF001 a RF004)?
- Os filtros aplicados pelo usuário retornam com precisão apenas os pacotes que correspondem aos critérios (filtros)?
- A análise de pacotes decodifica e exibe corretamente os dados dos cabeçalhos do respectivo pacote?

==== Confiabilidade (_Reliability_)
- O _backend_ em C++ consegue capturar pacotes continuamente por longos períodos (horas ou dias) sem falhar?
- O sistema tem um jeito "gracioso" de lidar com erros, como a perda de acesso à interface de rede, informando o usuário sem travar?
- A conexão via WebAssembly entre o _frontend_ e o _backend_ é estável?

==== Eficiência (_Efficiency_)
- O _backend_ em C++ tem baixo consumo de CPU e memória para não impactar o desempenho da máquina onde está rodando? (Fundamental para uma ferramenta de monitoramento).
- A atualização em tempo real do _dashboard_ é otimizada para consumir poucos recursos do navegador?
- A aplicação de filtros é processada rapidamente, mesmo com um grande volume de pacotes sendo exibido?

==== Integridade (_Integrity_)
- O sistema impede que usuários não autenticados acessem o _dashboard_?
- As senhas dos usuários são armazenadas de forma segura (criptografadas)?
- O sistema garante que a captura de tráfego não abre brechas de segurança no sistema hospedeiro (_host machine_)?

==== Usabilidade (_Usability_)
- A interface do _dashboard_ é clara e intuitiva para um "entusiasta de redes"?
- É fácil para o usuário encontrar e aplicar os filtros desejados?
- A visualização dos dados de um pacote é detalhada, organizada e fácil de ler?

=== Revisão do Produto
==== Manutenibilidade (_Maintainability_)
- O código-fonte é bem estruturado, comentado e segue padrões de programação?
- É fácil para um novo desenvolvedor entender a lógica de captura e processamento de pacotes no _backend_?
- Se um _bug_ for encontrado na renderização do _dashboard_, quão rápido ele pode ser identificado e resolvido?

==== Flexibilidade (_Flexibility_)
- Qual seria a dificuldade para adicionar um novo critério de filtro (e.g. por tamanho do pacote)?
- Se no futuro for decidio adicionar a funcionalidade de "Gerar Relatórios" (que foi explicitamente excluída), a arquitetura atual facilita essa adição?
- Quão fácil é modificar a interface para suportar um novo tipo de gráfico ou visualização?

==== Testabilidade (_Testability_)
- O _backend_ em C++ pode ser testado de forma automatizada, talvez usando arquivos de captura (`.pcap`) como entrada?
- Os componentes do _frontend_ são isolados, permitindo a criação de testes unitários para a interface?
- Existem procedimentos claros para realizar testes de ponta a ponta (_end-to-end_), simulando o _login_, a aplicação de um filtro e a análise de um pacote?

=== Transição do Produto
==== Portabilidade (_Portability_)
- O _backend_ em C++ pode ser compilado e executado em diferentes sistemas operacionais com pouca ou nenhuma modificação?
- O _frontend_ _web_, por sua natureza, já é altamente portátil, mas ele funciona corretamente em todos os navegadores modernos?

==== Reusabilidade (_Reusability_)
- O módulo de autenticação de usuários poderia ser reutilizado em outro sistema _web_?
- A biblioteca C++ de captura de pacotes foi projetada de forma que possa ser usada como base para outra ferramenta de rede?

==== Interoperabilidade (_Interoperability_)
- O sistema poderia, futuramente, exportar os dados capturados em um formato padrão (como CSV ou JSON) para que possam ser importados por outras ferramentas de análise?
- Seria possível integrar o sistema com uma API externa para, por exemplo, verificar se um IP de origem está em uma lista de ameaças conhecidas (_blacklist_)?

= MODELO DE QUALIDADE ISO/IEC 25010
A ISO/IEC 25010:2011 define o modelo de qualidade de produto de _software_ com oito características e suas subcaracterísticas, servindo de base para especificação, avaliação e melhoria da qualidade.

== Características e subcaracterísticas
- Adequação Funcional (_Functional suitability_)
  - Completude funcional; Correção funcional; Adequação/pertinência funcional.
- Eficiência de Desempenho (_Performance efficiency_)
  - Comportamento temporal; Utilização de recursos; Capacidade.
- Compatibilidade (_Compatibility_)
  - Coexistência; Interoperabilidade.
- Usabilidade (_Usability_)
  - Reconhecibilidade de adequação; Aprendibilidade; Operacionalidade; Proteção ao erro do usuário; Estética da interface; Acessibilidade.
- Confiabilidade (_Reliability_)
  - Maturidade; Disponibilidade; Tolerância a falhas; Recuperabilidade.
- Segurança (_Security_)
  - Confidencialidade; Integridade; Não repúdio; Responsabilização; Autenticidade.
- Manutenibilidade (_Maintainability_)
  - Modularidade; Reusabilidade; Analisabilidade; Modificabilidade; Testabilidade.
- Portabilidade (_Portability_)
  - Adaptabilidade; Instalabilidade; Substituibilidade.

== Aplicação ao NetProbe
- Adequação funcional: cobertura dos RF005-RF012 (captura, filtro, análise de pacotes).
- Desempenho: latência baixa no _pipeline_ C++ → WebAssembly → _UI_ (RNF001-RNF003).
- Compatibilidade: interoperar via formatos abertos (CSV/JSON) e APIs.
- Usabilidade: _UI_ clara para entusiastas de redes; proteção a erros de entrada.
- Confiabilidade: execução contínua e recuperação de falhas de captura.
- Segurança: autenticação, criptografia de senhas e controle de acesso (RNF004-RNF006).
- Manutenibilidade: modularização do _backend_ e componentes de _UI_ testáveis.
- Portabilidade: _build_ C++ multiplataforma; suporte a navegadores modernos.

== Medição e avaliação
- Use ISO/IEC 25023 para indicadores (ex.: tempo de resposta, uso de CPU/RAM, taxa de falhas, cobertura de requisitos).
- Planeje a avaliação conforme ISO/IEC 25040 (processo de avaliação), definindo métricas, critérios e evidências (testes, _logs_, inspeções).

= REQUISITOS DO SISTEMA DE _SOFTWARE_
== Requisitos Funcionais
=== Autenticação e Gerenciamento de Usuários
- *RF001*: O sistema deve permitir que novos usuários se cadastrem fornecendo um e-mail e uma senha.
- *RF002*: O sistema deve permitir que usuários cadastrados sejam autenticados utilizando seu e-mail e senha.
- *RF003*: O sistema deve permitir que um usuário autenticado encerre sua sessão de forma segura.
- *RF004*: O sistema deve garantir que apenas usuários autenticados possam acessar as páginas do _dashboard_ de visualização de dados.

=== Monitoramento de Tráfego
- *RF005*: O _backend_ em C++ deve capturar pacotes da rede local em tempo real.
- *RF006*: O sistema deve processar os pacotes capturados para extrair informações relevantes.
- *RF007*: O _backend_ deve enviar os dados processados para o _frontend_ para visualização.
- *RF008*: O _dashboard_ _web_ deve exibir os dados de tráfego de rede recebidos do _backend_ de forma dinâmica.
- *RF009*: Os dados na interface devem ser apresentados de maneira clara e organizada.

=== Filtragem de Tráfego
- *RF010*: O sistema deve fornecer ao usuário a capacidade de filtrar os dados de tráfego exibidos no _dashboard_.

=== Análise de Pacotes
- *RF011*: O sistema deve permitir que o usuário inspecione os detalhes de um pacote específico.
- *RF012*: O sistema deve detectar e informar ao usuário sobre erros que impeçam a captura de dados.

== Requisitos Não-Funcionais
=== Desempenho
- *RNF001*: O _backend_ em C++ deve capturar e processar pacotes com baixa latência com o intuito de garantir a visualização dos dados em tempo real.
- *RNF002*: A _UI_ (Interface do Usuário) do _dashboard_ _web_ deve ser responsiva a atualizar os dados de tráfego de forma fluida, ou seja, sem travamentos.
- *RNF003*: A filtragem de dados exibidos pelo _dashboard_ _web_ deve produzir resultados de forma ideal---rápido, e suave ou harmonizada.

=== Segurança
- *RNF004*: As senhas dos usuários cadastrados devem ser guardadas de forma segura no banco de dados, utilizando técnicas e algoritmos avançados de criptografia.
- *RNF005*: A comunicação entre o _frontend_ e o _backend_ deve ser segura, especialmente durante o processo de autenticação.
- *RNF006*: O acesso ao _dashboard_ _web_ para visualização de dados deve ser estritamente controlado por sessão de usuário autenticada.

=== Usabilidade
- *RNF007*: A _UI_ do _dashboard_ _web_ deve ser intuitiva e de fácil compreensão para usuários com conhecimento em redes.
- *RNF008*: Os dados de tráfego da rede devem ser apresentados de forma clara e organizada para fácil visualização.
- *RNF009*: A filtragem de dados e a inspeção de pacotes devem ser de fácil acesso e utilização.

=== Compatibilidade
- *RNF010*: O _dashboard_ _web_ deve ser compatível com as versões mais recentes dos navegadores mais utilizados no mercado (e.g. Google Chrome, Mozilla Firefox, Brave).
- *RNF011*: O _backend_ em C++ deve ser multiplataforma, ou seja, compilável para o _Kernel_ dos sistemas operacionais mais utilizados (e.g. Unix-based, Windows).

=== Confiabilidade
- *RNF012*: O sistema de captura de dados (_backend_) deve operar de forma estável e contínua, sem interrupções inesperadas.
- *RNF013*: O sistema deve apresentar _Exception handling_---i.e. lidar de forma adequada com possíveis erros de captura de dados da rede (e.g. falta de permissão na interface de rede), informando o usuário sobre o problema.

=== Tecnologia
- *RNF014*: O _backend_ do sistema deve ser desenvolvido em C++ para garantir alto desempenho na manipulação de pacotes.
- *RNF015*: A integração e comunicação entre o _frontend_ e o _backend_ em C++ deve ser realizada utilizando WebAssembly.

= PROTÓTIPO DE INTERFACE
== Visão geral
- _Frontend_: Next.js + Supabase (autenticação).
- URL de demonstração: #link("https://netprobe.vercel.app")[netprobe.vercel.app]
- Objetivo do protótipo: demonstrar autenticação, visualização em tempo real e inspeção básica de pacotes.

== Fluxos demonstrados
- _Login_ e cadastro de usuário.
- Monitoramento em tempo real: listagem/tabela de pacotes.
  - Observe que o protótipo usa dados simulados (_mock_) para demonstração.
- Filtragem por protocolo, IP, porta.
- Inspeção de pacote (detalhes de cabeçalhos).

== Evidências visuais
#figure(
  [
    #image("assets/5.png")
    #text(size: 10pt)[Fonte: Autor.]
  ],
  caption: "Tela de login.",
)
#figure(
  [
    #image("assets/2.png")
    #text(size: 10pt)[Fonte: Autor.]
  ],
  caption: "Dashboard em tempo real.",
)
#figure(
  [
    #image("assets/3.png")
    #text(size: 10pt)[Fonte: Autor.]
  ],
  caption: "Filtro aplicado.",
)
#figure(
  [
    #image("assets/6.png")
    #text(size: 10pt)[Fonte: Autor.]
  ],
  caption: "Detalhes do pacote.",
)

== Limitações atuais
- Protótipo sem paginação/otimizações de _UI_ para grandes volumes.
- Cobertura parcial de protocolos na visualização de detalhes.

== Protótipo de _Backend_ (Prova de Conceito)
- Escopo: captura de pacotes em ambiente local, fornecendo metadados (IP origem/destino, portas, protocolo, tamanho, e _payload_).
- Ambiente: Arch Linux x86_64, interface `enp3s0`, permissões via `sudo`.
- Resultado: captura de pacotes bem-sucedida.
- Evidências: amostras de registros de captura e contadores (pacotes/s, latência média).
- Limitações: suporte parcial a protocolos; ausência de persistência/armazenamento histórico.
- Próximos passos: métricas RNF (latência, CPU/RAM), robustez (reconexão e tratamento de erros), testes com `.pcap`.
- Código-fonte: #link("https://github.com/1neskk/netprobe-cpp")[github.com/1neskk/netprobe-cpp]

== Relação com requisitos de qualidade
- Desempenho (RNF001-RNF003): registrar tempos de atualização e uso de recursos.
- Usabilidade (RNF007-RNF009): validar clareza da _UI_ nos fluxos acima.
- Compatibilidade (RNF010-RNF011): testes em navegadores e SOs alvo.
- Confiabilidade (RNF012-RNF013): execução contínua e tratamento de falhas.

= PLANO DE GESTÃO DE CONFIGURAÇÃO DO _SOFTWARE_
== Introdução e Propósito
Esta seção descreve o plano e os procedimentos para o Gerenciamento de Configuração de _Software_ (GCS) do projeto NetProbe. O propósito deste plano é garantir que a integridade de todos os artefatos do projeto seja mantida ao longo de todo o seu ciclo de vida. Ele estabelece os processos para controle de versão, controle de mudanças, auditoria e relatório de status, prevenindo a introdução de erros e garantindo que todas as partes interessadas trabalhem com versões consistentes e aprovadas dos artefatos.

== Escopo do GCS
Este plano se aplica a todos os artefatos produzidos durante o projeto, desde a sua concepção até a entrega final. Isso inclui, mas não se limita a, documentação, código-fonte, scripts de _build_, casos de teste e executáveis. O GCS será aplicado durante todas as fases do projeto.

== Identificação dos Itens de Configuração de _Software_ (ICSs)
Os seguintes artefatos são definidos como Itens de Configuração de _Software_ (ICSs) e estarão sob controle de configuração. Qualquer mudança nestes itens deve seguir o processo de controle de mudanças descrito na @section-a.

- *Documentação do Projeto*: Todos os documentos relacionados ao projeto, incluindo requisitos, especificações, planos de teste e manuais do usuário.
- *Código-Fonte*: Todo o código-fonte do _software_, incluindo bibliotecas e módulos.
- *Scripts de _Build_*: Scripts utilizados para compilar e construir o _software_.
- *Casos de Teste*: Documentação dos casos de teste, incluindo scripts automatizados.
- *Executáveis*: Versões compiladas do _software_ prontas para distribuição.

== Controle de Versão e Ferramentas
- *Ferramenta*: O controle de versão será realizado utilizando o Git.
- *Repositório Central*: Um repositório central será hospedado no GitHub. O projeto terá dois repositórios privados separados: um para o _backend_ e outro para o _frontend_.
- *Estratégia de Ramificação (_Branching Strategy_)*: A estratégia de ramificação seguirá o modelo Git Flow, com ramificações principais para desenvolvimento, testes e produção.
  - `master`: Contém o código de produção estável (_baselines_). Ninguém deve fazer _commits_ diretamente nesta ramificação.
  - `dev`: Ramificação principal para desenvolvimento. Todos os desenvolvedores farão _commits_ nesta ramificação.
  - `feature/*`: Ramificações para desenvolvimento de novas funcionalidades. Criadas a partir da ramificação `dev` e mescladas de volta após a conclusão.
  - `release/*`: Ramificações para preparação de lançamentos. Criadas a partir da ramificação `dev` e mescladas em `master` e `dev` após a conclusão.
- *Política de _Commits_*: Mensagens de _commit_ devem ser claras e descritivas, seguindo o padrão "tipo: descrição breve". Ex: `feat: adicionar filtro por protocolo`.

== Processo de Controle de Mudanças
<section-a>
Dado o tamanho da equipe (2 pessoas), um processo ágil e simplificado será adotado.

*1. Solicitação da Mudança:* Qualquer necessidade de mudança (nova funcionalidade, correção de _bug_, refatoração) deve ser registrada como uma _Issue_ no repositório do GitHub correspondente.

*2. Análise de Impacto:* A equipe (ambos os desenvolvedores) se reúne brevemente para analisar a _Issue_. Eles avaliam o impacto no cronograma, na arquitetura e em outros componentes do _software_. A decisão de prosseguir é registrada na própria _Issue_.

*3. Implementação:* O desenvolvedor designado cria uma _feature_ _branch_ a partir da `dev` e implementa a mudança.

*4. Validação e Revisão:* Ao concluir a implementação, o desenvolvedor abre um _Pull Request_ (PR) para mesclar sua _feature_ _branch_ na `dev`. O outro desenvolvedor é responsável por revisar o código (_Code Review_), garantindo que ele atende aos requisitos e não introduz problemas.

*5. Integração:* Após a aprovação do PR, a mudança é mesclada na _branch_ `dev`. A _feature_ _branch_ é então deletada.

Nenhuma mudança será integrada à _branch_ `dev` sem passar por um _Pull Request_ e uma revisão.

== Estabelecimento de _Baselines_

Uma _baseline_ representa uma versão estável e formalmente revisada de um ou mais ICSs. As _baselines_ serão criadas nos marcos principais do projeto e materializadas através de tags no Git na _branch_ main.

*_Baseline_ 1:* "MVP Integrado" (v0.9.0) - Prevista para 07/11/2025. Representa a primeira versão com todas as funcionalidades integradas e funcionando.

*_Baseline_ 2:* "Projeto Concluído e Entregue" (v1.0.0) - Prevista para 28/11/2025. Representa a versão final e estável a ser entregue.Para criar uma _baseline_, a _branch_ `dev` será mesclada na `master` e uma tag será criada (ex: git tag -a v1.0.0 -m "Versão 1.0.0 - Entrega Final").

== Auditoria de Configuração

A auditoria visa garantir que o processo de GCS está sendo seguido e que as _baselines_ são consistentes.

*Auditoria Contínua:* O processo de _Pull Request_ e _Code Review_ serve como uma micro-auditoria constante.

*Auditoria de _Baseline_:* Antes de criar uma _baseline_ (ex: v1.0.0), uma verificação formal será realizada para garantir que todos os PRs aprovados e relacionados àquele marco foram mesclados e que a _build_ está funcionando corretamente.

== Relatório de Status da Configuração

O status do projeto e das mudanças será comunicado através das ferramentas existentes:

*Quadro de Projetos (Kanban) do GitHub:* Para visualizar o status de todas as _Issues_ (A Fazer, Em Andamento, Em Revisão, Concluído).

*Histórico de _Commits_ e _Pull Requests_:* Fornece um _log_ detalhado de todas as mudanças implementadas.

*Notas de Lançamento (_Release_ Notes):* A cada _baseline_ criada na _branch_ `master`, notas de lançamento serão geradas (possivelmente de forma automatizada a partir das mensagens de _commit_) para resumir as mudanças.

== Papéis e Responsabilidades

*Desenvolvedor A (_Full-stack_):* Atua como o Gerente de Configuração. É responsável por manter a saúde dos repositórios, gerenciar os _merges_ para a _branch_ `master` e criar as tags de _baseline_.

*Ambos os Desenvolvedores:* São responsáveis por seguir o plano, criar _Issues_ detalhadas, desenvolver em _branches_ separadas, realizar _code reviews_ e manter a qualidade do código.

= TESTES
== Estratégia e Plano de Testes
*Objetivo:* Verificar e validar todos os requisitos funcionais (RF001-RF012) e não-funcionais (RNF001-RNF015) do NetProbe, garantindo qualidade, desempenho, segurança, confiabilidade, usabilidade e portabilidade.

=== Escopo dos Testes:
- Incluído: autenticação (cadastro, _login_, _logout_, acesso controlado), captura em tempo real, processamento e exibição de pacotes, filtragem, análise detalhada, detecção de erros.
- Incluído (RNF): desempenho (latência, uso de recursos), segurança (hash de senha, sessão), usabilidade (clareza da _UI_), compatibilidade (SO + navegadores), confiabilidade (execução contínua), integração WebAssembly.
- Fora de Escopo inicial: geração de relatórios históricos, persistência prolongada de tráfego, análises avançadas de ameaças.

=== Níveis de Teste:
- *Testes de Unidade:* Funções/métodos C++ (captura, _parser_ de cabeçalhos, formatação de saída), componentes React/Next.js (renderização de tabela, componente de filtro, modal de detalhes). Ferramentas: GoogleTest (_backend_), Jest + React Testing Library (_frontend_).
- *Testes de Integração:* Integração _backend_ C++ → WebAssembly → _frontend_; integração com Supabase (fluxo de autenticação); encadeamento captura → processamento → envio → atualização de _UI_.
- *Testes de Sistema (_End-to-End_):* Fluxos completos do usuário (cadastro → _login_ → monitorar → filtrar → analisar pacote → _logout_) usando Playwright.
- *Testes de Aceitação:* Execução do roteiro principal de casos contra RF/RNF com validação pelos desenvolvedores (stakeholders internos) antes das _baselines_.

=== Tipos de Teste:
- *Funcionais:* Verificação direta de cada RF.
- *Desempenho:* Medir latência média entre captura e exibição (< 500 ms alvo); atualizar _UI_ com < 16 ms por _frame_ sob carga moderada; CPU _backend_ < 15% em cenário padrão; memória estável.
- *Segurança:* Verificar _hashing_ (ex: bcrypt/argon2) de senhas; impedir acesso não autenticado; revisar transporte seguro; testes de tentativas de _login_ inválidas (_rate limit_ simulado).
- *Usabilidade:* Heurísticas básicas (clareza de _labels_, consistência de _feedback_); tempo de descoberta de filtros (< 10 s em teste exploratório); avaliação por _checklist_.
- *Compatibilidade:* _Backend_ compilado em Linux e teste de _build_ em Windows; _frontend_ em Chrome, Firefox, Brave.
- *Confiabilidade:* Execução contínua de captura por ≥ 2h sem falha; simulação de perda de permissão na interface de rede; recuperação (mensagem de erro visível).
- *Manutenibilidade/Testabilidade:* Cobertura de unidade meta ≥ 70% _backend_ (lógica crítica) e ≥ 60% _frontend_; execução automatizada em _pipeline_ CI.

=== Ambiente de Teste:
- *SO:* Arch Linux x86_64 (principal).
- *Navegadores:* Versões atuais (último _release_ estável) de Chrome, Firefox, Brave.
- *Hardware mínimo:* CPU dual-core, 4 GB RAM.
- *Dados de teste:* contas fictícias; arquivos .pcap (tráfego HTTP, DNS, ICMP). Sanitizar qualquer dado sensível.

=== Critérios de Entrada:
- Código compilável sem erros.
- Ambiente configurado (dependências instaladas).
- Requisitos e casos definidos.

=== Critérios de Saída:
- 100% dos casos críticos (RF001-RF012) aprovados.
- Nenhum defeito aberto de severidade alta.
- Métricas de desempenho dentro dos limites acordados.

=== Riscos e Mitigação:
- Dependência WebAssembly (instabilidade): criar teste de _fallback_ de reconexão.
- Permissões de rede: script pré-teste verifica privilégios; caso contrário aborta.
- Volume alto de pacotes causando _UI_ lenta: introduzir _batch_ e _debouncing_.

=== Automação:
- _Pipeline_ CI: _build_ C++ + execução GoogleTest; _build_ _frontend_ + Jest; Playwright (parcial noturno); relatório consolidado.

== Roteiro de Testes
O roteiro de testes detalha os casos de teste específicos para cada requisito funcional e não-funcional do sistema NetProbe. Cada caso de teste inclui o identificador, descrição, pré-condições, passos para execução, dados de entrada esperados, resultados esperados e critérios de aceitação.

Para acessar o roteiro completo de testes, consulte a @apendice-a.

// = Project Charter
// O Project Charter do NetProbe define a visão, objetivos, escopo, cronograma e recursos necessários para o desenvolvimento do software. Ele serve como um guia para a equipe de projeto e partes interessadas, garantindo alinhamento e clareza sobre o que o projeto pretende alcançar.

// Abaixo está uma visualização de uma página do Project Charter. Para acessar o documento completo, consulte a @apendice-b.
// #figure(
//   image("assets/netprobe_TAP.pdf"),
//   caption: "Project Charter do NetProbe. Fonte: Autor.",
// )

// = Diagrama de Gantt
// O Diagrama de Gantt do NetProbe ilustra o cronograma do projeto, destacando as principais fases, tarefas, marcos e dependências ao longo do tempo. Ele é uma ferramenta essencial para o planejamento e monitoramento do progresso do projeto.

// Para acessar o diagrama completo, consulte a @apendice-c.

= MÉTRICAS DE _SOFTWARE_
== Visão Geral
Esta seção define métricas quantitativas para acompanhar produto, requisitos, processo, testes, qualidade (McCall/ISO/IEC 25010) e desempenho (KPIs). Cada métrica tem fórmula, _baseline_ (MVP Integrado v0.9.0) e alvo (Entrega v1.0.0). Coleta automatizada via scripts (CI), _logs_ do _backend_, ferramentas de teste (GoogleTest, Jest, Playwright) e monitoramento.

== Métricas de Produto
- Cobertura de Requisitos (Funcionais): implementados / RF totais. _Baseline_: 10/12 = 83%. Alvo: 12/12 = 100%.
- Cobertura de Requisitos (Não-Funcionais): atendidos / RNF totais. _Baseline_: 9/15 = 60%. Alvo: ≥ 90%.
- Densidade de Defeitos: defeitos abertos (sev. alta) / KLOC. _Baseline_: 3/6 = 0.5. Alvo: < 0.3.
- Complexidade Ciclomática Média (_backend_ núcleo captura/parsing): Σ complexidade / nº funções núcleo. _Baseline_: 98/12 = 8.2. Alvo: ≤ 7.5.
- Duplicação de Código (_backend_, % linhas duplicadas): _Baseline_: 7%. Alvo: < 5%.
- Tamanho do Código: _backend_ 6 KLOC (C++), _frontend_ 4.5 KLOC (TS/JS). Monitorar crescimento controlado (< +25% até v1.0.0).

== Métricas do Modelo de Requisitos
- Ambiguidade: requisitos com termos vagos / total. _Baseline_: 5/27 = 18%. Alvo: < 5%.
- Rastreabilidade (req ↔ teste ↔ código): requisitos com _links_ completos / total. _Baseline_: 15/27 = 55%. Alvo: ≥ 90%.
- Volatilidade: mudanças aprovadas em requisitos / total por iteração. _Baseline_: 4/27 = 14%. Alvo: < 10%.
- Cobertura de Testes por Requisito: requisitos com ≥1 caso de teste / total. _Baseline_: 20/27 = 74%. Alvo: ≥ 100%.
- Consistência (sem conflitos): conflitos detectados / total. _Baseline_: 2 (processo de refinamento). Alvo: 0.

== Métricas de Processo
- _Lead Time_ (_Issue_ criação → _merge_ PR): média em horas. _Baseline_: 72h. Alvo: ≤ 48h.
- _Cycle Time_ (abertura PR → _merge_): _Baseline_: 30h. Alvo: ≤ 24h.
- Taxa de Retrabalho: PR rejeitados ou refeitos / PR total. _Baseline_: 5/32 = 15%. Alvo: < 10%.
- Frequência de _Commits_: média commits/dia (ativos). _Baseline_: 8. Alvo: 10 (menores, focados).
- Taxa de Automação CI (_pipelines_ verdes): execuções bem-sucedidas / total. _Baseline_: 41/50 = 82%. Alvo: ≥ 95%.
- Aderência a Branching (sem _commits_ direto em _master_): _Baseline_: 1 violação. Alvo: 0.

== Métricas de Teste
- Cobertura de Código _Backend_ (linha): _Baseline_: 62%. Alvo: ≥ 70%.
- Cobertura _Frontend_: _Baseline_: 48%. Alvo: ≥ 60%.
- Cobertura Interface WebAssembly (funções expostas críticas): _Baseline_: 55%. Alvo: ≥ 80%.
- _Pass Rate_ Regressão: casos passados / executados. _Baseline_: 88/95 = 92.6%. Alvo: ≥ 95%.
- Defeitos Detectados em Unidade / defeitos totais (Detecção Precoce): _Baseline_: 12/30 = 40%. Alvo: ≥ 55%.
- Taxa de Fuga de Defeitos (pós-baseline): _Baseline_: 6/30 = 20%. Alvo: < 15%.
- MTTR Defeitos (tempo médio correção severidade alta): _Baseline_: 10h. Alvo: < 8h.
- Tempo Execução _Suite_ CI (min): _Baseline_: 14m. Alvo: ≤ 10m.

== Métricas de Qualidade (McCall / ISO/IEC 25010)
Operação:
- Disponibilidade Captura (_uptime_ sessão contínua 8h): _Baseline_: 97.5%. Alvo: ≥ 99%.
- Correção Pacotes (campos extraídos corretos / verificados): _Baseline_: 91%. Alvo: ≥ 97%.
- Latência Captura → _UI_ (p95 ms): _Baseline_: 450 ms. Alvo: ≤ 300 ms.
- Uso Médio CPU _Backend_ (%): _Baseline_: 18%. Alvo: ≤ 15%.
- Uso Memória _Backend_ (MB): _Baseline_: 280 MB. Alvo: ≤ 250 MB.
Revisão:
- Complexidade Média Módulos _UI_ (ciclomática): _Baseline_: 5.2. Alvo: ≤ 5.
- Tempo _Onboarding_ _Dev_ (h para ambiente + _build_): _Baseline_: 6h. Alvo: 3h.
Transição:
- Portabilidade _Build_ (SO suportados / alvo 3: Linux, Windows, macOS): _Baseline_: 2/3. Alvo: 3/3.
- Reusabilidade Módulos (módulos com dependências externas < 3): _Baseline_: 60%. Alvo: 80%.
Segurança:
- Senhas com Argon2id (%): _Baseline_: 100%. Alvo: manter 100%.
- Tentativas de _Login_ Inválidas Bloqueadas (% simuladas): _Baseline_: 90%. Alvo: ≥ 95%.
Usabilidade:
- SUS (System Usability Scale) média teste interno: _Baseline_: 72. Alvo: ≥ 75.
- Tempo Descoberta Filtro (teste exploratório, s): _Baseline_: 14s. Alvo: ≤ 10s.
- Erros de Interação (ações inválidas por sessão): _Baseline_: 1.8. Alvo: < 1.

== KPIs de Desempenho
- _Throughput_ de Pacotes Processados (pps): _Baseline_: 1000 pps. Alvo: 2000 pps (rede de teste sintética).
- Latência p95 Captura → Renderização (ms): _Baseline_: 450 ms. Alvo: ≤ 300 ms.
- Queda de _Frames_ _UI_ (% _frames_ > 16 ms): _Baseline_: 5%. Alvo: < 2%.
- Tempo Autenticação (ms até _dashboard_): _Baseline_: 800 ms. Alvo: ≤ 400 ms.
- Tempo Exibição Detalhes do Pacote (ms): _Baseline_: 600 ms. Alvo: ≤ 350 ms.
- Erros Críticos Semanais (sev. alta): _Baseline_: 5. Alvo: ≤ 1.
- Sessão Estável (erros de desconexão em 8h): _Baseline_: 2. Alvo: 0.
- Tempo _Build_ _Backend_ (s full / incremental): _Baseline_: 45 / 18. Alvo: 30 / 12.
- Taxa de _Logs_ Estruturados (eventos com JSON válido / total eventos): _Baseline_: 70%. Alvo: ≥ 95%.

== Fórmulas (Resumo)
- Cobertura = itens atendidos / itens totais.
- Densidade Defeitos = defeitos severidade alta / KLOC.
- Volatilidade = alterações requisitos / requisitos totais (intervalo).
- _Cycle Time_ = merge_time - pr_open_time.
- MTTR = Σ tempo correção / nº defeitos severidade alta.
- Latência p95 = valor de latência no percentil 95 (histograma).
- _Throughput_ = pacotes processados / segundo (janela de 60s).

== Coleta & Frequência
- Diária: _throughput_, latência, uso CPU/memória, erros críticos.
- Por PR: complexidade, duplicação, cobertura de testes.
- Semanal: SUS (quando aplicável), disponibilidade captura, volatilidade requisitos.
- Em _baseline_: densidade de defeitos, rastreabilidade, portabilidade.

== Ações de Melhoria (Gatilhos)
- Latência p95 > alvo por 2 medições: revisar _buffer_ WebAssembly e _batch_ de envio.
- Cobertura _backend_ < 65%: adicionar testes para _parser_ de protocolos menos cobertos.
- Retrabalho > 12% em semana: revisar critérios de definição pronta (_Definition of Ready_).
- Duplicação > 6%: iniciar refatoração módulos utilitários.

== Observações
Valores _baseline_ são estimativas realistas do estado atual (MVP em evolução). Ajustes serão registrados nas Notas de Lançamento junto às tags de _baseline_ (v0.9.0, v1.0.0).

#pagebreak()

= REFERÊNCIAS
#{
  set par(leading: 0.2em)
  list(
    spacing: 1em,
    [ASSOCIAÇÃO BRASILEIRA DE NORMAS TÉCNICAS. _NBR 6023:2023 Informação e documentação - Referências - Elaboração._ Rio de Janeiro, 2023.],
    [ASSOCIAÇÃO BRASILEIRA DE NORMAS TÉCNICAS. _NBR 14724:2011 Informação e documentação - Trabalhos acadêmicos - Apresentação._ Rio de Janeiro, 2011.],
    [ISO/IEC. _ISO/IEC 25010:2011 Systems and _software_ engineering — Systems and _software_ Quality Requirements and Evaluation (SQuaRE) — System and _software_ quality models._ Geneva: International Organization for Standardization, 2011.],
    [ISO/IEC. _ISO/IEC 25023:2016 Systems and _software_ engineering — Systems and _software_ Quality Requirements and Evaluation (SQuaRE) — Measurement of system and _software_ product quality._ Geneva: International Organization for Standardization, 2016.],
    [ISO/IEC. _ISO/IEC 25040:2011 Systems and _software_ engineering — Systems and _software_ Quality Requirements and Evaluation (SQuaRE) — Evaluation process._ Geneva: International Organization for Standardization, 2011.],
    [PRESSMAN, Roger S.; MAXIM, Bruce R. _Software Engineering: A Practitioner's Approach._ 9. ed. New York: McGraw-Hill Education, 2020.],
  )
}

#pagebreak()

= GLOSSÁRIO
#{
  set par(first-line-indent: 0pt, hanging-indent: 0pt, leading: 0.5em)

  [*Backend*: Parte do servidor de uma aplicação, responsável pela lógica de negócios, acesso a banco de dados e processamento de informações.]

  linebreak()

  [*Baseline*: Ponto de referência fixo no ciclo de vida do projeto, representando uma versão aprovada de um artefato (código ou documentação) que só pode ser alterada através de procedimentos formais de controle de mudança.]

  linebreak()

  [*Branch*: Ramificação em um sistema de controle de versão que permite o desenvolvimento paralelo de funcionalidades isoladas do código principal.]

  linebreak()

  [*Bug*: Falha ou defeito no código de um _software_ que provoca um comportamento inesperado ou incorreto.]

  linebreak()

  [*Commit*: Ação de gravar alterações no repositório de controle de versão, criando um ponto de histórico recuperável.]

  linebreak()

  [*Dashboard*: Interface visual que organiza e apresenta informações importantes, métricas e indicadores de desempenho de forma consolidada.]

  linebreak()

  [*Deploy*: Processo de implantação do _software_ em um ambiente de uso (teste, homologação ou produção).]

  linebreak()

  [*Feature*: Funcionalidade ou característica específica do sistema que agrega valor ao usuário.]

  linebreak()

  [*Frontend*: Interface gráfica do usuário (GUI) de uma aplicação, ou seja, a parte com a qual o usuário interage diretamente.]

  linebreak()

  [*Full-stack*: Perfil de profissional ou arquitetura que compreende tanto o desenvolvimento do _frontend_ quanto do _backend_.]

  linebreak()

  [*Issue*: No contexto de ferramentas como GitHub, refere-se a um registro de tarefa, _bug_, solicitação de melhoria ou discussão técnica.]

  linebreak()

  [*Merge*: Operação de integração de alterações de uma ramificação (_branch_) para outra.]

  linebreak()

  [*Mock*: Objeto ou dado simulado utilizado em testes para reproduzir o comportamento de componentes reais de forma controlada.]

  linebreak()

  [*Payload*: Carga útil de dados transmitida em um pacote de rede, excluindo os cabeçalhos e metadados de protocolo.]

  linebreak()

  [*Pipeline*: Sequência automatizada de etapas (como compilação, testes e implantação) que o código percorre desde o desenvolvimento até a produção.]

  linebreak()

  [*Pull Request*: Solicitação formal para mesclar alterações de código de uma ramificação para outra, permitindo revisão por pares antes da integração.]

  linebreak()

  [*Release*: Versão estável do _software_ liberada para uso ou distribuição.]

  linebreak()

  [*WebAssembly*: Formato de código binário portátil e eficiente que permite a execução de aplicações de alto desempenho em navegadores _web_.]
}

#pagebreak()

= APÊNDICES
== Apêndice A - Roteiro de Testes (planilha)
<apendice-a>
#par(first-line-indent: 0pt)[
  Este apêndice referencia a planilha completa do roteiro de testes:
  #linebreak()
  #link(
    "https://1drv.ms/x/c/1c72ed29112d1df6/ESPq8AonxE1MkecXdK2Oa9wBjIS71QfvL9qFclKi17U9yA?e=sb9xT2",
  )[Microsoft Spreadsheets]
]

// == Apêndice B - Project Charter (documento)
// <apendice-b>
// #par(first-line-indent: 0pt)[
//   Este apêndice referencia o documento completo do Project Charter:
//   #linebreak()
//   #link("https://drive.google.com/file/d/10wKWpbc1yJ8renGeVdS1VwlejYbab88v/view?usp=sharing")[Google Drive]
// ]

// == Apêndice C - Diagrama de Gantt (arquivo OpenProj)
// <apendice-c>
// #par(first-line-indent: 0pt)[
//   Este apêndice referencia o arquivo completo do Diagrama de Gantt:
//   #linebreak()
//   #link("https://drive.google.com/file/d/1c6rXBmC4FmG8cVpx_bicf8C7_mjaSgHn/view?usp=sharing")[Google Drive]
// ]
