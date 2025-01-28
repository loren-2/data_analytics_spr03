-- Nivel 3
-- Ejercicio 1

-- Modifico campos id, iban, expiring_date de la tabla credit_card. 
alter table credit_card
modify id varchar(20), 
modify iban varchar(50),
modify expiring_date varchar(20);

-- Modifico campos pin, cvv de la tabla credit_card. 
alter table credit_card
modify pin varchar(4), 
modify cvv int;

show columns from credit_card;

-- Agrego campo fecha_actual a la tabla credit_card
alter table credit_card add column fecha_actual date;

show columns from credit_card;

-- Elimino el campo website de la tabla company
alter table company drop column website;

show columns from company;

-- Creo la estructura de la tabla users.  
CREATE INDEX idx_user_id ON transaction(user_id);

CREATE TABLE IF NOT EXISTS user (
        id INT PRIMARY KEY,
        name VARCHAR(100),
        surname VARCHAR(100),
        phone VARCHAR(150),
        email VARCHAR(150),
        birth_date VARCHAR(100),
        country VARCHAR(150),
        city VARCHAR(150),
        postal_code VARCHAR(100),
        address VARCHAR(255),
        FOREIGN KEY(id) REFERENCES transaction(user_id)        
    );

-- inserto datos en la tabla user y compruebo que se hayan insertado
select * from user;

-- Renombro la tabla user como data_user
alter table user rename to data_user;

show columns from data_user;

-- Renombro campo email como personal_email en la tabla data_user y compruebo cambios
alter table data_user rename column email to personal_email;

show columns from data_user;

-- Tenemos que eliminar foreign key de la tabla data_user. Es incorrecta. Luego compruebo en su script.
alter table data_user drop foreign key data_user_ibfk_1;

show create table data_user;

-- Modifico la tabla transaction para añadirle el id de la tabla data_user como Foreign Key
alter table transaction
    add constraint fk_user_id
    foreign key (user_id) references data_user(id);
 
/* Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails 
(`transactions`.`#sql-15a0_6e`, CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `data_user` (`id`))
No se puede agregar la clave foránea porque algunos valores en la columna user_id de la tabla transaction no coinciden con ningún valor
en la columna id de la tabla data_user.  
Esto se debe a que hay valores en el campo user_id de la tabla transaction que no coinciden con el id de la tabla data_user.  
En la tabla transaction existe el usuario 9999 que agregamos en un ejercicio anterior. 
En la tabla data_user, que fue creada posteriormente con la data del archivo datos_introducir_user (1).sql, ese usuario no está. 
Hay que agregarlo para poder poner la foreign key a la tabla transaction.*/

-- Falta insertar el usuario 9999 del ejercicio 3, Nivel 1. Inserto el usuario 9999 en data_user y compruebo que esté.
insert into data_user (id)
values (9999);

select * from data_user
 where id = 9999;
 
 -- Modifico la table transaction para añadirle el id de la tabla data_user como Foreign Key
	alter table transaction
    	add constraint fk_user_id
    	foreign key (user_id) references data_user(id);


-- Ejercicio 2
/*Crear una vista llamada "InformeTecnico" que contenga la siguiente información:
ID de la transacción
Nombre del usuario/a
Apellido del usuario/a
IBAN de la tarjeta de crédito usada.
Nombre de la compañía de la transacción realizada.
Muestra los resultados de la vista, ordena los resultados de forma descendente en función de la variable ID de transacción.*/
create view informetecnico as 
select t.id as transaction_id, du.name , du.surname, cc.iban, c.company_name
from transaction as t
join company as c 
on c.id = t.company_id
join data_user as du 
on du.id = t.user_id
join credit_card as cc 
on cc.id = t.credit_card_id
order by t.id desc;








    









 

   










