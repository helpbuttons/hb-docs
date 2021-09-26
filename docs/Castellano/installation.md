# Instalaciones de Help Buttons

## En GNU/Linux

Referencias seguidas:

Para realizar la instalación de Node en Debian o derivados (Ubuntu) existen los siguientes requisitos:

- PostgreSQL para PostGIS
- Docker
- Nodejs
- Yarn o NPM

En el front:
- npm install
- npm run dev

(http://localhost:3000/)

En el back:
- npm install
- npm start

(http://localhost:3001/)


### Instalación y configuración de PostgreSQL

Se instalan los paquetes necesarios para la instalación de PostgreSQL:
```bash
sudo apt install postgresql postgresql-contrib libpq-dev -y
```
Se levantan el servicio con:
```
systemctl start postgresql
systemctl enable postgresql
```
Se abre una consola en PostgreSQL para modificar la contraseña del usuario `postgres`:
```bash
sudo -i -u postgres psql
```

Se introduce el siguiente mandato para cambiar la contraseña:
```
\password postgres
```

A continuación, se crea un nuevo usuario de PostgreSQL llamado `rails_dev` con privilegios para crear una base de datos `with createdb` y una contraseña `aq1234567890` (se recomienda cambiarla por otra más robusta, a poder ser generada con KeePassXC o BitWarden)
```sql
create role hb_dev with createdb login password 'aq1234567890';
```

Se muestran los usuarios de PostgreSQL con:
```
\du
```

Escribe `exit` para salir de la consola de PostgreSQL.

Volvemos a ejecutar `bundle install` para continuar con la instalación.
```bash
bundle install
```

Termina la ejecución sin errores. El siguiente paso será instalar Nodejs y Yarn.

### Instalación de Nodejs y Yarn

Primero instalamos las herramientas de desarrollo para compilar C.
```bash
sudo apt install gcc g++ make
```

Se instalan los repositorios de Nodejs 14 a través del siguiente comando:
```bash
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
```

Se instala nodejs mediante la siguiente orden:
```bash
sudo apt-get install -y nodejs
```

Se comprueba la instalación de nodejs y npm con:
```bash
node -v
npm -v
```

Se añade la firma y los repositorios de yarn mediante:
```bash
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
```
Instalamos yarn:
```
sudo apt update && sudo apt install yarn
```

### Instalación de la versión de Node del proyecto. Problemas comunes.

## Ejecución del proyecto

### hb-back


Guarda los cambios y sal del editor.

Por último, levanta el servidor en local y accede a la dirección [`http://localhost:3000/`](http://localhost:3000/).
```bash
rails s
```

### Hb-front

Instalamos ember glabalmente:
```bash
npm install -g ember-cli
```

En caso de obtener un error relaciondo con permisos de acceso `npm ERR! Error: EACCES,`, cambiamos el propietario de la carpeta `node_modules` de root al usuario actual para poder acceder al directorio:
```
sudo chown -R $USER /usr/lib/node_modules
```

Instalamos las depencias del front:
```bash
npm install
```

Se sirve el frontend y se accede desde el navegador a la url [http://localhost:4200/](http://localhost:4200/):
```
ember s
```

## Posibles errores durante la instalación

### Command not found
