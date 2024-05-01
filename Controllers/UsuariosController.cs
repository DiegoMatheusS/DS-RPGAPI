using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using RpgApi.Data;
using RpgApi.Models.Enuns;
using RpgApi.Utils;
using RpgApi.Models;
using Microsoft.EntityFrameworkCore;



namespace RpgApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UsuariosController : ControllerBase
    {
        private readonly DataContest _context;

        public UsuariosController(DataContest context)
        {
            _context = context;
        }
        
        private async Task<bool> UsuarioExistente(string username)
        {
            if (await _context.TB_USUARIOS.AnyAsync(x => x.Username.ToLower() == username.ToLower()))
            {
                return true;
            }
            return false;
        }

        [HttpPost("Registrar")]
        public async Task<IActionResult> RegistraUsuario(Usuario user)
        {
            try
            {
                if (await UsuarioExistente(user.Username))
                throw new System.Exception("Nome de usuário já existe");

                Criptografia.CriarPasswordHash(user.PasswordString, out byte[] hash, out byte[] salt);
                user.PasswordString = string.Empty;
                user.PasswordHash = hash;
                user.PasswordSalt = salt;
                await _context.TB_USUARIOS.AddAsync(user);
                await _context.SaveChangesAsync();

                return Ok(user.Id);
            }
            catch (System.Exception ex) 
            {
                return BadRequest(ex.Message);
            }
        }


        [HttpPost("Autenticar")]
        public async Task<IActionResult> AtutenticarUsuario(Usuario credenciais)
        {
            try
            {
                Usuario? usuario = await _context.TB_USUARIOS
                    .FirstOrDefaultAsync(x=> x.Username.ToLower().Equals(credenciais.Username.ToLower()));
                if (usuario == null)
                {
                    throw new System.Exception("Usuário não encontrado.");

                }
                else if (!Criptografia.VerificarPasswordHash(credenciais.PasswordString, usuario.PasswordHash, usuario.PasswordSalt))
                {
                    throw new System.Exception("Senha Incorreta.");
                }            
                else
                {
                    return Ok(usuario);
                }

            }
            catch (System.Exception ex) 
            {
                return BadRequest(ex.Message);    
            
            }
        }


        [HttpPost]
        public async Task<IActionResult> Add(Arma novaArma)
        {
            try
            {
                
                if(novaArma.Dano == 0)
                    throw new Exception("O dano da arma não pode ser 0.");
            
                Personagem p = await _context.TB_PERSONAGENS
                    .FirstOrDefaultAsync(p => p.Id == novaArma.PersonagemId);

                if(p == null)
                    throw new Exception("Não existe personagem com o Id Informado");

                await _context.TB_ARMAS.AddAsync(novaArma);
                await _context.SaveChangesAsync();

                return Ok(novaArma.Id);
            }
            catch (System.Exception ex)
            {
                return BadRequest(ex.Message);    
            
            }
        }
    }
}