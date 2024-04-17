using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;
using RpgApi.Models;
using RpgApi.Models.Enuns;
using RpgApi.Utils;

namespace RpgApi.Data
{
    public class DataContest : DbContext
    {
        //Criar construtor CTOR + TAB
        public DataContest(DbContextOptions<DataContest>options) : base(options) //cria o chamado para o banco de dados é o construtor
        {
            
        }

        public DbSet<Personagem> TB_PERSONAGENS { get; set; } //nome dado a tabela no banco de dados

        public DbSet<Usuario> TB_USUARIO { get; set; }

        public DbSet<Arma> TB_ARMA { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)// override serve para alterar
        {

            
            modelBuilder.Entity<Personagem>().ToTable("TB_PERSONAGENS");
            modelBuilder.Entity<Arma>().ToTable("TB_ARMAS");
            modelBuilder.Entity<Usuario>().ToTable("TB_USUARIOS");

            modelBuilder.Entity<Usuario>()
                .HasMany(e => e.Personagens)
                .WithOne(e => e.Usuario)
                .HasForeignKey(e => e.UsuarioId)
                .IsRequired(false);

            modelBuilder.Entity<Personagem>().HasData //é igual o tipo de funcioanrios, rh, diretor, master
            (
                new Personagem() { Id = 1, Nome = "Frodo", PontosVida=100, Forca=17, Defesa=23, Inteligencia=33, Classe=ClasseEnun.Cavaleiro, UsuarioId = 1},
                new Personagem() { Id = 2, Nome = "Sam", PontosVida=100, Forca=15, Defesa=25, Inteligencia=30, Classe=ClasseEnun.Cavaleiro, UsuarioId = 1},
                new Personagem() { Id = 3, Nome = "Galadriel", PontosVida=100, Forca=18, Defesa=21, Inteligencia=35, Classe=ClasseEnun.Clerigo, UsuarioId = 1},
                new Personagem() { Id = 4, Nome = "Gandalf", PontosVida=100, Forca=18, Defesa=18, Inteligencia=37, Classe=ClasseEnun.Mago, UsuarioId = 1},
                new Personagem() { Id = 5, Nome = "Hobbit", PontosVida=100, Forca=20, Defesa=17, Inteligencia=31, Classe=ClasseEnun.Cavaleiro, UsuarioId = 1},
                new Personagem() { Id = 6, Nome = "Celeborn", PontosVida=100, Forca=21, Defesa=13, Inteligencia=34, Classe=ClasseEnun.Clerigo, UsuarioId = 1},
                new Personagem() { Id = 7, Nome = "Radagast", PontosVida=100, Forca=25, Defesa=11, Inteligencia=35, Classe=ClasseEnun.Mago, UsuarioId = 1}
            );
            //base.OnModelCreating(modelBuilder);
            


            modelBuilder.Entity<Arma>().HasData //é igual o tipo de funcioanrios, rh, diretor, master
            (
                new Arma() { Id = 1, Nome = "Sword", Dano = 10},
                new Arma() { Id = 2, Nome = "Axe", Dano = 12},
                new Arma() { Id = 3, Nome = "SwordFire", Dano = 20},
                new Arma() { Id = 4, Nome = "Cajado", Dano = 15},
                new Arma() { Id = 5, Nome = "Spear", Dano = 55},
                new Arma() { Id = 6, Nome = "CajadoDeath", Dano = 30},
                new Arma() { Id = 7, Nome = "Guns", Dano = 100}
            );

            //inicio da criacao de usuário padrão
            Usuario user = new Usuario();
            Criptografia.CriarPasswordHash("123456", out byte[]hash, out byte[]salt);
            user.Id = 1;
            user.Username = "UsuarioAdmin";
            user.PasswordString = string.Empty;
            user.PasswordHash = hash;
            user.PasswordHash = salt;
            user.Perfil = "Admin";
            user.Email = "seuEmail@gamil.com";
            user.Latitude = -23.5200241;
            user.Longitude = -46.596498;

            modelBuilder.Entity<Usuario>().HasData(user);
            //fim da criacao do usuario padrao

            //Define que se o perfil nao for informado, o valor padrao sera jogador
            modelBuilder.Entity<Usuario>().Property(u => u.Perfil).HasDefaultValue("Jogador");
        

        }
        protected override void ConfigureConventions(ModelConfigurationBuilder configurationBuilder)//convensao para configurar a base, regras
        {
            configurationBuilder.Properties<string>().HaveColumnType("Varchar").HaveMaxLength(200);
        }

    }
}