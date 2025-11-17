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
    leading: 0.75em,
)

#let cover = (
    title: "NetProbe",
    instituition: "Universidade São Judas Tadeu",
    department: "Modelos, métodos e técnicas da engenharia de software",
    authors: (
        "Gabriel Almeida Portela - 825233281",
        "Daniel Almeida Portela",
    ),
    // Add these (fill them as needed)
    work: "Documentação do Produto de Software",
    degree: "Bacharel em Ciência da Computação",
    advisor: "Prof. Dr. Carlos L. Noriega",
    coadvisor: "",

    city: "São Paulo",
    year: 2025,
)

#set heading(numbering: "1.")

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

            #align(right)[
                #par(first-line-indent: 0pt, justify: true)[
                    #cover.work apresentado à Unidade Curricular de #cover.department da #cover.instituition, como requisito parcial para concluir o mesmo.
                    #linebreak()
                    #if cover.advisor != "" {
                        [Orientador: #cover.advisor]
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
                Este documento apresenta a documentação do produto de software NetProbe, desenvolvido como parte dos requisitos da disciplina Modelos, Métodos e Técnicas da Engenharia de Software na Universidade São Judas Tadeu. O NetProbe é uma ferramenta projetada para monitorar e analisar o desempenho de redes de computadores, oferecendo insights valiosos para administradores de rede. A documentação abrange desde a concepção inicial até a implementação final, incluindo diagramas UML, especificações técnicas e instruções de uso.
            ]
            #v(0.5fr)
            #par(first-line-indent: 0pt)[
                Palavras-chave: Documentação de Software, Engenharia de Software, Monitoramento de Redes, NetProbe.
            ]
        ],
    )

    pagebreak()

    page(
        [
            //#align(center)[
                //#text(weight: "bold")[#upper("Sumário")]
            //]
            //#v(0.5fr)
            #outline()
        ],
    )

    pagebreak()

    // Page counting starts from the folha de rosto (no number printed yet)
    counter(page).update(1)
    doc
}

= Introdução
== Tema
O software *NetProbe* é uma solução inovadora focada em segurança, eficiência e confiabilidade em redes de computadores, que serve como base para toda solução digital moderna. Este projeto também alinha-se com o objetivo 9 da ONU, que busca construir infraestruturas resilientes, promover a industrialização inclusiva e sustentável, e fomentar a inovação.

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
- *Gatilho*: O usuário acessa a página inicial e decide criar uma nova conta para acessar o dashboard.
- *Cenário de Sucesso Principal*: *1.* O usuário acessa a interface web do sistema. *2.* O sistema exibe a página de login e apresenta uma opção para "Cadastro". *3.* O usuário seleciona a opção de cadastro. *4.* O sistema exibe um formulário solicitando informações como e-mail e senha. *5.* O usuário preenche o formulário com dados válidos e o submete. *6.* O sistema valida os dados, cria a conta de usuário e armazena as informações de forma segura. *7.* O sistema redireciona o usuário para a página de login com uma mensagem de sucesso, indicando que o cadastro foi concluído.

- *Exceções*: *6a.* Se o e-mail fornecido já estiver cadastrado, o sistema exibe uma mensagem de erro informando que o usuário já existe. *6b.* Se os dados fornecidos forem inválidos (ex: formato de e-mail incorreto, senha fora do padrão exigido), o sistema exibe uma mensagem de erro e solicita a correção.

==== Autenticar-se no Sistema (Login)
- *Código*: UC02
- *Ator Principal*: Usuário
- *Pré-condições*: O usuário deve ter uma conta previamente cadastrada no sistema.
- *Gatilho*: O usuário deseja acessar o dashboard de monitoramento de rede.
- *Cenário de Sucesso Principal*: *1.* O usuário acessa a página de login do sistema. *2.* O usuário insere suas credenciais (e-mail e senha) nos campos correspondentes. *3.* O usuário submete o formulário de login. *4.* O sistema valida as credenciais. *5.* Após a autenticação bem-sucedida, o sistema concede acesso e exibe o dashboard principal de monitoramento de rede.

- *Exceções*: *4a.* Se as credenciais estiverem incorretas, o sistema exibe uma mensagem de "Usuário ou senha inválidos" e permite que o usuário tente novamente.

