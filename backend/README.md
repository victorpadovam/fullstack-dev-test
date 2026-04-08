# Gift Card Message Suggestion API

API backend em **Node.js + TypeScript** para gerar **2 a 3 sugestões curtas de mensagens** para cartão-presente, com base em:

- `occasion` (ocasião)
- `relationship` (relação com a pessoa)

A solução utiliza **Google Gemini API** (opção gratuita) como provedor de LLM e possui **fallback local** caso o modelo falhe.

---

##  Objetivo do projeto

Receber uma solicitação contendo:

- `occasion`
- `relationship`

E retornar:

- `2 a 3` mensagens curtas
- apropriadas para um cartão-presente
- em português
- com fallback seguro caso a LLM falhe

---

##  Stack utilizada

- **Node.js**
- **TypeScript**
- **Express**
- **Axios**
- **dotenv**
- **cors**
- **Google Gemini API** (free tier)
- **express-rate-limit** (opcional)

---

##  Como rodar o projeto

### 1. Pré-requisitos

- Node.js 18+ instalado
- npm instalado
- node -v v25.9.0

---

### 2. Instalar dependências

```bash
npm install
```


### 4. Rodar em modo desenvolvimento

```bash
npm run dev
```

---

### 5. Testar a API

#### Health check

```bash
curl -X GET http://127.0.0.1:3333/
```

Resposta esperada:

```json
{
  "message": "API rodando"
}
```

---

## Contrato da API

### Endpoint principal

**POST** `/api/v1/suggestions`

### Request Body

```json
{
  "occasion": "aniversário",
  "relationship": "amigo"
}
```

### Regras de entrada

- `occasion` é obrigatório
- `relationship` é obrigatório
- ambos devem ser strings não vazias

---

##  Resposta de sucesso

### Exemplo com LLM

```json
{
  "suggestions": [
    "Feliz aniversário! Que seu dia seja repleto de alegria e momentos especiais.",
    "Com carinho para um amigo muito especial. Que este novo ciclo seja incrível!",
    "Que seu aniversário seja tão especial quanto a sua amizade. Aproveite muito!"
  ],
  "source": "llm"
}
```

### Exemplo com fallback

```json
{
  "suggestions": [
    "Feliz aniversário! Que seu dia seja muito especial.",
    "Com carinho, para um amigo muito querido.",
    "Desejo alegria, saúde e momentos inesquecíveis."
  ],
  "source": "fallback"
}
```

---

## Resposta de erro de validação

Se faltar algum campo obrigatório:

```json
{
  "error": "occasion and relationship are required"
}
```

Status HTTP:

- `400 Bad Request`

---

##  Integração com LLM

### Provedor escolhido

Foi utilizado o **Google Gemini API**, por oferecer uma opção gratuita e integração simples via HTTP.

### Modelo sugerido

- `gemini-1.5-flash`


### Pós-processamento da resposta

Após receber a resposta da LLM, o backend:

1. extrai o texto retornado
2. separa por linhas
3. remove linhas vazias
6. se vier vazio ou inválido, ativa o fallback

---

## Tratamento de erros e fallback

### O que considero uma falha da LLM

A integração é considerada falha quando ocorre qualquer um dos cenários abaixo:

- timeout na chamada HTTP
- erro de rede
- erro `4xx` ou `5xx` do provedor
- chave inválida ou ausente
- resposta sem texto utilizável
- resposta fora do formato esperado

### Quando retornaria erro real para o cliente?

Erros do cliente ainda são retornados normalmente, por exemplo:

- body inválido
- campos obrigatórios ausentes

Nesses casos, a API responde:

- `400 Bad Request`

---

## Rate Limiting (opcional)

Foi considerada a implementação de **rate limiting** usando `express-rate-limit`.

### Estratégia sugerida

- Limite: `10 requisições por minuto por IP`

### Comportamento ao exceder

Resposta:

- `429 Too Many Requests`

Exemplo:

```json
{
  "error": "Too many requests, please try again later."
}
```

### Cache
Não utilizei cache neste teste, mas em produção utilizaria Redis para armazenamento temporário e redução de chamadas repetidas à API/LLM.

### Testes
 - npm test
    ✓ src/tests/suggestions.controller.test.ts (4 tests) 61ms
    ✓ src/tests/rate-limit.test.ts (1 test) 73ms
    Test Files  2 passed (2)
        Tests  5 passed (5)
