entity lab_one is
  port (
  SW1 : in bit;
  LED1 : out bit
  );
end entity;

architecture arch of lab_one is
begin
  LED1 <= SW1;
end architecture;