==== Monitorar Tráfego de Rede em Tempo Real
- *Código*: UC03
- *Ator Principal*: Usuário
- *Pré-condições*: O usuário está autenticado e na página do dashboard web. O backend em C++ está ativo e capturando pacotes da rede local.
- *Gatilho*: O usuário acessa o dashboard para visualizar a atividade da rede.
- *Cenário de Sucesso Principal*: *1.* Após o login, o usuário visualiza o dashboard principal. *2.* O backend em C++, integrado ao frontend via WebAssembly, captura os pacotes da rede. *3.* O dashboard exibe uma tabela ou lista que é atualizada em tempo real com os pacotes capturados. *4.* Para cada pacote, o sistema exibe informações essenciais como: endereço IP de origem, endereço IP de destino, porta de origem, porta de destino, protocolo (TCP, UDP, ICMP, etc.) e o volume de dados (tamanho do pacote).

- *Exceções*: *3a.* Caso o backend em C++ não consiga capturar o tráfego (ex: falta de permissões), o dashboard exibe uma mensagem de erro informando sobre a falha na captura de pacotes.

==== Filtrar Tráfego de Rede
- *Código*: UC04
- *Ator Principal*: Usuário
- *Pré-condições*: O usuário está autenticado e visualizando o tráfego em tempo real no dashboard.
- *Gatilho*: O usuário deseja isolar e visualizar pacotes específicos para uma análise mais focada.
- *Cenário de Sucesso Principal*: *1.* No dashboard, o usuário localiza os campos ou a seção de filtros. *2.* O usuário preenche um ou mais critérios de filtro, como: protocolo (ex: "HTTP"), endereço IP específico (origem ou destino) ou número de porta. *3.* O usuário aplica o filtro. *4.* O sistema processa a regra de filtro e atualiza a exibição do tráfego, mostrando apenas os pacotes que correspondem aos critérios definidos. *5.* O usuário tem a opção de modificar ou limpar os filtros para retornar à visualização completa.

- *Exceções*: *4a.* Se o usuário inserir um valor de filtro inválido (ex: um endereço IP mal formatado), o sistema exibe uma notificação de erro e não aplica o filtro até que seja corrigido.

==== Analisar Pacote de Dados
- *Código*: UC05
- *Ator Principal*: Usuário
- *Pré-condições*: O usuário está autenticado e visualizando a lista de pacotes no dashboard.
- *Gatilho*: O usuário identifica um pacote de interesse e deseja inspecionar seus detalhes técnicos.
- *Cenário de Sucesso Principal*: *1.* O usuário seleciona (clica em) um pacote específico na lista de tráfego. *2.* O sistema exibe uma visualização detalhada do pacote selecionado em uma janela modal ou em um painel lateral. *3.* Esta visualização apresenta o conteúdo decodificado do pacote, dividido por camadas, como o cabeçalho Ethernet, cabeçalho IP, cabeçalho do protocolo de transporte (TCP/UDP) e a carga útil (payload) dos dados. *4.* O usuário analisa as informações detalhadas para entender a natureza da comunicação. *5.* O usuário fecha a visualização de detalhes para retornar à lista principal de tráfego.

- *Exceções*: *3a.* Se o conteúdo do pacote estiver criptografado ou em um formato que não possa ser decodificado, o sistema exibirá as informações que conseguir interpretar (como os cabeçalhos) e indicará que a carga útil não é legível.

