using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Pomelo.EntityFrameworkCore.MySql.Scaffolding.Internal;
using PPPStorageApplication.Persistance.Models;

namespace PPPStorageApplication.Persistance;

public partial class MyDbContext : DbContext
{
    public MyDbContext()
    {
    }

    public MyDbContext(DbContextOptions<MyDbContext> options)
        : base(options)
    {
    }
    public virtual DbSet<Buyer> Buyers { get; set; }

    public virtual DbSet<Category> Categories { get; set; }

    public virtual DbSet<City> Cities { get; set; }

    public virtual DbSet<LegalEntity> LegalEntities { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<OrderItem> OrderItems { get; set; }

    public virtual DbSet<Price> Prices { get; set; }

    public virtual DbSet<Product> Products { get; set; }

    public virtual DbSet<ProductPrice> ProductPrices { get; set; }

    public virtual DbSet<Supplier> Suppliers { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder
            .UseCollation("utf8mb4_0900_ai_ci")
            .HasCharSet("utf8mb4");

        modelBuilder.Entity<Buyer>(entity =>
        {
            entity.HasKey(e => e.LegalEntityId).HasName("PRIMARY");

            entity.ToTable("buyer");

            entity.Property(e => e.LegalEntityId)
                .ValueGeneratedNever()
                .HasColumnType("bigint(20)")
                .HasColumnName("legal_entity_id");

            entity.HasOne(d => d.LegalEntity).WithOne(p => p.Buyer)
                .HasForeignKey<Buyer>(d => d.LegalEntityId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk1");
        });

        modelBuilder.Entity<Category>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("category");

            entity.Property(e => e.Id)
                .HasColumnType("bigint(20)")
                .HasColumnName("id");
            entity.Property(e => e.Name)
                .HasMaxLength(30)
                .HasColumnName("name");
        });

        modelBuilder.Entity<City>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("city");

            entity.Property(e => e.Id)
                .HasColumnType("bigint(20)")
                .HasColumnName("id");
            entity.Property(e => e.Name)
                .HasMaxLength(20)
                .HasColumnName("name");
        });

        modelBuilder.Entity<LegalEntity>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("legal_entity");

            entity.HasIndex(e => e.CityId, "fk_1");

            entity.Property(e => e.Id)
                .HasColumnType("bigint(20)")
                .HasColumnName("id");
            entity.Property(e => e.CityId)
                .HasColumnType("bigint(20)")
                .HasColumnName("city_id");
            entity.Property(e => e.Name)
                .HasMaxLength(40)
                .HasColumnName("name");

            entity.HasOne(d => d.City).WithMany(p => p.LegalEntities)
                .HasForeignKey(d => d.CityId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_1");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("order");

            entity.HasIndex(e => e.BuyerId, "fk7");

            entity.Property(e => e.Id)
                .HasColumnType("bigint(20)")
                .HasColumnName("id");
            entity.Property(e => e.BuyerId)
                .HasColumnType("bigint(20)")
                .HasColumnName("buyer_id");
            entity.Property(e => e.Date).HasColumnName("date");

            entity.HasOne(d => d.Buyer).WithMany(p => p.Orders)
                .HasForeignKey(d => d.BuyerId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk7");
        });

        modelBuilder.Entity<OrderItem>(entity =>
        {
            entity.HasKey(e => new { e.Id, e.OrderId })
                .HasName("PRIMARY")
                .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0 });

            entity.ToTable("order_item");

            entity.HasIndex(e => e.ProductId, "fk10");

            entity.HasIndex(e => e.OrderId, "fk9");

            entity.Property(e => e.Id)
                .ValueGeneratedOnAdd()
                .HasColumnType("bigint(20)")
                .HasColumnName("id");
            entity.Property(e => e.OrderId)
                .HasColumnType("bigint(20)")
                .HasColumnName("order_id");
            entity.Property(e => e.ProductId)
                .HasColumnType("bigint(20)")
                .HasColumnName("product_id");
            entity.Property(e => e.Quantity)
                .HasColumnType("bigint(20)")
                .HasColumnName("quantity");

            entity.HasOne(d => d.Order).WithMany(p => p.OrderItems)
                .HasForeignKey(d => d.OrderId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk9");

            entity.HasOne(d => d.Product).WithMany(p => p.OrderItems)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk10");
        });

        modelBuilder.Entity<Price>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("price");

            entity.Property(e => e.Id)
                .HasColumnType("bigint(20)")
                .HasColumnName("id");
            entity.Property(e => e.Amount).HasColumnName("amount");
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("product");

            entity.HasIndex(e => e.CategoryId, "fk3");

            entity.HasIndex(e => e.SupplierId, "fk4");

            entity.Property(e => e.Id)
                .HasColumnType("bigint(20)")
                .HasColumnName("id");
            entity.Property(e => e.CategoryId)
                .HasColumnType("bigint(20)")
                .HasColumnName("category_id");
            entity.Property(e => e.MeasurementUnit)
                .HasMaxLength(10)
                .HasColumnName("measurement_unit");
            entity.Property(e => e.Name)
                .HasMaxLength(30)
                .HasColumnName("name");
            entity.Property(e => e.SupplierId)
                .HasColumnType("bigint(20)")
                .HasColumnName("supplier_id");

            entity.HasOne(d => d.Category).WithMany(p => p.Products)
                .HasForeignKey(d => d.CategoryId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk3");

            entity.HasOne(d => d.Supplier).WithMany(p => p.Products)
                .HasForeignKey(d => d.SupplierId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk4");
        });

        modelBuilder.Entity<ProductPrice>(entity =>
        {
            entity.HasKey(e => new { e.ProductId, e.PriceId, e.StartingDate })
                .HasName("PRIMARY")
                .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0, 0 });

            entity.ToTable("product_price");

            entity.HasIndex(e => e.PriceId, "fk6");

            entity.Property(e => e.ProductId)
                .HasColumnType("bigint(20)")
                .HasColumnName("product_id");
            entity.Property(e => e.PriceId)
                .HasColumnType("bigint(20)")
                .HasColumnName("price_id");
            entity.Property(e => e.StartingDate).HasColumnName("starting_date");
            entity.Property(e => e.EndingDate).HasColumnName("ending_date");

            entity.HasOne(d => d.Price).WithMany(p => p.ProductPrices)
                .HasForeignKey(d => d.PriceId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk6");

            entity.HasOne(d => d.Product).WithMany(p => p.ProductPrices)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk5");
        });

        modelBuilder.Entity<Supplier>(entity =>
        {
            entity.HasKey(e => e.LegalEntityId).HasName("PRIMARY");

            entity.ToTable("supplier");

            entity.Property(e => e.LegalEntityId)
                .ValueGeneratedNever()
                .HasColumnType("bigint(20)")
                .HasColumnName("legal_entity_id");

            entity.HasOne(d => d.LegalEntity).WithOne(p => p.Supplier)
                .HasForeignKey<Supplier>(d => d.LegalEntityId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk2");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
