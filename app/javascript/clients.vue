<template>
<div id="app">
  <div class="container">
    <h3 class="top-heading">連絡先追加</h3>
    <div class="row">
      <div class="col-md-5 col-left-item">
        会社名
      </div>
      <div class="form-group col-md-7">
        <input class="form-control" type="text" v-model="bword" placeholder="Enter company ...">
      </div>
    </div>
    <div class="row">
      <div class="col-md-5 col-left-item">
        お名前
      </div>
      <div class="form-group col-md-7">
        <input class="form-control" type="text" v-model="cword" placeholder="Enter name ...">
      </div>
    </div>
    <div class="row">
      <div class="col-md-5 col-left-item">
        電話番号
      </div>
      <div class="form-group col-md-7">
        <input class="form-control" type="text" v-model="pword" placeholder="Enter phonenumber ...">
      </div>
    </div>
    <div class="row">
      <div class="col-md-5 col-left-item">
        メールアドレス
      </div>
      <div class="form-group col-md-7">
        <input class="form-control" type="text" v-model="aword" placeholder="Enter email ...">
      </div>
    </div>

    <div class="submit-btn" v-on:click.prebent="createClient">
      <i class="fas fa-arrow-alt-circle-down"></i>
    </div>

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
        var luser = {company: this.bword, name: this.cword, phone: this.pword, email: this.aword};
        this.clients.unshift(luser);
        this.bword = '', this.cword = '', this.pword = '', this.aword = '';
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
    },
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
