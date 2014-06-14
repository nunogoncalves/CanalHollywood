<h1>Canal Hollywood </h1>

Aplicação que faz scrapping ao site do Canal Hollywood (http://canalhollywood.pt), processa a informação e regista os dados.
Algumas features:
<ul>
  <li>Visualização de todas as programações desde o dia 1 de Março de 2012.</li>
  <li>Para além do registo da informação existente registada no site fonte, permite complementar essa informação editando manualmente os filmes. </li>
  <li>Visualização de todas as datas em que o filme foi reproduzido pelo canal.</li>
  <li>Trailers, links para imdb, links para a página original do canal hollywood.</li>
  <li>Gestão de actores, e associação dos a filmes.</li>
  <li>Visualização de estreias por mês.</li>
  <li>Filtros personalizados.</li>
  <li>Estatísticas.</li>
  <li>Ver os filmes que passaram nos últimos 7 dias</li>
  <li>Visualizar o canal em directo.</li>
  <li>Disponibiliza uma api REST (apenas GETs) que responde em JSON com o objectivo de ser consumida por aplicações móveis por exemplo. (WIP)</li>
</ul>

<img src="https://dl.dropboxusercontent.com/u/2001692/Guia%20Hollywood/programacao.png" style="width: 200px;"/>
<img src="https://dl.dropboxusercontent.com/u/2001692/Guia%20Hollywood/programacao2.png">
<img src="https://dl.dropboxusercontent.com/u/2001692/Guia%20Hollywood/programacao3.png">
<img src="https://dl.dropboxusercontent.com/u/2001692/Guia%20Hollywood/programacao4.png">

<strong>Listagem de filmes</strong>
<img src="https://dl.dropboxusercontent.com/u/2001692/Guia%20Hollywood/movies.png">

<strong>Listagem de actores</strong>
<img src="https://dl.dropboxusercontent.com/u/2001692/Guia%20Hollywood/actors.png">

Ferramenta | Descrição | GitHub
---------- | --------- | ------
rails | Motor da aplicação | https://github.com/rails/rails
postgres | Base de dados | https://github.com/postgres/postgres
jquery | Biblioteca Javascript | https://github.com/jquery/jquery
nokogiri | Parser HTML (entre outros) | https://github.com/sparklemotion/nokogiri
rails_admin | Interface para manutenção de dados. | https://github.com/sferik/rails_admin
simple_form | Gem para facilitar criação de formulários | https://github.com/plataformatec/simple_form
ransack | Motor de pesquisa em cima de Active Record | https://github.com/activerecord-hackery/ransack
active_model_serializers | Para facilitar a serialização de objectos | https://github.com/rails-api/active_model_serializers
usecasing | Ferramenta de padrão de desenvolvimento de Single Responsibility Principle | https://github.com/tdantas/usecasing
---

<h3>Testes</h3>
Ferramenta | Descrição | GitHub
---------- | --------- | ------
  rspec-rails | Ferramenta de testes para Ruby|https://github.com/rspec/rspec-rails
  rspec-mocks | Fazer mocks de objectos pesados | https://github.com/rspec/rspec-mocks
  database_cleaner | Limpa a db a cada teste | https://github.com/bmabey/database_cleaner
  simplecov | Utilitário que indica a paercentagem de código coberto por testes | https://github.com/colszowka/simplecov
  factory_girl_rails | Manutenção rápida de objectos | https://github.com/thoughtbot/factory_girl_rails
  vcr | Gravação de resultados de pedidos HTTP para usar nos testes seguintes | https://github.com/vcr/vcr
  webmock | |
  rake-progressbar | coloca uma progress bar em rake tasks |https://github.com/ondrejbartas/rake-progressbar
---