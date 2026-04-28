# Guia Rapido de Estudo - PagaAE

Este documento resume o fluxo, a estrutura e a sintaxe principal do projeto para revisao rapida.

## 1. Visao geral

O projeto e um app Flutter pequeno, organizado em telas, componentes reutilizaveis e modelos de dados.

Hoje ele funciona mais como um prototipo visual do que como um app completo:

- a navegacao entre telas funciona
- os formularios aparecem na interface
- quase todos os dados ainda estao fixos no codigo
- nao existe backend real ligado ao login, cadastro ou eventos

## 2. Estrutura do projeto

Arquivos mais importantes:

- `lib/main.dart`: ponto de entrada do app
- `lib/features/auth/presentation/screens/`: telas principais
- `lib/features/auth/components/`: widgets reutilizaveis das telas
- `lib/models/`: modelos como `User`, `Event`, `Charge` e `Invite`

Observacao importante:

- existem tambem pastas `domain/models` dentro de `features/`
- para entender o fluxo atual do app, o mais importante e focar em `main.dart`, `screens/`, `components/` e `lib/models/`

Leitura rapida da ideia:

- `main.dart` inicia o app
- `screens/` monta o fluxo visual
- `components/` evita repetir codigo de interface
- `models/` representa os dados do sistema

## 3. Fluxo das telas

Fluxo principal:

1. `main.dart` chama `runApp(const MyApp())`
2. `MyApp` cria o `MaterialApp`
3. a `home` inicial e `WelcomeScreen`
4. `WelcomeScreen` leva para `LoginScreen` ou `RegisterScreen`
5. `LoginScreen` leva para `HomeScreen`
6. `HomeScreen` pode abrir `CreateEventScreen`
7. `HomeScreen` tambem pode abrir `EventDetailScreen`
8. `CreateEventScreen` hoje apenas volta para a tela anterior
9. `EventDetailScreen` mostra detalhes mockados do evento

Resumo do fluxo em uma linha:

`main -> Welcome -> Login/Register -> Home -> Criar Evento / Detalhe do Evento`

## 4. O que cada tela faz

### `WelcomeScreen`

Tela inicial do app.

- mostra nome do produto
- mostra pequenas vantagens do sistema
- tem dois botoes: entrar e criar conta

### `LoginScreen`

Tela de login.

- tem campo de email e senha
- usa `TextEditingController` para controlar os inputs
- ao tocar em `Entrar`, navega para a `HomeScreen`
- ainda nao valida usuario nem senha

### `RegisterScreen`

Tela de cadastro.

- tem nome, email e senha
- visualmente esta pronta
- o botao principal ainda nao executa cadastro real

### `HomeScreen`

Tela principal depois do login.

- mostra um resumo do valor devido
- mostra lista de eventos
- mostra lista de pendencias
- tem `floatingActionButton` para criar evento

### `CreateEventScreen`

Tela de criacao de evento.

- recebe nome do evento
- recebe local
- recebe chave Pix
- permite escolher data e horario
- usa `setState` quando a data muda

### `EventDetailScreen`

Tela de detalhes de um evento.

- mostra resumo do evento
- lista gastos
- lista participantes
- mostra quem pagou e quem esta pendente

## 5. Por que dividir em widgets e componentes

O projeto separa partes repetidas da interface em widgets menores. Isso e bom porque:

- deixa a tela principal mais facil de ler
- evita copiar e colar o mesmo codigo
- mantem o visual padronizado
- facilita manutencao
- facilita testes e evolucao

Exemplos do projeto:

- `AuthScaffold`: reaproveita o fundo com gradiente
- `PrimaryButton` e `SecondaryButton`: reaproveitam botoes
- `AuthInput`: reaproveita o campo de formulario
- `AppColors`, `AppTextStyles`, `AppIcons`: centralizam estilo

Sem essa divisao, cada tela teria muito codigo repetido e ficaria mais dificil de entender.

