unit uEmpresa;

interface

<<<<<<< Updated upstream
implementation

=======
uses SysUtils, Generics.Collections, uOrdem, uPessoa, uProduto;

type
  TEmpresa = class
  private
    FNome     : string;
    FSaldo    : currency;


  public
    property Nome     : string          read FNome     write FNome;
    property Saldo    : currency        read FSaldo    write FSaldo;


  //CONSTRUCTOR
  constructor Create;

  //DESTRUCTOR
  destructor Destroy;override;

  //PROCEDIMENTOS


  //FUNCTIONS
  function Tostring(): string;
  end;

implementation

{ TEmpresa }

constructor TEmpresa.Create();
begin
  FNome := 'Compra Venda';
  FSaldo := 0.00;

end;

destructor TEmpresa.Destroy();
begin
  inherited
end;



function TEmpresa.ToString : string;
begin
  Result := '-------------------------------Empresa----------------------------'+sLineBreak+
            'Nome : '+FNome                                                     +sLineBreak+
            'Saldo inicial: '+FormatCurr('#.#00,00',FSaldo)                     +sLineBreak+
            '------------------------------------------------------------------'+sLineBreak;
end;
>>>>>>> Stashed changes
end.
