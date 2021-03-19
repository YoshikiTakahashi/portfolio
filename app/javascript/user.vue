<template>
<div id="app">
  <div class="container">
    <div class="form-group search-form">
      <input class="form-control" type="text" v-model="keyword" placeholder="Search client ....">
    </div>

    <div class="row d-flex justify-content-around">
      <div class="col-md-4 scroller infoBox">
        <p>会社名</p>
        <tr class="clientsList" v-for="client in filteredClients" :key="client.id">
          <td class="nameList" v-on:click="showClient(client.company)">{{ client.company }}</td>
        </tr>
      </div>
      <div class="col-md-4 infoBox userBox">
        <div>
          <p>ユーザー情報</p>
          <div id="clientInfo">
            <table>
              <tr>
                <td>会社名：</td>
                <td class="tb">{{ result.company }}</td>
              </tr>
              <tr>
                <td>名前：</td>
                <td class="tb">{{ result.name }}</td>
              </tr>
              <tr>
                <td>電話番号：</td>
                <td class="tb">{{ result.phone }}</td>
              </tr>
              <tr>
                <td>email：</td>
                <td class="tb">{{ result.email }}</td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</template>

<script>
import axios from 'axios'
export default {
  data: function () {
    return {
      bword: '',
      cword: '',
      pword: '',
      aword: '',
      keyword: '',
      result: {},
      clients: []
    }
  },
  created: function() {
    this.getData();
  },
  methods: {
    getData: function(){
      fetch('/clients/getclient')
      .then(dataWrappedByPromise => dataWrappedByPromise.json())
      .then(data => {
        this.clients = data;
      })
    },
    createClient: function() {
      if (!this.bword) return;

      for(var i in this.clients) {
        var client = this.clients[i];
        if (client.company.toLowerCase() == this.bword.toLowerCase()) {
          console.log("can not save client")
          return;
        }
      }

      axios.post('/clients/create', { client: {company: this.bword, name: this.cword, phone: this.pword, email: this.aword } }).then((response) => {
        var luser = {company: this.bword, name: this.cword, phone: this.pword, email: this.aword };
        this.clients.unshift(luser);
        this.cword = '';
      })
    },
    showClient: function(d) {
      this.result = [];
      for(var i in this.clients) {
        var client = this.clients[i];
        if(client.company === d) {
          this.result = client;
        }
      }
    }
  },
  computed: {
    filteredClients: function() {
      var clients = [];

      for(var i in this.clients) {
        var client = this.clients[i];

        if (client.company.toLowerCase().indexOf(this.keyword) !== -1) {
          clients.push(client);
        }
      }
      return clients;
    }
  }
}
</script>
