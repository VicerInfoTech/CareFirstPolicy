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

    public virtual DbSet<ChatConnection> ChatConnections { get; set; }

    public virtual DbSet<ChatMessage> ChatMessages { get; set; }

    public virtual DbSet<ChatRoom> ChatRooms { get; set; }

    public virtual DbSet<ChatRoomMember> ChatRoomMembers { get; set; }

    public virtual DbSet<Deal> Deals { get; set; }

    public virtual DbSet<DealDocument> DealDocuments { get; set; }

    public virtual DbSet<LeadMaster> LeadMasters { get; set; }

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

            entity.Property(e => e.ChaseDataPassword)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.ChaseDataUsername)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.ChaseExt)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.ContactNumber)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.CreatedOn).HasColumnType("datetime");
            entity.Property(e => e.Designation)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Dob).HasColumnName("DOB");
            entity.Property(e => e.Email)
                .HasMaxLength(200)
                .IsUnicode(false);
            entity.Property(e => e.FfmUsername)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.FirstName)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.Forwarding)
                .HasMaxLength(150)
                .IsUnicode(false);
            entity.Property(e => e.HealthSherpaPassword)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.HealthSherpaUsername)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.Ip)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("IP");
            entity.Property(e => e.LastName)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.MyMfgPassword)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.MyMfgUsername)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.Npn)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("NPN");
            entity.Property(e => e.PayStructure)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Ssn)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("SSN");
            entity.Property(e => e.UpdatedOn).HasColumnType("datetime");

            entity.HasOne(d => d.CreatedByNavigation).WithMany(p => p.AgentMasterCreatedByNavigations)
                .HasForeignKey(d => d.CreatedBy)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.UpdatedByNavigation).WithMany(p => p.AgentMasterUpdatedByNavigations).HasForeignKey(d => d.UpdatedBy);

            entity.HasOne(d => d.UserMaster).WithMany(p => p.AgentMasterUserMasters)
                .HasForeignKey(d => d.UserMasterId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_AgentMaster_UserMaster_UserId");
        });

        modelBuilder.Entity<ChatConnection>(entity =>
        {
            entity.ToTable("ChatConnection");

            entity.Property(e => e.ConnectionId).HasMaxLength(100);
            entity.Property(e => e.CreatedOn).HasColumnType("datetime");

            entity.HasOne(d => d.UserMaster).WithMany(p => p.ChatConnections)
                .HasForeignKey(d => d.UserMasterId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ChatConnection_UserMaster");
        });

        modelBuilder.Entity<ChatMessage>(entity =>
        {
            entity.ToTable("ChatMessage");

            entity.Property(e => e.Message).HasMaxLength(2000);
            entity.Property(e => e.SentAt).HasColumnType("datetime");

            entity.HasOne(d => d.ChatRoom).WithMany(p => p.ChatMessages)
                .HasForeignKey(d => d.ChatRoomId)
                .HasConstraintName("FK_ChatMessage_ChatRoom");

            entity.HasOne(d => d.FromUser).WithMany(p => p.ChatMessageFromUsers)
                .HasForeignKey(d => d.FromUserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ChatMessage_UserMaster");

            entity.HasOne(d => d.ToUser).WithMany(p => p.ChatMessageToUsers)
                .HasForeignKey(d => d.ToUserId)
                .HasConstraintName("FK_ChatMessage_UserMaster1");
        });

        modelBuilder.Entity<ChatRoom>(entity =>
        {
            entity.ToTable("ChatRoom");

            entity.Property(e => e.CreatedOn).HasColumnType("datetime");
            entity.Property(e => e.Ip)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("IP");
            entity.Property(e => e.RoomName).HasMaxLength(250);
            entity.Property(e => e.UpdatedOn).HasColumnType("datetime");

            entity.HasOne(d => d.CreatedByNavigation).WithMany(p => p.ChatRoomCreatedByNavigations)
                .HasForeignKey(d => d.CreatedBy)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ChatRoom_UserMaster");

            entity.HasOne(d => d.UpdatedByNavigation).WithMany(p => p.ChatRoomUpdatedByNavigations)
                .HasForeignKey(d => d.UpdatedBy)
                .HasConstraintName("FK_ChatRoom_UserMaster1");
        });

        modelBuilder.Entity<ChatRoomMember>(entity =>
        {
            entity.ToTable("ChatRoomMember");

            entity.HasOne(d => d.ChatRoom).WithMany(p => p.ChatRoomMembers)
                .HasForeignKey(d => d.ChatRoomId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ChatRoomMember_ChatRoom");

            entity.HasOne(d => d.UserMaster).WithMany(p => p.ChatRoomMembers)
                .HasForeignKey(d => d.UserMasterId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ChatRoomMember_UserMaster");
        });

        modelBuilder.Entity<Deal>(entity =>
        {
            entity.ToTable("Deal");

            entity.Property(e => e.CloseDate).HasColumnType("datetime");
            entity.Property(e => e.CreatedOn).HasColumnType("datetime");
            entity.Property(e => e.Ffm)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("FFM");
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
            entity.Property(e => e.Notes)
                .HasMaxLength(500)
                .IsUnicode(false);
            entity.Property(e => e.TypeOfCoverage)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.UpdatedOn).HasColumnType("datetime");

            entity.HasOne(d => d.Agent).WithMany(p => p.Deals)
                .HasForeignKey(d => d.AgentId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Deal_AgentMaster_agentId");

            entity.HasOne(d => d.CreatedByNavigation).WithMany(p => p.DealCreatedByNavigations)
                .HasForeignKey(d => d.CreatedBy)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.UpdatedByNavigation).WithMany(p => p.DealUpdatedByNavigations)
                .HasForeignKey(d => d.UpdatedBy)
                .HasConstraintName("FK_Deal_UserMaster");
        });

        modelBuilder.Entity<DealDocument>(entity =>
        {
            entity.HasKey(e => e.DealDocId);

            entity.ToTable("DealDocument");

            entity.Property(e => e.DocName)
                .HasMaxLength(500)
                .IsUnicode(false);

            entity.HasOne(d => d.Deal).WithMany(p => p.DealDocuments)
                .HasForeignKey(d => d.DealId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_DealDocument_Deal");
        });

        modelBuilder.Entity<LeadMaster>(entity =>
        {
            entity.HasKey(e => e.LeadId).HasName("PK__LeadMast__73EF78FA114B1F69");

            entity.ToTable("LeadMaster");

            entity.Property(e => e.Address)
                .HasMaxLength(500)
                .IsUnicode(false);
            entity.Property(e => e.ContactNumber)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.CustomerName)
                .HasMaxLength(200)
                .IsUnicode(false);
            entity.Property(e => e.Email)
                .HasMaxLength(150)
                .IsUnicode(false);
            entity.Property(e => e.InterestedCoverage)
                .HasMaxLength(200)
                .IsUnicode(false);
            entity.Property(e => e.IsActive).HasDefaultValue(true);
            entity.Property(e => e.LeadSource)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.Notes).IsUnicode(false);
            entity.Property(e => e.UpdatedOn).HasColumnType("datetime");
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

            entity.Property(e => e.RoleId).ValueGeneratedNever();
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
