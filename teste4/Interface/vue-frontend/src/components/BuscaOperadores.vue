<template>
  <div class="BuscaOperadores">
    <h1> Busca Textual sobre Operadoras</h1>
    <input v-model="texto_busca" @keyup.enter="buscar" placeholder="Digite o que deseja buscar"/>
    <button @click="buscar">Buscar</button>
    <ul>
      <li v-for="operadora in operadoras" :key="operadora.id">
        {{ operadora.Razao_Social }} - {{ operadora.Cidade }}
      </li>
    </ul>
  </div>
</template>

<script>
 import axios from 'axios';
export default {
  name: 'BuscaOperadores',
  /**
   * Iniciando variáveis: texto_busca é o que o clinete quer buscar e operadoras será a lista de dicionário que recebe do GET
   */
  data(){
    return{
      texto_busca: '',
      operadoras: []
    };
  },
  /**
   * Faz a consulta GET usando axios
   */
  methods: {
    async buscar() {
      try {
        const resposta = await axios.get('http://127.0.0.1:8000/busca/', {
          params: {texto_busca: this.texto_busca}
        });
        console.log('Dados Recebidos:', resposta.data);
        this.operadoras = resposta.data;
      } catch (error) {
        console.error('Error na busca:', error);
        this.operadoras = [];
      }
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
