package Controle;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

import Dados.Gerente;
import Dados.Senha;


public class controleSenhas implements java.io.Serializable
{
	private Senha[] 		FilaSenhasNormal;
	private Senha[] 		FilaSenhasPreferencial;
	
	private int   		PUltimaSenhaNormal;
	private int   		PUltimaSenhaPreferencial;
	
	private int   		PUltimaSenhaNormalChamada;
	private int   		PUltimaSenhaPreferencialChamada;
		
	private ArrayList Gerentes = new ArrayList();
	
	private static controleSenhas cs = new controleSenhas();
	
		
	public static controleSenhas getInstancia()
	{
		return controleSenhas.cs;
	}
	
	public void inserirGerente(Login l)
	{
		Gerente g = new Gerente();
		g.setUsuario(l);
		Gerentes.add(g);
	}
	
	public void removerGerente(String Nome)
	{
		Iterator it = this.Gerentes.iterator();
		int i =0;
		while(it.hasNext())
		{
			Gerente g = (Gerente)it.next();
			if(Nome == g.getUsuario().getNome())
			{
				break;
			}				
			i++;
		}
		this.Gerentes.remove(i);
	}
	
	public void InserirSenhaGerente(String Nome, Senha s)
	{
		Iterator it = this.Gerentes.iterator();
		int i =0;
		Gerente gaux = null;
		while(it.hasNext())
		{
			Gerente g = (Gerente)it.next();
			if(Nome == g.getUsuario().getNome())
			{
				gaux = g;
				gaux.addSenha(s);
				break;
			}				
			i++;
		}
		this.Gerentes.remove(i);
		this.Gerentes.add(gaux);		
	}
	
	public boolean usuarioContemSenha(Login l)
	{
		for(int i = 0; i < PUltimaSenhaPreferencial; i++)
		{
			if(    !FilaSenhasPreferencial[i].getChamada() 
			   &&  !FilaSenhasPreferencial[i].getCancelada()
			   &&   FilaSenhasPreferencial[i].getUsuario().getNome().equals(l.getNome()))
			{				
				return true;
			}
		}
		
		for(int i = 0; i < PUltimaSenhaNormal; i++)
		{
			if(    !FilaSenhasNormal[i].getChamada() 
					   &&  !FilaSenhasNormal[i].getCancelada()
					   &&   FilaSenhasNormal[i].getUsuario().getNome().equals(l.getNome()))
					{				
						return true;
					}
		}
		return false;
	}
	
	public Senha getSenhaUsuario(Login l)
	{
		for(int i = 0; i < PUltimaSenhaPreferencial; i++)		
			if(  FilaSenhasPreferencial[i].getUsuario().equals(l))						
				return FilaSenhasPreferencial[i];	
		
		for(int i = 0; i < PUltimaSenhaNormal; i++)		
			if( FilaSenhasNormal[i].getUsuario().equals(l))							
				return FilaSenhasNormal[i];
			
		
		return null;
	}
	
	public ArrayList getGerentes()
	{
		return this.Gerentes;
	}
	
	public int getUltimaSenhaP()
	{
		return PUltimaSenhaPreferencial;
	}
	
	public Senha chamarProximaSenha(Login g)
	{
		for(int i = 0; i < PUltimaSenhaPreferencial; i++)
		{
			if(!FilaSenhasPreferencial[i].getChamada() && !FilaSenhasPreferencial[i].getCancelada())
			{
				FilaSenhasPreferencial[i].setNomeGerente(g.getNome());
				FilaSenhasPreferencial[i].setChamada(true);
				PUltimaSenhaPreferencialChamada = i;
				return FilaSenhasPreferencial[i];
			}
		}
		
		for(int i = 0; i < PUltimaSenhaNormal; i++)
		{
			if(!FilaSenhasNormal[i].getChamada() && !FilaSenhasNormal[i].getCancelada())
			{
				FilaSenhasNormal[i].setNomeGerente(g.getNome());
				FilaSenhasNormal[i].setChamada(true);
				PUltimaSenhaNormalChamada = i;
				return FilaSenhasNormal[i];
			}
		}
		Senha nullo = new Senha(-1, false, new Date(), new Login());
		return nullo ;
	}

