--- TABLOLARIN OLUŞTURULMASI ---
CREATE TABLE birimler (
  birim_id INT PRIMARY KEY,
  birim_ad VARCHAR(25)
);

CREATE TABLE calisanlar (
  calisan_id INT IDENTITY PRIMARY KEY,
  ad VARCHAR(25) NOT NULL,
  soyad VARCHAR(25) NOT NULL,
  maas INT NOT NULL,
  katilmaTarihi DATETIME NOT NULL,
  calisan_birim_id INT,
  FOREIGN KEY (calisan_birim_id) REFERENCES birimler(birim_id),
);

CREATE TABLE ikramiye(
	id INT IDENTITY PRIMARY KEY,
	ikramiye_calisan_id INT,
	ikramiye_ucret INT  NOT NULL,
	ikramiye_tarih DATETIME NOT NULL,
	FOREIGN KEY (ikramiye_calisan_id) REFERENCES calisanlar(calisan_id),
)
CREATE TABLE unvan (
	id INT IDENTITY PRIMARY KEY,
	unvan_calisan_id INT,
	unvan_calisan CHAR(25) NOT NULL,
	unvan_tarih DATETIME NOT NULL,
	FOREIGN KEY (unvan_calisan_id) REFERENCES calisanlar(calisan_id),
)


--- TABLOLARA VERİ EKLENMESİ ---

	---Birimler Tablosu---
INSERT INTO birimler VALUES (1, 'Yazılım');
INSERT INTO birimler VALUES (2, 'Donanım');
INSERT INTO birimler VALUES (3, 'Güvenlik');

SELECT * FROM birimler;

	---Çalışanlar Tablosu---
INSERT INTO calisanlar VALUES ('İsmail', 'İşeri', 100000, '2014-02-20', 1);
INSERT INTO calisanlar VALUES ('Hami', 'Satılmış', 80000, '2014-06-11',1);
INSERT INTO calisanlar VALUES ('Durmuş', 'Şahin', 300000, '2014-02-20',2);
INSERT INTO calisanlar VALUES ('Kağan', 'Yazar', 500000, '2014-02-20',3);
INSERT INTO calisanlar VALUES ('Meryem', 'Soysaldı', 500000, '2014-06-11',3);
INSERT INTO calisanlar VALUES ('Duygu', 'Akşehir', 200000, '2014-06-11',2);
INSERT INTO calisanlar VALUES ('Kübra', 'Seyhan', 75000, '2014-01-20',1);
INSERT INTO calisanlar VALUES ('Gülcan', 'Yıldız', 90000, '2014-04-11',3);

SELECT * FROM calisanlar;


	---İkramiye Tablosu---
INSERT INTO ikramiye VALUES (1,5000,'2016-02-20');
INSERT INTO ikramiye VALUES (2,3000,'2016-06-11');
INSERT INTO ikramiye VALUES (3,4000,'2016-02-20');
INSERT INTO ikramiye VALUES (1,4500,'2016-02-20');
INSERT INTO ikramiye VALUES (2,3500,'2016-06-11');

SELECT * FROM ikramiye;


	---Unvan Tablosu---
INSERT INTO unvan VALUES (1,'Yönetici','2016-02-20');
INSERT INTO unvan VALUES (2,'Personel','2016-06-11');
INSERT INTO unvan VALUES (8,'Personel','2016-06-11');
INSERT INTO unvan VALUES (5,'Müdür','2016-06-11');
INSERT INTO unvan VALUES (4,'Yönetici Yardımcısı','2016-06-11');
INSERT INTO unvan VALUES (7,'Personel','2016-06-11');
INSERT INTO unvan VALUES (6,'Takım Lideri','2016-06-11');
INSERT INTO unvan VALUES (3,'Takım Lideri','2016-06-11');

SELECT * FROM unvan;

--- SORGULAR ---

	---SORU 3---
SELECT ad, soyad, maas 
FROM calisanlar INNER JOIN birimler br
ON calisanlar.calisan_birim_id = br.birim_id
WHERE br.birim_ad = 'Yazılım' or br.birim_ad ='Donanım';

	---SORU 4---
SELECT ad, soyad, maas FROM calisanlar 
WHERE maas= (SELECT MAX(maas) FROM calisanlar);

	---SORU 5---
SELECT b.birim_ad,  COUNT(*) AS calisan_sayisi FROM calisanlar c 
INNER JOIN birimler b ON c.calisan_birim_id=b.birim_id 
GROUP BY birim_ad, birim_id

	---SORU 6---
SELECT u.unvan_calisan, COUNT(*) AS calisan_sayisi 
FROM calisanlar c 
INNER JOIN unvan u ON c.calisan_id = u.unvan_calisan_id 
GROUP BY u.unvan_calisan;

	---SORU 7---
SELECT ad, soyad, maas FROM calisanlar
WHERE maas > 50000 and maas < 100000;

	---SORU 8---
SELECT ad, soyad, b.birim_ad, u.unvan_calisan, SUM(i.ikramiye_ucret) as ucret
FROM calisanlar c
INNER JOIN ikramiye i ON i.ikramiye_calisan_id = c.calisan_id
INNER JOIN unvan u ON u.unvan_calisan_id = c.calisan_id
INNER JOIN birimler b ON b.birim_id = c.calisan_id
GROUP BY ad, soyad, b.birim_ad, u.unvan_calisan;

	---SORU 9---
SELECT ad, soyad, u.unvan_calisan FROM calisanlar c
INNER JOIN unvan u ON c.calisan_id = u.unvan_calisan_id
WHERE unvan_calisan = 'Yönetici' or unvan_calisan = 'Müdür';

	---SORU 10---
SELECT birim_ad, MAX(maas) as maas FROM calisanlar c
INNER JOIN birimler b ON b.birim_id = c.calisan_birim_id
GROUP BY b.birim_ad

