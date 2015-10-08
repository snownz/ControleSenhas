package Controle;

import java.util.ArrayList;
import java.util.Iterator;

public class GerenciaLogin implements java.io.Serializable
{
	private ArrayList listaLogin = new ArrayList();
	private static GerenciaLogin gl = new GerenciaLogin();
	
	public GerenciaLogin()
	{
		Login c0 = new Login();
		c0.setEstado(false);c0.setGerente(false);c0.setNome("cliente0");c0.setSenha("1");
		Login c1 = new Login();
		c1.setEstado(false);c1.setGerente(false);c1.setNome("cliente1");c1.setSenha("1");
		Login c2 = new Login();
		c2.setEstado(false);c2.setGerente(false);c2.setNome("cliente2");c2.setSenha("1");
		Login c3 = new Login();
		c3.setEstado(false);c3.setGerente(false);c3.setNome("cliente3");c3.setSenha("1");
		Login c4 = new Login();
		c4.setEstado(false);c4.setGerente(false);c4.setNome("cliente4");c4.setSenha("1");
		Login c5 = new Login();
		c5.setEstado(false);c5.setGerente(false);c5.setNome("cliente5");c5.setSenha("1");
		Login c6 = new Login();
		c6.setEstado(false);c6.setGerente(false);c6.setNome("cliente6");c6.setSenha("1");
		Login c7 = new Login();
		c7.setEstado(false);c7.setGerente(false);c7.setNome("cliente7");c7.setSenha("1");
		Login c8 = new Login();
		c8.setEstado(false);c8.setGerente(false);c8.setNome("cliente8");c8.setSenha("1");
		Login c9 = new Login();
		c9.setEstado(false);c9.setGerente(false);c9.setNome("cliente9");c9.setSenha("1");
		
		Login g1 = new Login();
		g1.setEstado(false);g1.setGerente(true);g1.setNome("gerente1");g1.setSenha("1");
		Login g2 = new Login();
		g2.setEstado(false);g2.setGerente(true);g2.setNome("gerente2");g2.setSenha("1");
		Login g3 = new Login();
		g3.setEstado(false);g3.setGerente(true);g3.setNome("gerente3");g3.setSenha("1");
		
		addLogin(c0);
		addLogin(c1);
		addLogin(c2);
		addLogin(c3);
		addLogin(c4);
		addLogin(c5);
		addLogin(c6);
		addLogin(c7);
		addLogin(c8);
		addLogin(c9);
		addLogin(g1);
		addLogin(g2);
		addLogin(g3);
	}
	
	public static GerenciaLogin getInstancia()
	{
		return GerenciaLogin.gl;
	}
	
	public void alterarEstado(Login l, boolean estado)
	{
		Iterator it = this.listaLogin.iterator();
		int i  = 0;
		while(it.hasNext())
		{			
			if(l.equals(it.next()))
			{
				break;
			}
			i++;
		}
		Login laux = (Login)this.listaLogin.get(i);
		this.listaLogin.remove(i);
		laux.setEstado(estado);
		this.addLogin(laux);
	}
	
	public void addLogin(Login l)
	{
		if(this.existeLogin(l) == null)
			this.listaLogin.add(l);
	}
	
	public Login existeLogin(Login l)
	{
		Iterator it = this.listaLogin.iterator();
		while(it.hasNext())
		{
			Login laux = (Login)it.next();
			if(l.equals(laux) && !laux.getEstado())
				return laux;
		}
		return null;			
	}
	
	public ArrayList getListaLogin()
	{
		return this.listaLogin;
	}
}
