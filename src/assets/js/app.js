App = {
  web3Provider: null,
  contracts: {},
  


// Connect Dapp to ganache
  initWeb3: async function() {
    // Modern dapp browsers...
    if (window.ethereum) {
      App.web3Provider = window.ethereum;
      try {
        // Request account access
        await window.ethereum.enable();
      } catch (error) {
        // User denied account access...
        console.error("User denied account access")
      }
    }
    // Legacy dapp browsers...
    else if (window.web3) {
      App.web3Provider = window.web3.currentProvider;
    }
    // If no injected web3 instance is detected, fall back to Ganache
    else {
      App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
    }
    web3 = new Web3(App.web3Provider);

    return App.initContract();
  },

  
  initContract: function() {
    $.getJSON('Delottery.json', function (data) {
      var DelotteryArtifact = data;
      App.contracts.Delottery = TruffleContract(DelotteryArtifact);
      App.contracts.Delottery.setProvider(App.web3Provider);      
    });
    return App.bindEvents();
  },

  bindEvents: function() {
   $(document).on('click', '.ubutia-btn', App.buyLotto);
  },
  
  buyLotto: function(event) {
    event.preventDefault();
    
    var lottoNum = Number(document.getElementById("lottoNum").value);
    var price = Number(document.getElementById("price").value);
    
    var DelotteryInstance;

    web3.eth.getAccounts(function (error, accounts) {
      if (error) {
        console.log(error);
      }
      var account = accounts[0];

      App.contracts.Delottery.deployed().then(function (instance) {
        DelotteryInstance = instance;

        return DelotteryInstance.buyLotto(lottoNum,price, { from: account });
      }).then(function (result) {
        return App.getBuyCount();
      }).catch(function (err) {
        console.log(err.message);
      });
    var numBuyCount = DelotteryInstance.getBuyCount(lottoNum)
    var output = "คำสั่งซื้อหมายเลข "+lottoNum+" จำนวน "+numBuyCount+" บาท สำเร็จแล้ว";
            document.getElementById("result").style = "color:green";
            document.getElementById("result").innerHTML = output;
    });


  
  },

  
   
  
};

$(function() {
  $(window).load(function() {
    App.initWeb3();
  });
});

