CREATE DATABASE IF NOT EXISTS dbdemo;

SHOW TABLES;

INSERT INTO `brasil`.`ABEV3.SA` (`DATE`, `OPEN`, `CLOSE`, `ADJCLOSE`, `HIGH`, `LOW`, `VOLUME`) VALUES ('1', '0', '0', '0', '0', '0', '0');

CREATE TABLE `EMBR3.SA` (
  `DATE` int(11) NOT NULL,
  `OPEN` double DEFAULT NULL,
  `CLOSE` double DEFAULT NULL,
  `ADJCLOSE` double DEFAULT NULL,
  `HIGH` double DEFAULT NULL,
  `LOW` double DEFAULT NULL,
  `VOLUME` int(11) DEFAULT NULL,
  PRIMARY KEY (`DATE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `EMBR3.SA` (
  `ATIVO` int(11) DEFAULT NULL,
  `PASSIVO` int(11) DEFAULT NULL,
  `PL` int(11) DEFAULT NULL,
  `AC` int(11) DEFAULT NULL,
  `ANC` int(11) DEFAULT NULL,
  `PC` int(11) DEFAULT NULL,	
  `PNC` int(11) DEFAULT NULL,
  `LL` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `GRND3.SA` (
  `DATE` int(11) NOT NULL,
  `OPEN` double DEFAULT NULL,
  `CLOSE` double DEFAULT NULL,
  `ADJCLOSE` double DEFAULT NULL,
  `HIGH` double DEFAULT NULL,
  `LOW` double DEFAULT NULL,
  `VOLUME` int(11) DEFAULT NULL,
  PRIMARY KEY (`DATE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE `EMBR3.SA`;

CREATE TABLE `EMBR3.SA` (`DATE` int(11) NOT NULL,`OPEN` double DEFAULT NULL,`CLOSE` double DEFAULT NULL,`ADJCLOSE` double DEFAULT NULL,`HIGH` double DEFAULT NULL,`LOW` double DEFAULT NULL,`VOLUME` int(11) DEFAULT NULL,PRIMARY KEY (`DATE`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE `EMBR3.SA`

CREATE TABLE IF NOT EXISTS testando(x int)

select * from `EMBR3.SA`
SELECT * FROM `VALE5.SA`
SELECT DATE,ADJCLOSE`HGTX3.SA` FROM `VALE5.SA` WHERE DATE BETWEEN 733106 AND 733116

