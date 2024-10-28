# Sprint 2  
## Bases de dades: MySQL i MongoDB 
Activitats per practicar amb MySQL i MongoDB.

**Entrega activitats MySQL**  
— `mysql-estructura`  
— `mysql-queries`  

**Entrega activitats MongoDB**  
— `mongodb-estructura/`  
Conté tant carpeta `optica-json-files` amb el `json` dividit per col·leccions, com l'arxiu complert `optica-estructura.json`.  

>[!TIP]
> També hi he afegit l'script `bulkImport.sh`. En cas que vulguis fer l'importació de la base de dades amb `mongoimport` potser t'interessa.  
> [Més avall](#-BulkImport) t'explico com es pot fer servir. 👇  

— `mysql-queries`  

### 🚛 BulkImport
Després de fer `git clone` del repositori o de la carpeta de `mongodb-estructures`:  
1. `cd optica-json-files`  
2. `sh bulkImport.sh`  

### ⚠️ Possibles errors
**L'arxiu no s'executa**  
Assegura't que té permisos d'execució (pots veure-ho amb `ls -la`). Assigna'ls-hi amb `chmod +x bulkImport.sh`.  

**Problemes amb MongoDB**  
L'script fa servir `mongoimport`.  
- Assegura't que tens instal·lat `mongod` i `mongosh` (pots comprovar-ho amb `mongod --version` i `mongosh --version`).  
- Comprova que tens activat el servei de `mongodb`.  

**El problema persiste**  
Posa't en contacte amb l'admin 🧑‍🚒    
o fes l'import manualment.