/*
== Fatores de Qualidade
Os fatores de qualidade de McCall é um modelo que fornece uma estrutura para inspecionar e garantir a qualidade de um produto de software. O modelo separa qualidade em 3 categorias --- Operação, Revisão e Transição do produto --- essas categorias são dividias em 11 fatores de qualidades. Essa seção aplica o modelo de qualidade de McCall para o software NetProbe.

=== Operação do Produto
==== Correção (Correctness)
- O sistema exibe corretamente os IPs de origem e destino, portas e protocolos de cada pacote?
- A função de cadastro e login operam exatamente como especificado nos requisitos (RF001 a RF004)?
- Os filtros aplicados pelo usuário retornam com precisão apenas os pacotes que correspondem aos critérios (filtros)?
- A análise de pacotes decodifica e exibe corretamente os dados dos cabeçalhos do respectivo pacote?

==== Confiabilidade (Reliability)
- O backend em C++ consegue capturar pacotes continuamente por longos períodos (horas ou dias) sem falhar?
- O sistema tem um jeito "gracioso" de lidar com erros, como a perda de acesso à interface de rede, informando o usuário sem travar?
- A conexão via WebAssembly entre o frontend e o backend é estável?

==== Eficiência (Efficiency)
- O backend em C++ tem baixo consumo de CPU e memória para não impactar o desempenho da máquina onde está rodando? (Fundamental para uma ferramenta de monitoramento).
- A atualização em tempo real do dashboard é otimizada para consumir poucos recursos do navegador?
- A aplicação de filtros é processada rapidamente, mesmo com um grande volume de pacotes sendo exibido?

==== Integridade (Integrity)
- O sistema impede que usuários não autenticados acessem o dashboard?
- As senhas dos usuários são armazenadas de forma segura (criptografadas)?
- O sistema garante que a captura de tráfego não abre brechas de segurança no sistema hospedeiro (_host machine_)?

==== Usabilidade (Usability)
- A interface do dashboard é clara e intuitiva para um "entusiasta de redes"?
- É fácil para o usuário encontrar e aplicar os filtros desejados?
- A visualização dos dados de um pacote é detalhada, organizada e fácil de ler?

=== Revisão do Produto
==== Manutenibilidade (Maintainability)
- O código-fonte é bem estruturado, comentado e segue padrões de programação?
- É fácil para um novo desenvolvedor entender a lógica de captura e processamento de pacotes no backend?
- Se um bug for encontrado na renderização do dashboard, quão rápido ele pode ser identificado e resolvido?

==== Flexibilidade (Flexibility)
- Qual seria a dificuldade para adicionar um novo critério de filtro (e.g. por tamanho do pacote)?
- Se no futuro for decidio adicionar a funcionalidade de "Gerar Relatórios" (que foi explicitamente excluída), a arquitetura atual facilita essa adição?
- Quão fácil é modificar a interface para suportar um novo tipo de gráfico ou visualização?

==== Testabilidade (Testability)
- O backend em C++ pode ser testado de forma automatizada, talvez usando arquivos de captura (`.pcap`) como entrada?
- Os componentes do frontend são isolados, permitindo a criação de testes unitários para a interface?
- Existem procedimentos claros para realizar testes de ponta a ponta (end-to-end), simulando o login, a aplicação de um filtro e a análise de um pacote?

=== Transição do Produto
==== Portabilidade (Portability)
- O backend em C++ pode ser compilado e executado em diferentes sistemas operacionais com pouca ou nenhuma modificação?
- O frontend web, por sua natureza, já é altamente portátil, mas ele funciona corretamente em todos os navegadores modernos?

==== Reusabilidade (Reusability)
- O módulo de autenticação de usuários poderia ser reutilizado em outro sistema web?
- A biblioteca C++ de captura de pacotes foi projetada de forma que possa ser usada como base para outra ferramenta de rede?

==== Interoperabilidade (Interoperability)
- O sistema poderia, futuramente, exportar os dados capturados em um formato padrão (como CSV ou JSON) para que possam ser importados por outras ferramentas de análise?
- Seria possível integrar o sistema com uma API externa para, por exemplo, verificar se um IP de origem está em uma lista de ameaças conhecidas (blacklist)?
*/
= Modelo de Qualidade ISO/IEC 25010
A ISO/IEC 25010:2011 define o modelo de qualidade de produto de software com oito características e suas subcaracterísticas, servindo de base para especificação, avaliação e melhoria da qualidade.

== Características e subcaracterísticas
- Adequação Funcional (Functional suitability)
  - Completude funcional; Correção funcional; Adequação/pertinência funcional.
- Eficiência de Desempenho (Performance efficiency)
  - Comportamento temporal; Utilização de recursos; Capacidade.
- Compatibilidade (Compatibility)
  - Coexistência; Interoperabilidade.
- Usabilidade (Usability)
  - Reconhecibilidade de adequação; Aprendibilidade; Operacionalidade; Proteção ao erro do usuário; Estética da interface; Acessibilidade.
- Confiabilidade (Reliability)
  - Maturidade; Disponibilidade; Tolerância a falhas; Recuperabilidade.
- Segurança (Security)
  - Confidencialidade; Integridade; Não repúdio; Responsabilização; Autenticidade.
- Manutenibilidade (Maintainability)
  - Modularidade; Reusabilidade; Analisabilidade; Modificabilidade; Testabilidade.
- Portabilidade (Portability)
  - Adaptabilidade; Instalabilidade; Substituibilidade.

