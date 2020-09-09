-- obriši jedan status, te update-aj da u tablici imamo student,drugo,umoriovljenik pod statusom.

delete from status where id=4;
update status set status_člana = 'Drugo' where status_člana='Zaposlena osoba';
update status set status_člana = 'Umirovljenik' where status_člana='Ne zaposlena osoba';

-- u tablici vrsta treninga obrisi vrstu treninga pod id-em 2 i 3
DELETE FROM vrsta_treninga WHERE id=2 or id=3;

-- u tablici cijena prikaži cijene koje su manje od 200 kuna

select cijena from cijena where cijena <200;

-- ispiši ime prezime i čiji je status umirovljenika
SELECT č.ime, č.prezime, s.status_člana FROM članovi as č
inner join status as s on č.status=s.id and s.status_člana='umirovljenik'
;

--  ispiši sve ponude sa ugovornom obvezom 12 mjeseci koje su jeftinije od 200 kuna za studente
select vt.vrsta_treninga, u.trajanje, ci.cijena, s.status_člana  from cjenovnik as c
inner join vrsta_treninga as vt on vt.id=c.vrsta_treninga
inner join ugovor as u on u.id=c.trajanje_ugovora
inner join cijena as ci on ci.id=c.cijena
inner join status as s on s.id=c.status
WHERE s.id=1 and ci.cijena < 200 and c.trajanje_ugovora=1;


--  ispiši aktivne članove teretane, na koje vrste treninga idu,te koliko ih plačaju.
select č.ime, č.prezime, vt.vrsta_treninga,ci.cijena from aktivni_članovi as ač
inner join članovi as č on č.id=ač.user_id
inner join cjenovnik as c on ač.cjenovnik_id = c.id
inner join vrsta_treninga as vt on c.vrsta_treninga=vt.id
inner join cijena as ci on c.cijena=ci.id
ORDER BY č.ime desc
;


-- izmjeni cijenu gurpnog treninga za studente sa 149 na 169
# cijenu sa 149 grupnih podigni na 169
update cijena SET cijena=169 where cijena=149;
