import requests
from bs4 import BeautifulSoup
import os
from zipfile import ZipFile

url = 'https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos'
folder = os.path.dirname(os.path.realpath(__file__)) # Retorna o diretório do arquivo atual
path = os.path.join(folder, 'anexo') # Cria o caminho para salvar o arquivo

# Conseguir realizar um request na página e acessar todo o conteudo como se fosse o navegador
headers = {'User-Agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36'}

# Fazer a requisição do site 
site = requests.get(url, headers=headers)

# Transferir o conteudo do site para o BeautifulSoup
soup = BeautifulSoup(site.content, 'html.parser')

#print(soup.prettify())

# Encontrar todos os links (tag == a) com a classe 'internal-link'
pdfs = soup.find_all('a', class_='internal-link')

i=1
# Filtrar os links que terminam com '.pdf' e contém 'Anexo' no nome
for pdf in pdfs:
    pdf_url = pdf['href']
    if pdf_url.endswith('.pdf') and 'Anexo' in pdf_url:
        print(f"Baixando: {pdf_url}")

        # Acessando o conteudo do pdf
        pdf_file = requests.get(pdf_url)

        # Enumerando os pdfs
        path_file = f'{path}{i}.pdf'
        i+=1

        # Salvando o pdf
        with open(path_file, 'wb') as f:
            f.write(pdf_file.content)
        print(f"Salvo em: {path_file}")

# Compactar os arquivos
with ZipFile('anexos.zip', 'w') as z:
    for i in range(1, i):
        z.write(f'anexo{i}.pdf')
        print(f'Compactando: anexo{i}.pdf')
    print(f"Compactado em: anexos.zip")

print('Fim do programa')