using System;
using System.Collections.Generic;
using CFP.Common.Utility;
using Microsoft.EntityFrameworkCore;

namespace CFP.Repository.Models;

public partial class EndeavorCRMContext : DbContext
{
    public EndeavorCRMContext()
    {
    }

    public EndeavorCRMContext(DbContextOptions<EndeavorCRMContext> options)
        : base(options)
    {
    }

    public virtual DbSet<AgentMaster> AgentMasters { get; set; }

    public virtual DbSet<LoginFailure> LoginFailures { get; set; }

    public virtual DbSet<LoginHistory> LoginHistories { get; set; }

    public virtual DbSet<Menu> Menus { get; set; }

    public virtual DbSet<MenuRole> MenuRoles { get; set; }

    public virtual DbSet<Role> Roles { get; set; }

    public virtual DbSet<UserMaster> UserMasters { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer(AppCommon.ConnectionString).UseLazyLoadingProxies();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<AgentMaster>(entity =>
        {
            entity.ToTable("AgentMaster");

            entity.Property(e => e.ContactNumber)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.CreatedOn).HasColumnType("datetime");
            entity.Property(e => e.Degiganition)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.FirstName)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.Ip)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("IP");
            entity.Property(e => e.LastName)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.UpdatedOn).HasColumnType("datetime");
            entity.Property(e => e.Username)
                .HasMaxLength(200)
                .IsUnicode(false);

            entity.HasOne(d => d.CreatedByNavigation).WithMany(p => p.AgentMasterCreatedByNavigations)
                .HasForeignKey(d => d.CreatedBy)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.UpdatedByNavigation).WithMany(p => p.AgentMasterUpdatedByNavigations).HasForeignKey(d => d.UpdatedBy);

            entity.HasOne(d => d.UserMaster).WithMany(p => p.AgentMasterUserMasters)
                .HasForeignKey(d => d.UserMasterId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_AgentMaster_UserMaster_UserId");
        });

        modelBuilder.Entity<LoginFailure>(entity =>
        {
            entity.ToTable("LoginFailure");

            entity.Property(e => e.CreatedOn).HasColumnType("datetime");
            entity.Property(e => e.Ip)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("IP");
            entity.Property(e => e.Username)
                .HasMaxLength(200)
                .IsUnicode(false);
        });

        modelBuilder.Entity<LoginHistory>(entity =>
        {
            entity.ToTable("LoginHistory");

            entity.Property(e => e.Ip)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("IP");
            entity.Property(e => e.LoggedInTime).HasColumnType("datetime");

            entity.HasOne(d => d.UserMaster).WithMany(p => p.LoginHistories)
                .HasForeignKey(d => d.UserMasterId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Menu>(entity =>
        {
            entity.ToTable("Menu");

            entity.Property(e => e.MenuId).ValueGeneratedNever();
            entity.Property(e => e.Icon)
                .HasMaxLength(30)
                .IsUnicode(false);
            entity.Property(e => e.MenuName)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.MenuNameId)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.PageUrl)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("PageURL");
        });

        modelBuilder.Entity<MenuRole>(entity =>
        {
            entity.ToTable("MenuRole");

            entity.HasOne(d => d.Menu).WithMany(p => p.MenuRoles)
                .HasForeignKey(d => d.MenuId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Role).WithMany(p => p.MenuRoles)
                .HasForeignKey(d => d.RoleId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.ToTable("Role");

            entity.Property(e => e.RoleName).HasMaxLength(50);
        });

        modelBuilder.Entity<UserMaster>(entity =>
        {
            entity.ToTable("UserMaster");

            entity.Property(e => e.ContactNumber)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.CreatedOn).HasColumnType("datetime");
            entity.Property(e => e.FirstName)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.Ip)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("IP");
            entity.Property(e => e.LastName)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.UpdatedOn).HasColumnType("datetime");
            entity.Property(e => e.UserPassword)
                .HasMaxLength(500)
                .IsUnicode(false);
            entity.Property(e => e.Username)
                .HasMaxLength(200)
                .IsUnicode(false);

            entity.HasOne(d => d.Role).WithMany(p => p.UserMasters)
                .HasForeignKey(d => d.RoleId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