	public void renovarSenha(Senha s)
	{
		s.setAtrasada(false);
		s.setCancelada(false);
		s.setChamada(false);
		if(s.getPreferencial())	
		{
			int pos = PUltimaSenhaPreferencialChamada;
			int multa = pos - s.getPos();
			s.setPos(multa);
			FilaSenhasPreferencial[s.getPos()] = null;
			for(int i = 0; i < multa; i++)
			{
				int _pos = i+s.getPos();
				FilaSenhasPreferencial[_pos] = FilaSenhasPreferencial[_pos+1];
			}
			FilaSenhasPreferencial[s.getPos()+multa] = s;
		}
		else
		{
			int pos = PUltimaSenhaNormalChamada;
			int multa = pos - s.getPos();
			s.setPos(multa);
			FilaSenhasNormal[s.getPos()] = null;
			for(int i = 0; i < multa; i++)
			{
				int _pos = i+s.getPos();
				FilaSenhasNormal[_pos] = FilaSenhasNormal[_pos+1];
			}
			FilaSenhasNormal[s.getPos()+multa] = s;
		}
	}
	
	public void atrasarSenha(Senha s)
	{
		if(s.getPreferencial())		
			FilaSenhasPreferencial[s.getPos()].setAtrasada(true);
		else
			FilaSenhasNormal[s.getPos()].setAtrasada(true);
	}
	
	public void cancelarSenha(Senha s)
	{
		if(s.getPreferencial())		
		{
			FilaSenhasPreferencial[s.getPos()].setCancelada(true);
			//FilaSenhasPreferencial[s.getPos()].setUsuario(null);
		}
		else
		{
			FilaSenhasNormal[s.getPos()].setCancelada(true);
			//FilaSenhasNormal[s.getPos()].setUsuario(null);
		}
	}
		
	public int getUltimaSenhaN()
	{
		return PUltimaSenhaNormal;
	}
	
	public controleSenhas()
	{
		this.FilaSenhasNormal 			= new Senha[9999];
		this.FilaSenhasPreferencial 	= new Senha[9999];
		
		this.PUltimaSenhaNormal 		= 0;
		this.PUltimaSenhaPreferencial 	= 0;
		
	}
	
	
	public void ResetarSenha()
	{
		this.cs = new controleSenhas();		
	}
		
	public Senha[] getFilaPreferencial()
	{
		return this.FilaSenhasPreferencial;
	}
	
	public Senha[] getFilaNormal()
	{
		return this.FilaSenhasNormal;
	}
	
	public Senha[] getProximas(int num)
	{
		Senha[] proximas = new Senha[num];
		int index = 0;
		
		for(int i = 0; i < PUltimaSenhaPreferencial; i++)
		{
			if(!FilaSenhasPreferencial[i].getChamada() 
					&& !FilaSenhasPreferencial[i].getCancelada()
					&& !FilaSenhasPreferencial[i].getAtrasada())
			{
				proximas[index] = FilaSenhasPreferencial[i];
				index++;
				if(index == num)
					return proximas;
			}
		}
		
		for(int i = 0; i < PUltimaSenhaNormal; i++)
		{
			if(!FilaSenhasNormal[i].getChamada() 
					&& !FilaSenhasNormal[i].getCancelada()
					&& !FilaSenhasNormal[i].getAtrasada()
					)
			{
				proximas[index] = FilaSenhasNormal[i];
				index++;
				if(index == num)
					return proximas;
			}
		}
		return proximas;
	}
	
	
	public Senha GerarSenha(Login u, boolean Preferencial)
	{
		Senha s  = null;
		if(!Preferencial)
		{
			s = new Senha(this.PUltimaSenhaNormal, Preferencial, new Date(), u);
			s.setPos(this.PUltimaSenhaNormal);
			this.FilaSenhasNormal[this.PUltimaSenhaNormal] = s;
			this.PUltimaSenhaNormal += 1;
		}
		else
		{
			s = new Senha(this.PUltimaSenhaPreferencial, Preferencial, new Date(), u);
			s.setPos(this.PUltimaSenhaPreferencial);
			this.FilaSenhasPreferencial[this.PUltimaSenhaPreferencial] = s;	
			this.PUltimaSenhaPreferencial += 1;
		}		
		return s;
	}
}
