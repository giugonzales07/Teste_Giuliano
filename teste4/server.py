from fastapi import FastAPI
import pandas as pd
from fastapi.middleware.cors import CORSMiddleware 

app = FastAPI()

# Permitindo acesso do frontend (Vue.js) no backend (FastAPI)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:8080"],  # Permite o frontend
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

df_operadoras = pd.read_csv('Relatorio_cadop.csv', sep=';')
df_operadoras = df_operadoras.fillna('') # Tradando valores NaN

# Faz a busca em todos os campos textuais do CSV
@app.get("/busca/")
def busca_textual(texto_busca):
    registros = []
    for _, op in df_operadoras.iterrows():
        if (texto_busca.lower() in str(op['Razao_Social']).lower() or 
            texto_busca.lower() in str(op['Nome_Fantasia']).lower() or 
            texto_busca.lower() in str(op['Modalidade']).lower() or 
            texto_busca.lower() in str(op['Logradouro']).lower() or 
            texto_busca.lower() in str(op['Complemento']).lower() or
            texto_busca.lower() in str(op['Bairro']).lower() or 
            texto_busca.lower() in str(op['Cidade']).lower() or 
            texto_busca.lower() in str(op['UF']).lower() or 
            texto_busca.lower() in str(op['Endereco_eletronico']).lower() or 
            texto_busca.lower() in str(op['Representante']).lower() or 
            texto_busca.lower() in str(op['Cargo_Representante']).lower()):
            registros.append(op.to_dict())
    return registros

# Campos de texto
# Razao_Social;
# Nome_Fantasia;
# Modalidade;
# Logradouro;
# Complemento;
# Bairro;
# Cidade;
# UF;
# Endereco_eletronico;
# Representante;
# Cargo_Representante;