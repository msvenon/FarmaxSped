SET TERM ^ ;



CREATE OR ALTER TRIGGER ON_CONNECT
ACTIVE ON CONNECT POSITION 0
as
begin
  set bind of bigint to Double Precision;
end
^