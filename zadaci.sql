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
-- cijenu sa 149 povecaj na 169
update cijena SET cijena=169 where cijena=149;

-- proslo je godinu dana.. svim clanovima povecaj godine za 1
update članovi set godine=godine+1;

-- svim članovima koji su stariji od 67 godina stavi status umirovljenik(3)
update članovi set status=3 where godine>67;

-- izlistaj imena svih clanova kojima ime počinje slovom M ili zavrsava slovom N
SELECT UPPER(ime) as ime from članovi where LEFT(ime,1)='M' or RIGHT(ime,1)='N';
-- izlistaj ukupni iznos koji placa clan Marin.
select SUM(c.cijena) as ukupan_iznos from aktivni_članovi ač
inner join cjenovnik cj on ač.cjenovnik_id = cj.id
inner join cijena c on c.id=cj.id
where user_id = 1;

-- clan Stjepan Stipić se ispisao iz teretane

DELETE članovi FROM članovi where ime='Stjepan' and prezime='Stipić';

-- obrisi ponude iz cjenovnika cija je cijena 179; U ovom slucaju nemam niti jedan use na taj trenutni cjenovnik da nebi smrdalo tablicu.. odrađeno ovako radi vjezbe
delete cjenovnik from cjenovnik inner join cijena ci on cjenovnik.cijena = ci.id where ci.cijena=179;


-- trigger u clanovima gdje na svaki insert sva slova prezimena stavlja kao mala slova
CREATE TRIGGER malaslova BEFORE INSERT ON članovi FOR EACH ROW
    SET NEW.prezime = LOWER(NEW.prezime);

-- clan Luka Šarac nije produzio ugovor(ALI JE OSTAO ČLAN TERETANE)
delete ač from aktivni_članovi ač inner join članovi č on ač.user_id=č.id where č.ime = 'Luka';

-- clan Filip Paunović se ispisao iz teretane
delete članovi from članovi where ime='Filip' and prezime='Paunović';

-- izlistaj sve clanove koji su stariji od 25 godina
select * from članovi where godine>25;

-- izlistaj ponudu za umirovljenike

select vt.vrsta_treninga, u.trajanje, ci.cijena, s.status_člana  from cjenovnik as c
                                                                          inner join vrsta_treninga as vt on vt.id=c.vrsta_treninga
                                                                          inner join ugovor as u on u.id=c.trajanje_ugovora
                                                                          inner join cijena as ci on ci.id=c.cijena
                                                                          inner join status as s on s.id=c.status
WHERE s.status_člana='Umirovljenik';

-- izlistaj sve vrste ugovora
select trajanje from ugovor;
-- izlistaj prosjecnu dob članova(okrugli broj, bez  nepotrebih decimala)
select ROUND(AVG(godine)) as prosjecna_dob from članovi;
 -- SELECT=10,DELETE=6,UPDATE=5,BUILT-IN-F=5,


