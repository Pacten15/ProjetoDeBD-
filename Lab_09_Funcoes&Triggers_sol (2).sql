-- Grupo 1
-- a)

create or replace function total_balance (c varchar(255))
	returns decimal (20,2) AS $$
	declare credit decimal (20,2);
	declare  debt decimal (20,2);
 begin
    select sum(balance) into credit
    from account natural join depositor
    where customer_name = c;

    if credit is null then credit:=0; end if;

    select sum(amount) into debt
    from loan natural join borrower
    where customer_name = c;

    if debt is null then debt:=0; end if;

    return credit - debt;
End;
$$ Language plpgsql;


select total_balance ('Cook');

-- se quisessemos fazer como um Procedure


create or replace function saldo_absoluto_proc (IN c varchar(255), OUT saldo_total decimal (20,2)) AS $$
    declare saldo decimal default 0;
    declare divida decimal default 0;
begin

    select sum(balance) into saldo from account natural join depositor where customer_name = c;
    if saldo is null then saldo := 0; end if;

    select sum(amount) into divida from borrower natural join loan where customer_name = c;
    if divida is null then divida := 0; end if;

    saldo_total := saldo - divida;
End;
$$ Language plpgsql;


select saldo_absoluto_proc ('Cook');





-- b) a diferença entre o saldo médio das contas em duas agências dadas

create or replace function avg_balance (b1 varchar(255), b2 varchar(255))
	returns decimal (20,2) AS $$
	declare balance_b1 decimal (20,2);
	declare balance_b2 decimal (20,2);

begin
    select avg(balance) into balance_b1
    from account
    where branch_name = b1;

    if balance_b1 is null then  balance_b1:=0; end if;

    select avg(balance) into balance_b2
    from account
    where branch_name = b2;

	  if balance_b2 is null then  balance_b2:=0; end if;

    return balance_b1 - balance_b2;
End;
$$ Language plpgsql;

select avg_balance ('Perryridge', 'Downtown');


-- c) qual é a agência cujo saldo médio das contas é o maior entre todas as agências

select b1.branch_name
from branch b1, branch b2
group by b1.branch_name
having min(avg_balance(b1.branch_name, b2.branch_name)) = 0;


-- check values using
select b1.branch_name, min(avg_balance(b1.branch_name, b2.branch_name))
from branch b1, branch b2
group by b1.branch_name


-- 1.(d)


\d depositor

alter table depositor drop constraint fk_depositor_account;

alter table depositor add foreign key(account_number)
  references account(account_number) on delete cascade;

alter table depositor add constraint fk_depositor_account foreign key(account_number)
  references account(account_number) on delete cascade;

insert into account values ('B-100','Downtown', 100);
insert into depositor values ('Cook','B-100');
delete from account where account_number = 'B-100';
-- ---------------------------------------------------------------------------

-- 1.(e)

\d borrower;

alter table borrower drop constraint fk_borrower_loan;

alter table borrower add foreign key(loan_number) references loan(loan_number) on delete cascade;


-- ---------------------------------------------------------------------------



--  Grupo 2

drop trigger if exists update_loan_trigger on loan;

create or replace function update_loan () returns trigger as $$
begin

    if new.amount <= 0 then
      update branch b
      set assets = assets - new.amount
      where b.branch_name = new.branch_name;
      delete from borrower where loan_number = new.loan_number;
      delete from loan where loan_number = new.loan_number;

    end if;

    return new;

End;
$$ Language plpgsql;

create trigger update_loan_trigger after update on loan
for each row execute procedure update_loan();

delete from borrower where loan_number ='1111';
delete from loan where loan_number ='1111';

insert into loan values('1111', 'Central', 100);
insert into borrower values('Adams', '1111');

select * from loan;
select * from borrower;

update loan
set amount = amount - 101
where loan_number = '1111';
select * from branch;



--  b)

drop trigger if exists verifica_conta_trigger on borrower;

create or replace function  verifica_conta() returns trigger as $$
begin
  if new.customer_name not in (select customer_name from depositor) then
      raise exception 'O Cliente % NÃO tem conta neste banco.',new.customer_name;
  end if;
  return new;

End;
$$ Language plpgsql;



create trigger verifica_conta_trigger before insert on borrower
for each row execute procedure verifica_conta();



delete from borrower where loan_number = '1111';
delete from customer where customer_name= 'Alberto';
delete from loan where loan_number= '1111';

insert into customer values('Alberto','Rua 1','Lisboa');
insert into loan values('1111', 'Central', 100);
insert into borrower values('Alberto', '1111');


select * from customer;
select * from borrower;
