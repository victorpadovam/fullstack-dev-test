# Full Stack Developer Test – Gift Card Message Suggester

## Visão Geral

Este projeto foi desenvolvido como solução para o teste técnico **Full Stack Developer**, com o objetivo de criar uma aplicação que sugere **2 a 3 mensagens curtas para cartões-presente**, com base em:

* **occasion** (ocasião)
* **relationship** (grau de relacionamento)

A solução foi dividida em duas partes:

* **Backend**: API em **Node.js + TypeScript**, responsável por receber os dados, consultar um **LLM** e retornar sugestões formatadas.
* **Frontend**: aplicação em **Flutter**, com uma tela simples para o usuário informar os dados e visualizar as sugestões, com tratamento de **loading**, **sucesso** e **erro**.

---

# Versao do flutter
Flutter 3.27.1 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 17025dd882 (1 year, 4 months ago) • 2024-12-17 03:23:09 +0900
Engine • revision cb4b5fff73
Tools • Dart 3.6.0 • DevTools 2.40.2

## Backend (Node.js + TypeScript)

Responsabilidades:

* Expor o endpoint de sugestões
* Validar a entrada
* Montar o prompt para o LLM
* Tratar falhas da integração
* Retornar resposta padronizada para o frontend

## Frontend (Flutter / Dart)

Responsabilidades:

* Exibir a interface para o usuário
* Capturar ocasião e relacionamento
* Chamar o backend
* Gerenciar estados da tela:

  * carregando
  * sucesso
  * erro


## Frontend

* **Flutter**
* **Dart**
* `http` para requisições HTTP
* `ChangeNotifier` para gerenciamento de estado
* Estrutura separada em:

  * models
  * services
  * controllers
  * pages
  * widgets

## Testes (Frontend)
- Foi realizado testes unitarios e testes de widget
- flutter test

* **flutter_test**
* **mocktail**

---

#  API

## Endpoint

`POST /api/v1/suggestions`

### Exemplo de URL local

```http
POST http://localhost:3345/api/v1/suggestions
```

### Request Body

```json
{
  "occasion": "aniversário",
  "relationship": "amigo"
}
```

---

# Integração com LLM

O backend envia um prompt para um provedor de LLM com o objetivo de gerar:

* **2 a 3 sugestões**
* mensagens **curtas**
* apropriadas para **cartão-presente**
* adequadas ao contexto de:

  * ocasião
  * relacionamento

---

#  Tratamento de Erros e Fallback

## O que considero falha

As seguintes situações são tratadas como falha:

* timeout na chamada ao LLM
* resposta inválida do modelo
* erro de autenticação/configuração do provedor
* retorno vazio ou fora do formato esperado
* erro interno inesperado durante o processamento



# 📱 Frontend (Flutter)

## Funcionalidades implementadas

* Campo para **Ocasião**
* Campo para **Relacionamento**
* Botão para solicitar sugestões
* Exibição de:

  * loading
  * erro
  * lista de sugestões
* Integração com o backend local

## Demo Video

[▶️ Watch the demo video](./video.mp4)