== Aplicação ao NetProbe
- Adequação funcional: cobertura dos RF005–RF012 (captura, filtro, análise de pacotes).
- Desempenho: latência baixa no pipeline C++ → WebAssembly → UI (RNF001–RNF003).
- Compatibilidade: interoperar via formatos abertos (CSV/JSON) e APIs.
- Usabilidade: UI clara para entusiastas de redes; proteção a erros de entrada.
- Confiabilidade: execução contínua e recuperação de falhas de captura.
- Segurança: autenticação, criptografia de senhas e controle de acesso (RNF004–RNF006).
- Manutenibilidade: modularização do backend e componentes de UI testáveis.
- Portabilidade: build C++ multiplataforma; suporte a navegadores modernos.

== Medição e avaliação
- Use ISO/IEC 25023 para indicadores (ex.: tempo de resposta, uso de CPU/RAM, taxa de falhas, cobertura de requisitos).
- Planeje a avaliação conforme ISO/IEC 25040 (processo de avaliação), definindo métricas, critérios e evidências (testes, logs, inspeções).

= Requisitos do Sistema de Software
== Requisitos Funcionais
=== Autenticação e Gerenciamento de Usuários
- *RF001*: O sistema deve permitir que novos usuários se cadastrem fornecendo um e-mail e uma senha.
- *RF002*: O sistema deve permitir que usuários cadastrados sejam autenticados utilizando seu e-mail e senha.
- *RF003*: O sistema deve permitir que um usuário autenticado encerre sua sessão de forma segura.
- *RF004*: O sistema deve garantir que apenas usuários autenticados possam acessar as páginas do dashboard de visualização de dados.

=== Monitoramento de Tráfego
- *RF005*: O backend em C++ deve capturar pacotes da rede local em tempo real.
- *RF006*: O sistema deve processar os pacotes capturados para extrair informações relevantes.
- *RF007*: O backend deve enviar os dados processados para o frontend para visualização.
- *RF008*: O dashboard web deve exibir os dados de tráfego de rede recebidos do backend de forma dinâmica.
- *RF009*: Os dados na interface devem ser apresentados de maneira clara e organizada.

=== Filtragem de Tráfego
- *RF010*: O sistema deve fornecer ao usuário a capacidade de filtrar os dados de tráfego exibidos no dashboard.

=== Análise de Pacotes
- *RF011*: O sistema deve permitir que o usuário inspecione os detalhes de um pacote específico.
- *RF012*: O sistema deve detectar e informar ao usuário sobre erros que impeçam a captura de dados.

== Requisitos Não-Funcionais
=== Desempenho
- *RNF001*: O backend em C++ deve capturar e processar pacotes com baixa latência com o intuito de garantir a visualização dos dados em tempo real.
- *RNF002*: A _UI_ (Interface do Usuário) do dashboard web deve ser responsiva a atualizar os dados de tráfego de forma fluida, ou seja, sem travamentos.
- *RNF003*: A filtragem de dados exibidos pelo dashboard web deve produzir resultados de forma ideal---rápido, e suave ou harmonizada.

=== Segurança
- *RNF004*: As senhas dos usuários cadastrados devem ser guardadas de forma segura no banco de dados, utilizando técnicas e algoritmos avançados de criptografia.
- *RNF005*: A comunicação entre o frontend e o backend deve ser segura, especialmente durante o processo de autenticação.
- *RNF006*: O acesso ao dashboard web para visualização de dados deve ser estritamente controlado por sessão de usuário autenticada.

=== Usabilidade
- *RNF007*: A _UI_ do dashboard web deve ser intuitiva e de fácil compreensão para usuários com conhecimento em redes.
- *RNF008*: Os dados de tráfego da rede devem ser apresentados de forma clara e organizada para fácil visualização.
- *RNF009*: A filtragem de dados e a inspeção de pacotes devem ser de fácil acesso e utilização.

=== Compatibilidade
- *RNF010*: O dashboard web deve ser compatível com as versões mais recentes dos navegadores mais utilizados no mercado (e.g. Google Chrome, Mozilla Firefox, Brave).
- *RNF011*: O backend em C++ deve ser multiplataforma, ou seja, compilável para o Kernel dos sistemas operacionais mais utilizados (e.g. Unix-based, Windows).

=== Confiabilidade
- *RNF012*: O sistema de captura de dados (backend) deve operar de forma estável e contínua, sem interrupções inesperadas.
- *RNF013*: O sistema deve apresentar _Exception handling_---i.e. lidar de forma adequada com possíveis erros de captura de dados da rede (e.g. falta de permissão na interface de rede), informando o usuário sobre o problema.

