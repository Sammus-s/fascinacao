unit uAdm;

interface


type
  TAdm = class
  private
    FID: integer;
    FNome: String;
    Fid_endereco: integer;
    FDataNasc: TDateTime;
    FCpf: string;
    FRG: string;
    FContato: String;
    FEmail: string;
    Fuser: string;
    Fpassw: string;


  public
    property ID: integer read Fid write FID;
    property Nome: string read FNome write Fnome;
    property IDEndereco: integer read Fid_endereco write Fid_endereco;
    property DataNasc: TDateTime read FDataNasc write FDataNasc;
    property Cpf: string read FCpf write FCpf;
    property RG: string read FRG write FRG;
    property Contato: string read FContato write FContato;
    property Email: string read Femail write Femail;
    property User: string read Fuser write Fuser;
    property Passw: string read Fpassw write Fpassw;
  end;

implementation


end.
