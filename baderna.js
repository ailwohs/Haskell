const { defineConfig } = require("cypress");

module.exports = defineConfig({
  e2e: {
    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
  },


});


fixture `Testes de Login`
    .page `https://the-internet.herokuapp.com/login`;

test('Teste de login positivo', async t => {
    await t
    .typeText('#username', 'tomsmith')
    .typeText('#password', 'SuperSecretPassword!')
    .click('.fa-sign-in')
    .expect(Selector('#flash').innerText).contains('You logged into a secure area!');
});