=== Tecnologia
- *RNF014*: O backend do sistema deve ser desenvolvido em C++ para garantir alto desempenho na manipulação de pacotes.
- *RNF015*: A integração e comunicação entre o frontend e o backend em C++ deve ser realizada utilizando WebAssembly.

= Protótipo de Interface
== Visão geral
- Frontend: Next.js + Supabase (autenticação).
- URL de demonstração: #link("https://netprobe.vercel.app")[netprobe.vercel.app]
- Objetivo do protótipo: demonstrar autenticação, visualização em tempo real e inspeção básica de pacotes.

== Fluxos demonstrados
- Login e cadastro de usuário.
- Monitoramento em tempo real: listagem/tabela de pacotes.
    - Observe que o protótipo usa dados simulados (mock) para demonstração.
- Filtragem por protocolo, IP, porta.
- Inspeção de pacote (detalhes de cabeçalhos).

== Evidências visuais
// Inserir imagens reais depois; manter legenda em padrão ABNT (legenda abaixo, com “Figura X – ...” e fonte).
#figure(
    image("assets/1.png"),
    caption: "Tela de login. Fonte: Autor.",
)
#figure(
    image("assets/2.png"),
    caption: "Dashboard em tempo real. Fonte: Autor.",
)
#figure(
    image("assets/3.png"),
    caption: "Filtro aplicado. Fonte: Autor.",
)
#figure(
    image("assets/4.png"),
    caption: "Detalhes do pacote. Fonte: Autor.",
)

== Limitações atuais
- Protótipo sem paginação/otimizações de UI para grandes volumes.
- Cobertura parcial de protocolos na visualização de detalhes.

== Protótipo de Backend (Prova de Conceito)
- Escopo: captura de pacotes em ambiente local, fornecendo metadados (IP origem/destino, portas, protocolo, tamanho, e payload).
- Ambiente: Arch Linux x86_64, interface `enp3s0`, permissões via `sudo`.
- Resultado: captura de pacotes bem-sucedida.
- Evidências: amostras de registros de captura e contadores (pacotes/s, latência média).
- Limitações: suporte parcial a protocolos; ausência de persistência/armazenamento histórico.
- Próximos passos: métricas RNF (latência, CPU/RAM), robustez (reconexão e tratamento de erros), testes com `.pcap`.

== Relação com requisitos de qualidade
- Desempenho (RNF001–RNF003): registrar tempos de atualização e uso de recursos.
- Usabilidade (RNF007–RNF009): validar clareza da UI nos fluxos acima.
- Compatibilidade (RNF010–RNF011): testes em navegadores e SOs alvo.
- Confiabilidade (RNF012–RNF013): execução contínua e tratamento de falhas.

