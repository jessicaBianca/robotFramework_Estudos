*** Settings ***
Library    SeleniumLibrary
Library    String
*** Variables ***
#Consideradas globais !
#Se eu fizer uso do que vem do test é melhor, pq se for alterado, ele já reconhece no step, não preciso editar na variável (Dinâmico)
${URL}   https://www.saucedemo.com/ 
${TXT_LOGIN_STANDARD}    standard_user
${TXT_PW_STANDARD}       secret_sauce
${LOC_TITULO_PAGINA}     //div[@class='login_logo']
${LOC_INPUT_LOGIN}       //input[@placeholder="Username"]
${LOC_INPUT_PW}          //input[@placeholder="Password"]
${LOC_BTN_LOGAR}         //input[@id="login-button"]       
${LOC_ITEM_BIKE_LIGHT}   //div[@data-test='inventory-item-name' and text()='Sauce Labs Bike Light']
${LOC_ITEMS_INVENTORY}    //div[@class="inventory_item_description"]//div[@data-test="inventory-item-name"]
${LOC_BTN_REMOVE_HABILITADO_ITEM_BACKPACK}    //button[@name="remove-sauce-labs-backpack"]
${LOC_BTN_CARRINHO}    //a[@data-test="shopping-cart-link"]
${LOC_ITEM_NO_CARRINHO}    //div[@class="cart_item"]
${LOC_BTN_CHECKOUT}        //button[@id="checkout"]
${LOC_INPUT_FIRSTNAME}    //input[@id="first-name"]
${LOC_INPUT_LASTNAME}     //input[@id="last-name"]
${LOC_INPUT_POSTALCODE}     //input[@id="postal-code"]
${LOC_BTN_CONTINUE}        //input[@id="continue"]
${LOC_BTN_FINISH}          //button[@id="finish"]
${LOC_LABEL_ORDER_FINISH}    //div[@data-test="complete-text"]

*** Keywords ***
Abrir o Navegador
    Open Browser    browser=edge
    Maximize Browser Window    
Fechar o Navegador
    Close Browser
    
Acessar o site da SauceLabs
    Go To    url=${URL}
    Wait Until Element Is Visible    locator=${LOC_TITULO_PAGINA}    timeout=5s

Logar com o usuário "${TXT_LOGIN_STANDARD_CHECKOUT}" de checkout
    Input Text    locator=${LOC_INPUT_LOGIN}    text=${TXT_LOGIN_STANDARD_CHECKOUT}
    Input Password    locator=${LOC_INPUT_PW}   password=${TXT_PW_STANDARD}
    Click Button    locator=${LOC_BTN_LOGAR}
    
Validar que logou e foi direcionado para a página de produtos
    Wait Until Element Is Visible    locator=${LOC_ITEM_BIKE_LIGHT}    timeout=5s

Adicionar produto "${TXT_PRODUTO}" no carrinho
    Wait Until Element Is Visible    locator=${LOC_ITEMS_INVENTORY}    timeout=5
    Adicionar item no carrinho ${TXT_PRODUTO}
    Wait Until Element Is Visible    locator=${LOC_BTN_REMOVE_HABILITADO_ITEM_BACKPACK}    timeout=5

Efetuar processo de checkout 
    Click Element    locator=${LOC_BTN_CARRINHO} 
    Wait Until Element Is Visible    locator=${LOC_ITEM_NO_CARRINHO}
    Click Button    locator=${LOC_BTN_CHECKOUT} 
    Input Text    locator=${LOC_INPUT_FIRSTNAME}     text=JESSICA
    Input Text    locator=${LOC_INPUT_LASTNAME}     text=OLIVEIRA
    Input Text    locator=${LOC_INPUT_POSTALCODE}     text=07251000
    Click Button    locator=${LOC_BTN_CONTINUE}
    Click Button    locator=${LOC_BTN_FINISH}
 
Validar que o checkout foi feito com sucesso
    Wait Until Element Is Visible    locator=${LOC_LABEL_ORDER_FINISH}
    Element Text Should Be    locator=${LOC_LABEL_ORDER_FINISH}    expected=Your order has been dispatched, and will arrive just as fast as the pony can get there!

#Adiciono produto com base no nome - xpath dinâmico
Adicionar item no carrinho ${TXT_NOME_PRODUTO}
    ${XPATH_DINAMIC}=    Set Variable     //div[@data-test="inventory-item-name" and text()='${TXT_NOME_PRODUTO}']//ancestor::div[@data-test="inventory-item-description"]//button
    Wait Until Element Is Visible    locator=${XPATH_DINAMIC}    timeout=5s
    Click Button    locator=${XPATH_DINAMIC}