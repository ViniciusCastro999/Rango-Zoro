-- Gerado por scripts/exportar-para-sql.mjs em 2026-09-08T14:32:57.661Z
-- Rode no SQL Editor do Supabase DEPOIS do schema.sql.
-- Pode rodar de novo quando quiser: limpa tudo e recarrega a partir dos YAML.
truncate itens, categorias, restaurantes restart identity cascade;

-- Buteco de Minas
insert into restaurantes (slug, nome, categoria, cozinha, bairro, endereco, whatsapp, site_pedido, instagram, emoji, taxa_entrega, taxa_entrega_valor, pedido_minimo, pedido_minimo_valor, pagamentos, horarios, pausado, pausa_motivo, destaque, cardapio_atualizado_em, observacoes, posicao) values (
  'buteco-de-minas', 'Buteco de Minas', 'Hambúrguer', array['lanche','hambúrguer','porções','buteco','suco']::text[], 'Centro', '', '5535997666991', null, '', '🍔', '', null, null, null, array['Pix','Dinheiro','Cartão']::text[], '{"seg":null,"ter":["18:00","23:59"],"qua":["18:00","23:59"],"qui":["18:00","23:59"],"sex":["18:00","23:59"],"sab":["18:00","23:59"],"dom":["18:00","23:00"]}'::jsonb, false, null, false, '2026-09-08', 'Hambúrguer é carne tradicional. Nos lanches com hambúrguer (X-Burguer, X-Salada, X-Bacon, X-Salada Bacon, X-Egg, X-Tudo, Buteco Duplo Cheddar e Buteco Especial) dá pra trocar por costela, fraldinha ou picanha, nas seções de cada carne. Porções: meia porção com acréscimo de 30%.', 100
);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('buteco-de-minas', 'Hambúrgueres artesanais', false, 10);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres artesanais'), 'Misto Quente', 14, 'Pão, presunto e queijo', 10),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres artesanais'), 'Bauru', 15, 'Pão, presunto, queijo e tomate', 20),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres artesanais'), 'Vegetariano', 20, 'Pão, 2 ovos, alface, tomate, milho, queijo e cheddar', 30),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres artesanais'), 'Americano', 20, 'Pão, 2 ovos, presunto, queijo, alface, tomate e milho', 40),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres artesanais'), 'X-Frango', 20, 'Pão, queijo, alface, tomate, milho e frango', 50),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres artesanais'), 'X-Burguer', 18, 'Pão, queijo, tomate e hambúrguer', 60),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres artesanais'), 'X-Salada', 20, 'Pão, queijo, alface, tomate, milho e hambúrguer', 70),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres artesanais'), 'X-Calabresa', 22, 'Pão, queijo, alface, tomate, milho e calabresa', 80),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres artesanais'), 'X-Lombo', 22, 'Pão, queijo, alface, tomate, milho e lombo', 90),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres artesanais'), 'X-Bacon', 22, 'Pão, queijo, tomate, hambúrguer e bacon', 100),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres artesanais'), 'X-Egg', 22, 'Pão, 2 ovos, queijo, alface, tomate, milho e hambúrguer', 110),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres artesanais'), 'X-Salada Bacon', 24, 'Pão, queijo, alface, tomate, hambúrguer e bacon', 120),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres artesanais'), 'Buteco Duplo Cheddar', 27, 'Pão, 2x queijo, 2x cheddar e 2x hambúrgueres', 130),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres artesanais'), 'X-Tudo', 29, 'Pão, ovo, queijo, salada, bacon, calabresa, frango e hambúrguer', 140),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres artesanais'), 'Buteco Especial', 32, 'Pão, ovo, presunto, queijo, salada, bacon, calabresa, frango, cheddar e hambúrguer', 150);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('buteco-de-minas', 'Hambúrgueres de costela', false, 20);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de costela'), 'X-Burguer de costela', 21, null, 10),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de costela'), 'X-Salada de costela', 23, null, 20),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de costela'), 'X-Bacon de costela', 25, null, 30),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de costela'), 'X-Egg de costela', 25, null, 40),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de costela'), 'X-Salada Bacon de costela', 27, null, 50),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de costela'), 'Buteco Duplo Cheddar de costela', 30, null, 60),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de costela'), 'X-Tudo de costela', 32, null, 70),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de costela'), 'Buteco Especial de costela', 35, null, 80);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('buteco-de-minas', 'Hambúrgueres de fraldinha', false, 30);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de fraldinha'), 'X-Burguer de fraldinha', 22, null, 10),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de fraldinha'), 'X-Salada de fraldinha', 24, null, 20),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de fraldinha'), 'X-Bacon de fraldinha', 26, null, 30),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de fraldinha'), 'X-Egg de fraldinha', 26, null, 40),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de fraldinha'), 'X-Salada Bacon de fraldinha', 28, null, 50),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de fraldinha'), 'Buteco Duplo Cheddar de fraldinha', 31, null, 60),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de fraldinha'), 'X-Tudo de fraldinha', 33, null, 70),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de fraldinha'), 'Buteco Especial de fraldinha', 36, null, 80);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('buteco-de-minas', 'Hambúrgueres de picanha', false, 40);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de picanha'), 'X-Burguer de picanha', 29, null, 10),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de picanha'), 'X-Salada de picanha', 30, null, 20),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de picanha'), 'X-Bacon de picanha', 33, null, 30),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de picanha'), 'X-Egg de picanha', 33, null, 40),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de picanha'), 'X-Salada Bacon de picanha', 34, null, 50),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de picanha'), 'Buteco Duplo Cheddar de picanha', 39, null, 60),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de picanha'), 'X-Tudo de picanha', 40, null, 70),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Hambúrgueres de picanha'), 'Buteco Especial de picanha', 44, null, 80);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('buteco-de-minas', 'Lanches no pão francês', false, 50);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Lanches no pão francês'), 'Pão com Linguiça', 21, 'Pão, queijo, alface, tomate, cebola e linguiça', 10),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Lanches no pão francês'), 'Pão com Lombo ou Pernil', 21, 'Pão, queijo, alface, tomate, cebola, lombo ou pernil', 20),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Lanches no pão francês'), 'Pão com Filé de Frango', 21, 'Pão, queijo, alface, tomate, cebola e filé de frango', 30),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Lanches no pão francês'), 'Pão com Contra Filé', 24, 'Pão, queijo, alface, tomate, cebola e contra filé', 40),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Lanches no pão francês'), 'Pão com Picanha', 30, 'Pão, queijo, alface, tomate, cebola e picanha', 50);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('buteco-de-minas', 'Adicionais', false, 60);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Adicionais'), 'Alface, tomate, milho ou batata palha', 1, null, 10),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Adicionais'), 'Presunto, queijo, ovo, calabresa, cheddar ou catupiry', 4, null, 20),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Adicionais'), 'Bacon', 5, null, 30),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Adicionais'), 'Hambúrguer artesanal, lombo, filé de frango ou linguiça caseira', 8, null, 40),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Adicionais'), 'Hambúrguer de costela', 11, null, 50),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Adicionais'), 'Hambúrguer de fraldinha', 12, null, 60),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Adicionais'), 'Picanha', 14, null, 70);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('buteco-de-minas', 'Porções', false, 70);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Porções'), 'Fritas', 28, null, 10),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Porções'), 'Mandioca frita', 28, null, 20),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Porções'), 'Calabresa', 34, null, 30),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Porções'), 'Lombo', 36, null, 40),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Porções'), 'Bolinho de carne seca', 38, null, 50),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Porções'), 'Bolinho de tilápia', 38, null, 60),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Porções'), 'Torresmo', 41, null, 70),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Porções'), 'Isca de frango empanada', 42, null, 80),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Porções'), 'Tulipa de frango à moda buteco', 45, null, 90),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Porções'), 'Filé de tilápia', 49, null, 100),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Porções'), 'Contra filé', 58, null, 110),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Porções'), 'Picanha', 78.9, null, 120);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('buteco-de-minas', 'Sucos', false, 80);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Sucos'), 'Abacaxi', 10, null, 10),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Sucos'), 'Abacaxi com hortelã', 10, null, 20),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Sucos'), 'Acerola', 10, null, 30),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Sucos'), 'Acerola com laranja', 10, null, 40),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Sucos'), 'Frutas vermelhas', 10, null, 50),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Sucos'), 'Laranja natural', 10, null, 60),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Sucos'), 'Limão', 10, null, 70),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Sucos'), 'Maracujá', 10, null, 80),
  ((select id from categorias where restaurante_slug='buteco-de-minas' and nome='Sucos'), 'Morango natural', 10, null, 90);