## 6. Sintaxe Dart e Flutter que aparece no projeto

### `main`

```dart
void main() {
  runApp(const MyApp());
}
```

- `void`: a funcao nao retorna valor
- `main()`: primeira funcao executada
- `runApp(...)`: sobe a aplicacao Flutter

### `StatelessWidget`

Usado quando a tela nao guarda estado interno que muda.

```dart
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
}
```

Boa para telas mais estaticas.

### `StatefulWidget`

Usado quando a tela precisa mudar algo e redesenhar.

```dart
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
}
```

Exemplo do projeto:

- campos com `TextEditingController`
- data selecionada em `CreateEventScreen`

### `build(BuildContext context)`

Toda tela monta a interface dentro de `build`.

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(...);
}
```

- `Widget`: tipo de retorno
- `BuildContext`: contexto da arvore de widgets
- `return`: devolve a interface da tela

### `@override`

Mostra que um metodo esta sobrescrevendo um metodo herdado da classe pai.

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(...);
}
```

No Flutter, isso aparece muito em `build()` e `dispose()`.

### `final`

`final` significa que a variavel recebe valor uma vez so.

```dart
final _emailController = TextEditingController();
```

O objeto pode continuar existindo e ser usado, mas a referencia nao sera trocada.

### `const`

`const` cria um valor constante.

```dart
const SizedBox(height: 12)
```

Flutter usa muito `const` para otimizar widgets que nunca mudam.

### `static`

`static` significa que o valor pertence a classe, nao a uma instancia.

Exemplo do projeto:

```dart
class AppColors {
  static const green = Color.fromRGBO(36, 196, 105, 1);
}
```

Voce usa assim:

```dart
AppColors.green
```

Sem precisar criar `AppColors()`.

### `static const` e `static final`

#### `static const`

- pertence a classe
- nunca muda
- valor conhecido em tempo de compilacao

No projeto, isso aparece em `AppColors` e `AppIcons`, porque cor e icone sao fixos.

#### `static final`

- pertence a classe
- e criado uma vez so
- pode ser inicializado em tempo de execucao

Exemplo:

```dart
class Example {
  static final agora = DateTime.now();
}
```

Aqui nao pode ser `const`, porque `DateTime.now()` so existe quando o app esta rodando.

Regra pratica:

- use `static const` para valores fixos
- use `static final` para valores compartilhados que so podem ser criados em runtime

### `required`

Forca o envio de parametros nomeados.

```dart
const PrimaryButton({super.key, required this.text, required this.onPressed});
```

Isso evita criar o botao sem texto ou sem acao.

### `factory`

`factory` e um construtor especial. No projeto ele aparece muito em `fromJson`.

```dart
factory User.fromJson(Map<String, dynamic> json) {
  return User(...);
}
```

Ele e usado quando a criacao do objeto depende de alguma logica.

### Parametros nomeados

Muito comum em Flutter:

```dart
Text(
  'Entrar',
  style: AppTextStyles.title(36),
)
```

`style:` e um parametro nomeado.

### `?` (nullable)

Quando um tipo pode ser nulo:

```dart
final DateTime? createdAt;
```

Se tem `?`, pode guardar um valor ou `null`.

### Getter

O projeto usa getter aqui:

```dart
String get _dataFormatada { ... }
```

Parece um atributo, mas por tras executa logica para devolver o valor formatado.

### Funcao curta com `=>`

Forma resumida:

```dart
onPressed: () => Navigator.of(context).pop(),
```

E a mesma ideia de uma funcao curta com retorno direto.

### `_nome` privado

Em Dart, tudo que comeca com `_` fica privado ao arquivo.

Exemplos:

- `_LoginScreenState`
- `_header()`
- `_emailController`

Isso ajuda a esconder detalhes internos.

### `enum`

`enum` representa um conjunto fixo de opcoes.

