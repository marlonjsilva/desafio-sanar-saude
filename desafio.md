# Hello SRE

## Portal Covid-19

### Contexto
Suponha que temos uma conta nova na AWS vazia onde vamos construir uma nova infraestrutura. Nossa primeira solicitação é prover a infraestrutura que irá suportar um portal com notícias relacionadas a Covid-19. Temos a expectativa de ser o maior portal de referência para pessoas médicas nesse assunto.

Para tal, precisamos provisionar uma infraestrutura básica, funcional desde a primeira versão. Ela deve ser reutilizável para novas solicitações.
Como primeiro plano, vamos provisionar inicialmente (via Terraform):

* VPC com uma subrede
* Security Group para que as pessoas desenvolvedoras possam acessar e adicionar artefatos
Instância EC2
* O código Terraform pode ser visto aqui

### Expectativas

O time de SRE precisará entregar uma solução que seja:

* Fácil para as pessoas desenvolvedoras trabalharem
* Resiliente
* De fácil manutenção
* Com rápido tempo de resposta (por exemplo, se uma pessoa demorar mais alguns segundos para acessar nosso portal, provavelmente ela irá acessar o portal da concorrência e deixamos de ser referência)
* Segura

### Exercício

Dado cenário passado e a solução sugerida:

1. A solução é satisfatória? Em quais aspectos?
2. Quais perguntas a mais você faria?
3. O que você propõe de melhoria?