-- Cantinho da Serra
insert into restaurantes (slug, nome, categoria, cozinha, bairro, endereco, whatsapp, site_pedido, instagram, emoji, taxa_entrega, taxa_entrega_valor, pedido_minimo, pedido_minimo_valor, pagamentos, horarios, pausado, pausa_motivo, destaque, cardapio_atualizado_em, observacoes, posicao) values (
  'cantinho-da-serra', 'Cantinho da Serra', 'Pizzaria', array['pizza','esfiha','pizza doce']::text[], 'Serra Verde', 'Rua da Serra, 320 - Serra Verde', '5535999990004', null, '@cantinhodaserra', '🍕', 'Entrega R$ 6 (consultar bairro)', 6, 'R$ 30', 30, '{}'::text[], '{"seg":null,"ter":["18:00","23:00"],"qua":["18:00","23:00"],"qui":["18:00","23:00"],"sex":["18:00","23:59"],"sab":["18:00","23:59"],"dom":["18:00","23:00"]}'::jsonb, false, null, false, '2026-09-07', 'Borda recheada + R$ 15 (requeijão, cheddar, muçarela, chocolate, ninho, doce de leite ou romeu e julieta). Pizzas podem ser meio a meio, prevalece o maior valor. Todas as pizzas salgadas acompanham molho, orégano e azeitona. Esfiha doce com massa de chocolate: + R$ 0,50. Não entregam apenas bebidas.', 100
);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('cantinho-da-serra', 'Pizzas grandes (8 fatias)', true, 10);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), '3 queijos', 67, 'Muçarela, requeijão e provolone', 10),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), '4 queijos', 70, 'Muçarela, requeijão, provolone e parmesão', 20),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), '5 queijos', 70, 'Muçarela, requeijão, provolone, parmesão e gorgonzola', 30),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'A moda da casa', 70, 'Muçarela, linguiça, pimenta biquinho e cebola', 40),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Alho e óleo', 65, 'Muçarela e alho frito', 50),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Americana', 65, 'Muçarela, bacon, ovo e tomate', 60),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Atum', 65, 'Atum, tomate picado e cebola', 70),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Atum especial', 67, 'Atum, milho e muçarela', 80),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Bacon', 65, 'Muçarela e bacon', 90),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Baiana', 65, 'Molho apimentado, muçarela, calabresa ralada, ovo e cebola', 100),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Baiana forte', 70, 'Calabresa ralada, muçarela, milho, requeijão, pimenta calabresa e cebola', 110),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Bauru', 65, 'Muçarela, presunto e tomate', 120),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Bolonhesa', 67, 'Muçarela, carne moída, ovo, cebolinha e cebola', 130),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Brócolis', 70, 'Muçarela, brócolis, bacon, ervilha e alho frito', 140),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Caipira', 65, 'Frango, muçarela, milho, ervilha e cebola', 150),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Calabresa', 65, 'Calabresa, muçarela e cebola', 160),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Calabresa paulista', 65, 'Calabresa e cebola', 170),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Calabacon', 67, 'Calabresa, muçarela, bacon e cebola', 180),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Calabresa chiken', 67, 'Muçarela, frango, calabresa moída, milho e cebola', 190),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Canadense', 67, 'Lombo canadense, muçarela, palmito e cebola', 200),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Canadense cremosa', 70, 'Lombo canadense, muçarela, requeijão, provolone e cebola', 210),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Carne seca', 72, 'Muçarela, carne seca, requeijão e cebola', 220),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Copa de lombo', 72, 'Muçarela, copa de lombo defumada, requeijão e cebola', 230),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Coração gaúcho', 70, 'Muçarela, coração de frango, cebola e alho frito', 240),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Costela', 70, 'Muçarela, costela bovina desfiada, champignon e cebola', 250),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Estrogonofe', 70, 'Muçarela, frango desfiado, milho, champignon e batata palha', 260),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Francheddar', 65, 'Cheddar, frango, milho e cebola', 270),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Franbacon', 67, 'Frango, muçarela, bacon e cebola', 280),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Frango', 65, 'Frango, muçarela e cebola', 290),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Frango com requeijão', 67, 'Frango, muçarela e requeijão', 300),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Frango supremo', 70, 'Frango, creme de queijo e cebola', 310),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Holandesa', 70, 'Muçarela, atum, requeijão e cebola', 320),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Lombacon', 70, 'Muçarela, lombo, bacon e champignon', 330),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Muçarela', 65, 'Muçarela e tomate', 340),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Marguerita', 65, 'Muçarela, tomate picado, manjericão e parmesão', 350),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Mista', 69, 'Cheddar, calabresa, bacon, frango e cebola', 360),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Palmito', 65, 'Muçarela, palmito e cebola', 370),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Peperoni', 70, 'Muçarela, peperoni e manjericão', 380),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Peruana', 70, 'Muçarela, peito de peru, requeijão e bacon', 390),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Pernil', 70, 'Muçarela, pernil, tomate e cebola', 400),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Portuguesa', 65, 'Muçarela, presunto, ervilha, milho, ovo e cebola', 410),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Tilápia', 72, 'Muçarela, tilápia, parmesão e cebola', 420),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Tomate seco', 67, 'Muçarela, tomate seco, manjericão e parmesão', 430),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas grandes (8 fatias)'), 'Vegetariana', 65, 'Muçarela, abobrinha, palmito, tomate e parmesão', 440);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('cantinho-da-serra', 'Pizzas broto (4 fatias)', true, 20);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), '3 queijos', 49, 'Muçarela, requeijão e provolone', 10),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), '4 queijos', 52, 'Muçarela, requeijão, provolone e parmesão', 20),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), '5 queijos', 52, 'Muçarela, requeijão, provolone, parmesão e gorgonzola', 30),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'A moda da casa', 52, 'Muçarela, linguiça, pimenta biquinho e cebola', 40),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Alho e óleo', 47, 'Muçarela e alho frito', 50),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Americana', 47, 'Muçarela, bacon, ovo e tomate', 60),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Atum', 47, 'Atum, tomate picado e cebola', 70),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Atum especial', 49, 'Atum, milho e muçarela', 80),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Bacon', 47, 'Muçarela e bacon', 90),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Baiana', 47, 'Molho apimentado, muçarela, calabresa ralada, ovo e cebola', 100),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Baiana forte', 52, 'Calabresa ralada, muçarela, milho, requeijão, pimenta calabresa e cebola', 110),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Bauru', 47, 'Muçarela, presunto e tomate', 120),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Bolonhesa', 49, 'Muçarela, carne moída, ovo, cebolinha e cebola', 130),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Brócolis', 52, 'Muçarela, brócolis, bacon, ervilha e alho frito', 140),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Caipira', 47, 'Frango, muçarela, milho, ervilha e cebola', 150),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Calabresa', 47, 'Calabresa, muçarela e cebola', 160),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Calabresa paulista', 47, 'Calabresa e cebola', 170),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Calabacon', 49, 'Calabresa, muçarela, bacon e cebola', 180),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Calabresa chiken', 49, 'Muçarela, frango, calabresa moída, milho e cebola', 190),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Canadense', 49, 'Lombo canadense, muçarela, palmito e cebola', 200),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Canadense cremosa', 52, 'Lombo canadense, muçarela, requeijão, provolone e cebola', 210),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Carne seca', 54, 'Muçarela, carne seca, requeijão e cebola', 220),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Copa de lombo', 54, 'Muçarela, copa de lombo defumada, requeijão e cebola', 230),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Coração gaúcho', 52, 'Muçarela, coração de frango, cebola e alho frito', 240),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Costela', 52, 'Muçarela, costela bovina desfiada, champignon e cebola', 250),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Estrogonofe', 42, 'Muçarela, frango desfiado, milho, champignon e batata palha (⚠ conferir preço)', 260),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Francheddar', 47, 'Cheddar, frango, milho e cebola', 270),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Franbacon', 49, 'Frango, muçarela, bacon e cebola', 280),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Frango', 47, 'Frango, muçarela e cebola', 290),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Frango com requeijão', 49, 'Frango, muçarela e requeijão', 300),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Frango supremo', 52, 'Frango, creme de queijo e cebola', 310),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Holandesa', 52, 'Muçarela, atum, requeijão e cebola', 320),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Lombacon', 52, 'Muçarela, lombo, bacon e champignon', 330),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Muçarela', 47, 'Muçarela e tomate', 340),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Marguerita', 47, 'Muçarela, tomate picado, manjericão e parmesão', 350),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Mista', 51, 'Cheddar, calabresa, bacon, frango e cebola', 360),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Palmito', 47, 'Muçarela, palmito e cebola', 370),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Peperoni', 52, 'Muçarela, peperoni e manjericão', 380),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Peruana', 52, 'Muçarela, peito de peru, requeijão e bacon', 390),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Pernil', 52, 'Muçarela, pernil, tomate e cebola', 400),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Portuguesa', 47, 'Muçarela, presunto, ervilha, milho, ovo e cebola', 410),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Tilápia', 54, 'Muçarela, tilápia, parmesão e cebola', 420),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Tomate seco', 49, 'Muçarela, tomate seco, manjericão e parmesão', 430),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas broto (4 fatias)'), 'Vegetariana', 47, 'Muçarela, abobrinha, palmito, tomate e parmesão', 440);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('cantinho-da-serra', 'Pizzas doce grandes', true, 30);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas doce grandes'), 'Banana com chocolate', 65, 'Banana e chocolate', 10),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas doce grandes'), 'Banana com canela', 65, 'Banana, leite condensado, muçarela e canela', 20),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas doce grandes'), 'Banoffee', 65, 'Banana, doce de leite e canela', 30),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas doce grandes'), 'Brigadeiro', 65, 'Chocolate com granulado', 40),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas doce grandes'), 'Brownie', 67, 'Chocolate, brownie e castanha', 50),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas doce grandes'), 'Confete', 65, 'Chocolate com confete', 60),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas doce grandes'), 'Chocolate com queijo', 67, 'Chocolate e muçarela', 70),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas doce grandes'), 'Ovomaltine', 67, 'Cobertura de Ovomaltine', 80),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas doce grandes'), 'Pistache', 65, 'Chocolate, creme de pistache e castanha', 90),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas doce grandes'), 'Prestígio', 65, 'Chocolate, beijinho e coco ralado', 100),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas doce grandes'), 'Sensação', 65, 'Chocolate, morango e leite condensado', 110);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('cantinho-da-serra', 'Pizzas doce broto', true, 40);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas doce broto'), 'Banana com chocolate', 47, 'Banana e chocolate', 10),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas doce broto'), 'Banana com canela', 47, 'Banana, leite condensado, muçarela e canela', 20),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas doce broto'), 'Banoffee', 47, 'Banana, doce de leite e canela', 30),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas doce broto'), 'Brigadeiro', 47, 'Chocolate com granulado', 40),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas doce broto'), 'Brownie', 49, 'Chocolate, brownie e castanha', 50),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas doce broto'), 'Confete', 47, 'Chocolate com confete', 60),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas doce broto'), 'Chocolate com queijo', 49, 'Chocolate e muçarela', 70),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas doce broto'), 'Ovomaltine', 49, 'Cobertura de Ovomaltine', 80),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas doce broto'), 'Pistache', 47, 'Chocolate, creme de pistache e castanha', 90),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas doce broto'), 'Prestígio', 47, 'Chocolate, beijinho e coco ralado', 100),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Pizzas doce broto'), 'Sensação', 47, 'Chocolate, morango e leite condensado', 110);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('cantinho-da-serra', 'Esfihas', false, 50);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), '2 Queijos', 7.5, 'Muçarela e requeijão', 10),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), '3 Queijos', 8, 'Muçarela, provolone e requeijão', 20),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Alho e óleo', 7.5, 'Muçarela, alho frito e azeite', 30),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Atum', 8, 'Atum, tomate e cebola', 40),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Brócolis', 8, 'Brócolis, muçarela, bacon e alho frito', 50),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Bacon', 7.5, 'Muçarela e bacon', 60),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Baiana', 8, 'Muçarela, calabresa, requeijão e pimenta', 70),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Caipira', 8, 'Frango, milho e muçarela', 80),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Calabacon', 8, 'Calabresa, muçarela e bacon', 90),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Carne', 7.5, null, 100),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Carne com muçarela', 8, null, 110),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Carne com cheddar', 8, null, 120),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Carne com bacon', 8, null, 130),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Carne seca', 9, 'Carne seca, requeijão e muçarela', 140),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Calabresa', 7, null, 150),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Calabresa com muçarela', 7.5, null, 160),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Calabresa com requeijão', 7.5, null, 170),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Canadense', 8.5, 'Lombo, muçarela e requeijão', 180),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Costela', 8.5, 'Costela, muçarela e cebola', 190),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Frango', 7, null, 200),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Frango com muçarela', 7.5, null, 210),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Frango com cheddar', 7.5, null, 220),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Franbacon', 8, 'Frango, muçarela e bacon', 230),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Francheddar', 8, 'Frango, milho e cheddar', 240),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Frango com requeijão', 7.5, null, 250),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Frango, muçarela e requeijão', 8, null, 260),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Holandesa', 8.5, 'Atum, muçarela e requeijão', 270),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Mista', 8.5, 'Frango, calabresa e cheddar', 280),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Marguerita', 8, 'Muçarela, tomate e parmesão', 290),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Muçarela', 7, null, 300),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Palmito', 7.5, 'Muçarela e palmito', 310),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Peperoni', 8, 'Muçarela e peperoni', 320),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Pernil', 8.5, 'Muçarela, pernil, tomate e cebola', 330),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Presunto e queijo', 7.5, null, 340),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Tilápia', 9, 'Muçarela, tilápia e parmesão', 350),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas'), 'Tomate seco', 8, 'Muçarela, tomate seco e parmesão', 360);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('cantinho-da-serra', 'Esfihas doce', false, 60);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas doce'), 'Banana com chocolate', 7.5, 'Banana e chocolate', 10),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas doce'), 'Banana com canela', 7.5, 'Banana, muçarela e canela', 20),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas doce'), 'Banoffee', 7.5, 'Banana, doce de leite e canela', 30),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas doce'), 'Beijinho', 7, 'Beijinho e coco ralado', 40),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas doce'), 'Brigadeiro', 7, 'Chocolate e granulado', 50),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas doce'), 'Chocolate com confete', 7, null, 60),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas doce'), 'Chocolate com queijo', 7.5, 'Chocolate e muçarela', 70),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas doce'), 'Churros', 7.5, 'Empanada na canela com recheio de doce de leite', 80),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas doce'), 'Ninho', 7.5, 'Recheio sabor ninho e leite em pó', 90),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas doce'), 'Ovomaltine', 8, null, 100),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas doce'), 'Paçoca', 7.5, 'Doce de leite e paçoca', 110),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas doce'), 'Pistache', 7.5, 'Creme de pistache e castanha', 120),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas doce'), 'Prestígio', 7.5, 'Chocolate, beijinho e coco ralado', 130),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas doce'), 'Romeu e Julieta', 7.5, 'Muçarela e goiabada', 140),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Esfihas doce'), 'Sensação', 7.5, 'Chocolate e morango', 150);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('cantinho-da-serra', 'Bebidas', false, 70);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Bebidas'), 'Coca-Cola / Coca Zero / Fanta Laranja 2L', 16, null, 10),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Bebidas'), 'Guaraná Antártica 2L', 13, null, 20),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Bebidas'), 'Refrigerante 1L', 10, 'Guaraná Antártica ou Pepsi', 30),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Bebidas'), 'Refrigerante 600ml', 8, 'Guaraná Antártica ou Coca-Cola', 40),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Bebidas'), 'Coca-Cola vidro 250ml', 7, null, 50),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Bebidas'), 'Del Valle lata', 7, 'Sabores', 60),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Bebidas'), 'Refrigerante lata 350ml', 7, 'Guaraná, Fanta uva e laranja, Coca-Cola, Coca zero, Soda limonada', 70),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Bebidas'), 'Água mineral 500ml', 4, 'Com ou sem gás', 80),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Bebidas'), 'Amstel lata 473ml', 8, null, 90),
  ((select id from categorias where restaurante_slug='cantinho-da-serra' and nome='Bebidas'), 'Suco de polpa', 12, 'Abacaxi, abacaxi com hortelã, amora, uva, frutas vermelhas, maracujá, morango. Com leite + R$ 2,00', 100);

