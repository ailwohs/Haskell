package apresentacao;
import dados.Pessoa;

	public Pessoa criaPessoa() {
		Pessoa p = new Pessoa();
		String input;
		System.out.print("Informe o nome: ");
		input = scan.nextLine();
		if ( input.equals("-1") )
			return null;
		p.setNome(input);
		System.out.print("Informe a idade: ");
		input = scan.nextLine();
		if ( input.equals("-1") )
			return null;
		p.setIdade(Integer.valueOf(input));
		System.out.print("Informe a cidade: ");
		input = scan.nextLine();
		if ( input.equals("-1") )
			return null;
		p.setCidade(input);
		System.out.print("Informe o cpf: ");
		input = scan.nextLine();
		if ( input.equals("-1") )
			return null;
		p.setCpf(input);
		return p;
	}
	
	public void mostraPessoas() {
		System.out.println("Crianças: ");
		for(Pessoa p : pessoas.getCriancas())
			System.out.println(p);
		System.out.println("Jovens: ");
		for(Pessoa p : pessoas.getJovens())
			System.out.println(p);
		System.out.println("Adultos: ");
		for(Pessoa p : pessoas.getAdultos())
			System.out.println(p);
		System.out.println("Idosos: ");
		for(Pessoa p : pessoas.getIdosos())
			System.out.println(p);
	}
	
}