```dart
enum EventStatus { upcoming, onGoing, finalized, canceled }
```

No projeto, isso ajuda a representar status sem usar texto solto em toda parte.

### `setState`

Quando um valor muda em um `StatefulWidget`, usa-se `setState`.

```dart
setState(() => _dataSelecionada = data);
```

Sem `setState`, a tela nao redesenha com o novo valor.

### `dispose()`

Controllers devem ser liberados quando a tela sai da memoria.

```dart
@override
void dispose() {
  _emailController.dispose();
  super.dispose();
}
```

Isso evita vazamento de memoria.

### Navegacao

O projeto usa `Navigator`.

```dart
Navigator.of(context).push(
  CupertinoPageRoute<void>(builder: (_) => const LoginScreen()),
);
```

Ideia das principais chamadas:

- `push`: empilha uma nova tela
- `pushReplacement`: troca a tela atual por outra
- `pop`: volta para a tela anterior

### Layout com widgets

Widgets muito usados aqui:

- `Scaffold`: estrutura base da tela
- `SafeArea`: evita notch e barras do sistema
- `SingleChildScrollView`: permite rolagem
- `Column`: organiza na vertical
- `Row`: organiza na horizontal
- `Container`: caixa com cor, borda, padding e decoracao
- `Expanded`: ocupa o espaco restante
- `SizedBox`: espacamento
- `Text`: texto
- `GestureDetector`: detecta toque

## 7. Modelos de dados

Os modelos ficam em `lib/models/`.

Principais classes:

- `User`: usuario
- `Event`: evento
- `Expenditure`: gasto
- `Charge`: cobranca entre usuarios
- `Invite`: convite
- `EventStatus` e `InviteStatus`: enums de status

### `fromJson`

Transforma um mapa em objeto Dart.

```dart
factory User.fromJson(Map<String, dynamic> json) {
  return User(
    id: (json['id'] as num).toInt(),
    name: json['name'] as String,
    email: json['email'] as String,
  );
}
```

### `toJson`

Transforma o objeto em mapa para API, banco ou serializacao.

### `copyWith`

Cria uma copia alterando so alguns campos.

```dart
final updated = original.copyWith(name: 'Carla');
```

Isso e muito usado para manter objetos imutaveis.

## 8. O que o projeto faz bem

- separa interface e estilo em arquivos menores
- usa componentes reutilizaveis
- tem modelos preparados para JSON
- tem fluxo de navegacao simples e facil de entender

## 9. O que ainda falta no projeto

- autenticacao real
- persistencia de dados
- lista de eventos vinda de backend
- validacao de formulario
- acoes reais para botoes finais

## 10. Resumo para estudo rapido

Se voce precisar explicar o projeto em pouco tempo, fale assim:

"O app foi feito em Flutter e organizado em widgets. O `main.dart` inicia o `MaterialApp` e abre a `WelcomeScreen`. Dali o usuario pode ir para login ou cadastro. Depois do login entra na `HomeScreen`, onde ve eventos e pendencias. Da home ele pode abrir a tela de criar evento ou a tela de detalhe do evento. O projeto usa componentes reutilizaveis para nao repetir codigo, como botoes, inputs e estilos. Nos modelos, usa `fromJson`, `toJson` e `copyWith`, o que deixa a estrutura pronta para integrar com backend no futuro." 

## 11. Frases-chave que valem na prova

- Flutter constroi tela por composicao de widgets.
- `StatelessWidget` e para interface sem mudanca interna.
- `StatefulWidget` e para interface com estado.
- `setState` redesenha a tela quando um valor muda.
- `Navigator` controla a navegacao entre telas.
- `final` trava a referencia depois da primeira atribuicao.
- `const` cria valor constante.
- `static` pertence a classe.
- `static const` serve para valores fixos compartilhados.
- `static final` serve para valores compartilhados criados em runtime.
- componentes menores deixam o codigo mais limpo e reutilizavel.