-- RED Lanches
insert into restaurantes (slug, nome, categoria, cozinha, bairro, endereco, whatsapp, site_pedido, instagram, emoji, taxa_entrega, taxa_entrega_valor, pedido_minimo, pedido_minimo_valor, pagamentos, horarios, pausado, pausa_motivo, destaque, cardapio_atualizado_em, observacoes, posicao) values (
  'red-lanches', 'RED Lanches', 'Hambúrguer', array['lanche','hambúrguer','hot dog','porções','prato executivo','cerveja']::text[], 'Centro', '', '5535984281806', null, '@red_lanchess', '🍔', 'Disk entrega até 23h, taxa R$ 5', 5, null, null, array['Pix','Dinheiro','Cartão']::text[], '{"seg":["12:00","22:00"],"ter":["12:00","22:00"],"qua":["12:00","22:00"],"qui":["12:00","22:00"],"sex":["12:00","22:00"],"sab":["12:00","22:00"],"dom":null}'::jsonb, false, null, false, '2026-09-08', 'Meia porção: acréscimo de 30%. Bebidas marcadas "consumo no local" não saem para entrega. Disk entrega até 23h, taxa R$ 5.', 100
);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('red-lanches', 'Lanches tradicionais', false, 10);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'Hambúrguer', 16, 'Pão, hambúrguer caseiro 70g, milho verde, maionese e batata palha', 10),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'Misto Quente', 17, 'Pão, presunto, queijo, milho verde, maionese e batata palha', 20),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'X-Burguer', 18, 'Pão, hambúrguer caseiro 70g, queijo, milho verde, maionese e batata palha', 30),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'Queijo Quente', 18, 'Pão, 4 fatias de queijo, milho verde, maionese e batata palha', 40),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'X-Bauru', 19, 'Pão, presunto, queijo, tomate, milho verde, maionese e batata palha', 50),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'X-Natural', 19, 'Pão, ovo, queijo, alface, tomate, milho verde, maionese e batata palha', 60),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'X-Pizza', 20, 'Pão, presunto, queijo, ovo, tomate, orégano, milho verde, maionese e batata palha', 70),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'Hot Dog', 20, 'Pão de hambúrguer, 2 salsichas, queijo, molho, ketchup, tomate, milho verde, maionese e batata palha', 80),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'X-Egg', 21, 'Pão, hambúrguer caseiro 70g, ovo, queijo, milho verde, maionese e batata palha', 90),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'X-Especial', 21, 'Pão, presunto, queijo, hambúrguer caseiro 70g, tomate, milho verde, maionese e batata palha', 100),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'X-Salada', 21, 'Pão, hambúrguer caseiro 70g, queijo, alface, tomate, milho verde, maionese e batata palha', 110),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'X-Frango', 22, 'Pão, frango, queijo, alface, tomate, milho verde, maionese e batata palha', 120),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'X-Americano', 23, 'Pão, hambúrguer caseiro 70g, presunto, queijo, ovo, tomate, milho verde, maionese e batata palha', 130),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'X-Bacon', 23, 'Pão, hambúrguer caseiro 70g, bacon, queijo, milho verde, maionese e batata palha', 140),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'X-Salada Bacon', 24, 'Pão, hambúrguer caseiro 70g, bacon, queijo, alface, tomate, milho verde, maionese e batata palha', 150),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'X-Salada Egg', 24, 'Pão, hambúrguer caseiro 70g, ovo, queijo, alface, tomate, milho verde, maionese e batata palha', 160),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'X-Egg Bacon', 24, 'Pão, hambúrguer caseiro 70g, ovo, bacon, queijo, milho verde, maionese e batata palha', 170),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'X-Salada Egg Bacon', 26, 'Pão, hambúrguer caseiro 70g, ovo, bacon, queijo, alface, tomate, milho verde, maionese e batata palha', 180),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'X-Frango Especial', 26, 'Pão, frango, queijo, catupiry, alface, tomate, milho verde, maionese e batata palha', 190),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'X-Frango Burguer', 26, 'Pão, hambúrguer caseiro 70g, frango, queijo, alface, tomate, milho verde, maionese e batata palha', 200),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'X-Frango Bacon', 26, 'Pão, frango, queijo, bacon, milho verde, maionese, alface, tomate e batata palha', 210),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'X-Calafrango', 26, 'Pão, calabresa, frango, queijo, alface, tomate, milho verde, maionese e batata palha', 220),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'X-Calabacon', 26, 'Pão, calabresa, bacon, hambúrguer caseiro 70g, queijo, milho verde, maionese e batata palha', 230),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'X-Calabresa', 26, 'Pão, calabresa, hambúrguer caseiro 70g, queijo, alface, tomate, milho verde, maionese e batata palha', 240),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'X-Califórnia', 27, 'Pão, hambúrguer caseiro 70g, presunto, queijo, ovo, tomate, milho verde, maionese e batata palha', 250),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'Hamburgão', 31, 'Pão, hambúrguer caseiro 150g, 4 fatias de queijo, alface, tomate, milho verde, maionese e batata palha', 260),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'X-Tudo', 35, 'Pão, hambúrguer caseiro 70g, presunto, queijo, ovo, frango, bacon, calabresa, alface, tomate, milho verde, maionese e batata palha', 270),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'Hamburgão Duplo', 37, 'Pão, 2 hambúrgueres caseiros 150g cada, 4 fatias de queijo, alface, tomate, milho verde, maionese e batata palha', 280),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Lanches tradicionais'), 'X-Red', 46, 'Pão, 2 hambúrgueres caseiros 70g cada, presunto, queijo, ovo, frango, bacon, calabresa, catupiry, alface, tomate, milho verde, maionese e batata palha', 290);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('red-lanches', 'Novidade do Red (pão francês)', false, 20);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Novidade do Red (pão francês)'), 'Pão com Linguiça', 27, 'Pão francês, linguiça caseira defumada, queijo e vinagrete', 10),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Novidade do Red (pão francês)'), 'X-Frango Crocante', 27, 'Pão francês, frango crocante, queijo, alface e vinagrete', 20);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('red-lanches', 'Pratos executivos', false, 30);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Pratos executivos'), 'Parmegiana de Frango', 35, 'Servido com arroz Vasconcelos e batata frita', 10),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Pratos executivos'), 'Parmegiana de Filé de Tilápia', 40, 'Servido com arroz Vasconcelos e batata frita', 20),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Pratos executivos'), 'Parmegiana Bovina', 40, 'Servido com arroz Vasconcelos e batata frita', 30);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('red-lanches', 'Porções', false, 40);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Porções'), 'Onion rings', 30, 'Anéis de cebola empanados', 10),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Porções'), 'Batata frita simples (média)', 18, null, 20),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Porções'), 'Batata frita simples (grande)', 28, null, 30),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Porções'), 'Batata frita completa (média)', 23, 'Coberta com cheddar e bacon', 40),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Porções'), 'Batata frita completa (grande)', 35, 'Coberta com cheddar e bacon', 50),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Porções'), 'Filé de tilápia (média)', 30, null, 60),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Porções'), 'Filé de tilápia (grande)', 45, null, 70),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Porções'), 'Contrafilé (média)', 30, null, 80),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Porções'), 'Contrafilé (grande)', 50, null, 90),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Porções'), 'Calabresa (média)', 25, null, 100),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Porções'), 'Calabresa (grande)', 35, null, 110),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Porções'), 'Mandioca frita (média)', 20, null, 120),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Porções'), 'Mandioca frita (grande)', 30, null, 130),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Porções'), 'Mini quibes com queijo', 30, null, 140),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Porções'), 'Mini coxinhas de mandioca', 30, 'Recheada com frango, alho-poró e cream cheese', 150),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Porções'), 'Bolinho de mandioca', 30, 'Recheado com costela ou queijo com alho-poró', 160),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Porções'), 'Bolinho de mandioca especial', 36, 'Recheado com carne seca com queijo', 170),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Porções'), 'Bolinho caipira', 30, 'Recheado com costela ou carne moída', 180),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Porções'), 'Torresmo', 35, null, 190),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Porções'), 'Bolinho de linguiça defumada', 36, null, 200),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Porções'), 'Bolinho costelão', 36, 'Massa de costela bovina ou suína, recheado com queijo', 210),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Porções'), 'Nhoque recheado', 24, 'Nhoque de mandioca recheado com frango com requeijão ou queijo com alho', 220),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Porções'), 'Mini churros', 30, 'Recheado com doce de leite', 230);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('red-lanches', 'Combos de porções', false, 50);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Combos de porções'), 'Balde de frango (médio, 500g)', 45, 'Frango a passarinho com batata rústica ou iscas de frango com batata rústica', 10),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Combos de porções'), 'Balde de frango (grande, 800g)', 65, 'Frango a passarinho com batata rústica ou iscas de frango com batata rústica', 20),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Combos de porções'), 'Red Box 1', 70, 'Aproximadamente 250g de cada, batata frita, onion rings, calabresa acebolada e isca de frango crocante', 30),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Combos de porções'), 'Red Box 2', 100, 'Aproximadamente 250g de cada, batata frita com cheddar e bacon, iscas de tilápia, mini chicken nuggets, mini quibes e mandioca frita', 40),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Combos de porções'), 'Red Box 3', 130, 'Aproximadamente 250g de cada, contrafilé acebolado, onion rings, calabresa acebolada, mini coxinhas e batata frita com cheddar e bacon', 50);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('red-lanches', 'Adicionais', false, 60);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Adicionais'), 'Presunto', 4, null, 10),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Adicionais'), 'Ovo', 4, null, 20),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Adicionais'), 'Frango', 4, null, 30),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Adicionais'), 'Calabresa', 4, null, 40),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Adicionais'), 'Salada', 4, null, 50),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Adicionais'), 'Queijo', 5, null, 60),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Adicionais'), 'Bacon', 5, null, 70),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Adicionais'), 'Cheddar Scala', 5, null, 80),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Adicionais'), 'Catupiry original', 5, null, 90),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Adicionais'), 'Hambúrguer caseiro 70g', 6, null, 100),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Adicionais'), 'Hambúrguer caseiro 150g', 8, null, 110),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Adicionais'), '5 sachês Heinz', 1.5, null, 120),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Adicionais'), 'Molho de alho (no lanche)', 1, null, 130),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Adicionais'), 'Molhinho caseiro', 1, null, 140);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('red-lanches', 'Refrigerantes', false, 70);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Refrigerantes'), 'Mini 200ml (guaraná mantiqueira)', 3, null, 10),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Refrigerantes'), 'Mini 200ml', 4, 'Coca-Cola, Coca-Cola Zero, Fanta Laranja, Fanta Guaraná ou Guaraná Antártica', 20),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Refrigerantes'), 'Mini lata 220ml', 4.5, 'Coca-Cola, Coca-Cola Zero, Coca-Cola Café, Fanta Laranja, Fanta Uva, Sprite ou Guaraná', 30),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Refrigerantes'), 'KS 290ml (consumo no local)', 5.5, 'Coca-Cola, Coca-Cola Zero, Fanta Laranja ou Sprite', 40),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Refrigerantes'), 'Lata 350ml', 6, 'Coca-Cola, Coca-Cola Zero, Fanta Laranja, Fanta Maracujá, Fanta Uva, Sprite, Kuat, Schweppes Tônica, Itubaína, Guaraná Antártica ou Guaraná Antártica Zero', 50),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Refrigerantes'), 'Sprite Fresh 500ml', 6, null, 60),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Refrigerantes'), '600ml', 8, 'Coca-Cola, Coca-Cola Zero, Fanta Laranja, Fanta Uva, Sprite ou Kuat', 70),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Refrigerantes'), '1L (consumo no local)', 9, 'Coca-Cola, Coca-Cola Zero, Guaraná Antártica ou Guaraná Antártica Zero', 80),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Refrigerantes'), '1L (garrafa descartável)', 9, 'Coca-Cola, Coca-Cola Zero, Guaraná Antártica ou Guaraná Antártica Zero', 90),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Refrigerantes'), '2L (Fanta / Kuat / Sprite)', 13, 'Fanta Laranja, Fanta Uva, Kuat ou Sprite', 100),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Refrigerantes'), '2L (Coca / Guaraná)', 15, 'Coca-Cola, Coca-Cola Zero, Guaraná Antártica ou Guaraná Antártica Zero', 110);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('red-lanches', 'Sucos', false, 80);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Sucos'), 'Kapo 200ml', 3, 'Uva ou morango', 10),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Sucos'), 'Del Valle 450ml', 5, 'Uva e laranja', 20),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Sucos'), 'Del Valle lata 290ml', 6, 'Uva, manga, maracujá, pêssego ou goiaba', 30),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Sucos'), 'Del Valle 1L', 8, 'Uva e laranja', 40),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Sucos'), 'Del Valle 1,5L', 10, 'Laranja', 50),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Sucos'), 'Natural 500ml', 12, 'Morango, abacaxi, abacaxi com hortelã ou maracujá', 60),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Sucos'), 'Natural laranja 300ml', 12, null, 70),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Sucos'), 'Natural laranja 500ml', 15, null, 80),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Sucos'), 'Limonada suíça', 15, null, 90),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Sucos'), 'Embalagem de suco para viagem', 1, null, 100);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('red-lanches', 'Bebidas', false, 90);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Bebidas'), 'Água mineral', 3, null, 10),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Bebidas'), 'Água mineral com gás', 4, null, 20),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Bebidas'), 'Água de coco 200ml', 4, null, 30),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Bebidas'), 'Toddynho 200ml', 4, null, 40),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Bebidas'), 'H2OH!', 6, null, 50),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Bebidas'), 'Isotônico Powerade', 6, 'Consultar sabores', 60),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Bebidas'), 'Smirnoff Ice', 10, null, 70),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Bebidas'), 'Energético Monster (lata)', 15, 'Consultar sabores', 80),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Bebidas'), 'Red Bull (lata)', 15, 'Consultar sabores', 90),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Bebidas'), 'Chopp de vinho Stempel 600ml', 16, null, 100);
insert into categorias (restaurante_slug, nome, meio_a_meio, posicao) values ('red-lanches', 'Cervejas', false, 100);
insert into itens (categoria_id, nome, preco, descricao, posicao) values
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Cervejas'), 'Brahma lata', 6, null, 10),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Cervejas'), 'Skol lata', 6, null, 20),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Cervejas'), 'Budweiser Zero lata', 7, null, 30),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Cervejas'), 'Original latão', 9, null, 40),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Cervejas'), 'Heineken latão', 10, null, 50),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Cervejas'), 'Eisenbahn 600ml', 13, null, 60),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Cervejas'), 'Brahma 600ml', 13, null, 70),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Cervejas'), 'Amstel 600ml', 14, null, 80),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Cervejas'), 'Original 600ml', 14, null, 90),
  ((select id from categorias where restaurante_slug='red-lanches' and nome='Cervejas'), 'Heineken 600ml', 15, null, 100);