/*
= Plano de gestão de configuração do software
== Introdução e Propósito
Esta seção descreve o plano e os procedimentos para o Gerenciamento de Configuração de Software (GCS) do projeto NetProbe. O propósito deste plano é garantir que a integridade de todos os artefatos do projeto seja mantida ao longo de todo o seu ciclo de vida. Ele estabelece os processos para controle de versão, controle de mudanças, auditoria e relatório de status, prevenindo a introdução de erros e garantindo que todas as partes interessadas trabalhem com versões consistentes e aprovadas dos artefatos.

== Escopo do GCS
Este plano se aplica a todos os artefatos produzidos durante o projeto, desde a sua concepção até a entrega final. Isso inclui, mas não se limita a, documentação, código-fonte, scripts de build, casos de teste e executáveis. O GCS será aplicado durante todas as fases do projeto definidas no Diagrama de Gantt.

== Identificação dos Itens de Configuração de Software (ICSs)
Os seguintes artefatos são definidos como Itens de Configuração de Software (ICSs) e estarão sob controle de configuração. Qualquer mudança nestes itens deve seguir o processo de controle de mudanças descrito na seção 5.5("Processo de Controle de Mudanças").

- *Documentação do Projeto*: Todos os documentos relacionados ao projeto, incluindo requisitos, especificações, planos de teste e manuais do usuário.
- *Código-Fonte*: Todo o código-fonte do software, incluindo bibliotecas e módulos.
- *Scripts de Build*: Scripts utilizados para compilar e construir o software.
- *Casos de Teste*: Documentação dos casos de teste, incluindo scripts automatizados.
- *Executáveis*: Versões compiladas do software prontas para distribuição.

== Controle de Versão e Ferramentas
- *Ferramenta*: O controle de versão será realizado utilizando o Git.
- *Repositório Central*: Um repositório central será hospedado no GitHub. O projeto terá dois repositórios privados separados: um para o backend e outro para o frontend.
- *Estratégia de Ramificação (_Branching Strategy_)*: A estratégia de ramificação seguirá o modelo Git Flow, com ramificações principais para desenvolvimento, testes e produção.
    - `master`: Contém o código de produção estável (baselines). Ninguém deve fazer commits diretamente nesta ramificação.
    - `dev`: Ramificação principal para desenvolvimento. Todos os desenvolvedores farão commits nesta ramificação.
    - `feature/*`: Ramificações para desenvolvimento de novas funcionalidades. Criadas a partir da ramificação `dev` e mescladas de volta após a conclusão.
    - `release/*`: Ramificações para preparação de lançamentos. Criadas a partir da ramificação `dev` e mescladas em `master` e `dev` após a conclusão.
- *Política de Commits*: Mensagens de commit devem ser claras e descritivas, seguindo o padrão "tipo: descrição breve". Ex: `feat: adicionar filtro por protocolo`.

== Processo de Controle de Mudanças
Dado o tamanho da equipe (2 pessoas), um processo ágil e simplificado será adotado.

*1. Solicitação da Mudança:* Qualquer necessidade de mudança (nova funcionalidade, correção de bug, refatoração) deve ser registrada como uma Issue no repositório do GitHub correspondente.

*2. Análise de Impacto:* A equipe (ambos os desenvolvedores) se reúne brevemente para analisar a Issue. Eles avaliam o impacto no cronograma, na arquitetura e em outros componentes do software. A decisão de prosseguir é registrada na própria Issue.

*3. Implementação:* O desenvolvedor designado cria uma feature branch a partir da `dev` e implementa a mudança.

*4. Validação e Revisão:* Ao concluir a implementação, o desenvolvedor abre um Pull Request (PR) para mesclar sua feature branch na `dev`. O outro desenvolvedor é responsável por revisar o código (Code Review), garantindo que ele atende aos requisitos e não introduz problemas.

*5. Integração:* Após a aprovação do PR, a mudança é mesclada na branch `dev`. A feature branch é então deletada.

Nenhuma mudança será integrada à branch `dev` sem passar por um Pull Request e uma revisão.

== Estabelecimento de Baselines

Uma baseline representa uma versão estável e formalmente revisada de um ou mais ICSs. As baselines serão criadas nos marcos principais do projeto e materializadas através de tags no Git na branch main.

*Baseline 1:* "MVP Integrado" (v0.9.0) - Prevista para 07/11/2025. Representa a primeira versão com todas as funcionalidades integradas e funcionando.

*Baseline 2:* "Projeto Concluído e Entregue" (v1.0.0) - Prevista para 28/11/2025. Representa a versão final e estável a ser entregue.Para criar uma baseline, a branch `dev` será mesclada na `master` e uma tag será criada (ex: git tag -a v1.0.0 -m "Versão 1.0.0 - Entrega Final").

== Auditoria de Configuração

A auditoria visa garantir que o processo de GCS está sendo seguido e que as baselines são consistentes.

*Auditoria Contínua:* O processo de Pull Request e Code Review serve como uma micro-auditoria constante.

*Auditoria de Baseline:* Antes de criar uma baseline (ex: v1.0.0), uma verificação formal será realizada para garantir que todos os PRs aprovados e relacionados àquele marco foram mesclados e que a build está funcionando corretamente.

== Relatório de Status da Configuração

O status do projeto e das mudanças será comunicado através das ferramentas existentes:

*Quadro de Projetos (Kanban) do GitHub:* Para visualizar o status de todas as Issues (A Fazer, Em Andamento, Em Revisão, Concluído).

*Histórico de Commits e Pull Requests:* Fornece um log detalhado de todas as mudanças implementadas.

*Notas de Lançamento (Release Notes):* A cada baseline criada na branch `master`, notas de lançamento serão geradas (possivelmente de forma automatizada a partir das mensagens de commit) para resumir as mudanças.

== Papéis e Responsabilidades

*Desenvolvedor A (Full-stack):* Atua como o Gerente de Configuração. É responsável por manter a saúde dos repositórios, gerenciar os merges para a branch `master` e criar as tags de baseline.

*Ambos os Desenvolvedores:* São responsáveis por seguir o plano, criar Issues detalhadas, desenvolver em branches separadas, realizar code reviews e manter a qualidade do código.
*/