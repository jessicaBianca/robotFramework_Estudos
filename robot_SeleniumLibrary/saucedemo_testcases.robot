*** Settings ***
Documentation     Essa suite testa o site SauceLabs
Resource          saucedemo_resources.robot
Test Setup        Abrir o Navegador 
Test Teardown     Fechar o Navegador


*** Test Cases ***
Caso de Teste 01 - Acessar Saucedemo e logar com usuário standard
    [Documentation]  Esse teste acessa SauceLabs e 
    ...    valida que logou com sucesso com usuario standard
    [Tags]    login
    Acessar o site da SauceLabs
    Logar com o usuário "standard_user" de checkout
    Validar que logou e foi direcionado para a página de produtos

Caso de Teste 02 - Adicionar produto no carrinho e efetuar o checkout
    [Documentation]  Esse teste acessa SauceLabs e 
     ...    valida que logou com sucesso com usuario standard e 
     ...    valida processo de checkout
    [Tags]      login  checkout
    Acessar o site da SauceLabs
    Logar com o usuário "standard_user" de checkout
    Validar que logou e foi direcionado para a página de produtos
    Adicionar produto "Sauce Labs Backpack" no carrinho
    Efetuar processo de checkout 
    Validar que o checkout foi feito com sucesso