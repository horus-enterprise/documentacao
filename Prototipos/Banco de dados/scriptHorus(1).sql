DROP DATABASE Horus;

CREATE DATABASE Horus;

USE  Horus;

-- -----------------------------------------------------
-- Table `Empresa`
-- -----------------------------------------------------
CREATE TABLE Empresa (
  idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
  cnpj CHAR(14) NULL,
  razaoSocial VARCHAR(255),
  email VARCHAR(255),
  cep CHAR(9),
  uf CHAR(2),
  cidade VARCHAR(100),
  bairro VARCHAR(100),
  lougadouro VARCHAR(100),
  numero INT,
  complemento VARCHAR(100)
  );
  
  insert into Empresa (idEmpresa,cnpj,razaoSocial,email,cep,uf,cidade,bairro,lougadouro,numero,complemento) values
  (null,'XXXXXXXX0001XX','Vikstar contact center','vikistar@yahoo.com','08581-220','SP','Itaquera','Sesc','rua feia',123,'predio'),
  (null,'XXXXXXXX0002XX','Call contact center','Call@yahoo.com','08581-220','SP','Capão','jd. Capão','rua feia',123,'predio');
  
  -- -----------------------------------------------------
-- Table `mydb`.`Telefone`
-- -----------------------------------------------------
CREATE TABLE Telefone (
  idtelefone INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  telefone VARCHAR(13) NULL,
  tipo VARCHAR(50),
  fkEmpresa INT NOT NULL,
  FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa)
  );
  
  insert into Telefone (idtelefone,telefone,tipo,fkempresa) values
  (null,'11944444444','whatzapp',1),
  (null,'11944444444','whatzapp',1);

-- -----------------------------------------------------
-- Table `Funcionario`
-- -----------------------------------------------------
CREATE TABLE Funcionario (
  idFuncionario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nomeFuncionario VARCHAR(200) NULL,
  email VARCHAR(200) NULL,
  senha VARCHAR(200) BINARY NULL,
  fkEmpresa INT NOT NULL,
  FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa),
  fkSupervisor INT,
  FOREIGN KEY (fkSupervisor) REFERENCES Funcionario (idFuncionario)
  );
  
  select * from Funcionario;
  
  insert into Funcionario (idFuncionario,nomeFuncionario,email,senha,fkEmpresa,fkSupervisor) values
  (null,'Raoan Camara','rcamara@horus.com','123rcamara',1,null),
  (null,'Vinicius Algusto','valgusto@horus.com','123algusto',1,1);
-- -----------------------------------------------------
-- Table `Maquina`
-- -----------------------------------------------------
CREATE TABLE Maquina (
  idMaquina INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  hostname VARCHAR(30) NULL,
  fkEmpresa INT NOT NULL,
  nomeCpu VARCHAR(100),
  modeloDisco VARCHAR(100),
  FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa)
  );

   select * from Maquina;

   insert into Maquina (idMaquina,hostname,fkEmpresa,nomeCpu,modeloDisco) values
   (null,'HHJHKHJKH',1,'Intel core i5 2400','Sansung HD 500Gb'),
   (null,'HHJHKHJKj',1,'Intel core i5 2400','Sansung HD 500Gb'),
   (null,'HHJHKHJKH',2,'Intel core i5 2400','Sansung HD 500Gb'),
   (null,'HHJHKHJKj',2,'Intel core i5 2400','Sansung HD 500Gb');
-- -----------------------------------------------------
-- Table `Acessos`
-- -----------------------------------------------------  
CREATE TABLE MonitoramentoWeb (
fkFuncionario INT NOT NULL,
FOREIGN KEY (fkFuncionario) REFERENCES Funcionario (idFuncionario),
fkMaquina INT NOT NULL,
FOREIGN KEY (fkMaquina) REFERENCES Maquina (idMaquina),
PRIMARY KEY (fkFuncionario, fkMAquina),
url VARCHAR (200),
dataHora DATETIME DEFAULT CURRENT_TIMESTAMP 
);

select * from MonitoramentoWeb;

insert into MonitoramentoWeb (fkFuncionario, fkMaquina, url,dataHora) values
(1,2,'www.bandtec.com',default),
(2,1,'www.bandtec.com',default);
-- -----------------------------------------------------
-- Table `mydb`.`Monitoramento`
-- -----------------------------------------------------
CREATE TABLE MonitoramentoHardware (
  idOcorrencia INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  fkMaquina INT NOT NULL,
  FOREIGN KEY (fkMaquina) REFERENCES Maquina (idMaquina),
  dataHora DATETIME DEFAULT CURRENT_TIMESTAMP,
  cpuUso FLOAT(3,1),
  cpuTemperatura FLOAT(3,1),
  disco FLOAT(3,1),
  ram FLOAT(3,1),
  uptime LONG
);

select * from MonitoramentoHardware;

insert into MonitoramentoHardware (fkMaquina,cpuUso,cpuTemperatura,disco,ram,uptime) values
(2,30.5,40.0,40.0,70.0,'52100');


select * from Empresa;
select * from Funcionario;
select * from Maquina;
select * from MonitoramentoWeb;
select * from MonitoramentoHardware;

select 
F.idFuncionario,
nomeFuncionario as Nome,
fkEmpresa as Empresa,
fkMaquina as Maquina, 
url as sitesNavegados,
dataHora
from Funcionario F
inner join MonitoramentoWeb W on F.idFuncionario = W.fkFuncionario
;




select 
idFuncionario,
nomeFuncionario as Nome,
W.fkMaquina,
url as acessos,
cpuUso,
cpuTemperatura,
disco,
ram,
uptime,
W.dataHora 
from Funcionario F
inner join MonitoramentoWeb W on W.fkFuncionario = F.idFuncionario
inner join MonitoramentoHardware M on W.fkMaquina = M.fkMaquina
where nomeFuncionario like '%Raoan%' and W.dataHora like '%2021-10-13%'
;

select * from Empresa E
inner join Funcionario F on E.idEmpresa = F.fkEmpresa
inner join Telefone T on T.fkEmpresa = E.idEmpresa
inner join Maquina M on E.idEmpresa = M.fkEmpresa
inner join MonitoramentoWeb W on W.fkMaquina = M.idMAquina
inner join MonitoramentoHardware M1 on M1.fkMaquina = M.idMAquina
inner join MonitoramentoWeb W1 on W1.fkFuncionario = F.idFuncionario;

select senha from Funcionario where email = 'rcamara@horus.com';
 
 
 select count(idFuncionario) from Funcionario where senha = '123rcamara' and email = 'rcamara@horus.com';
