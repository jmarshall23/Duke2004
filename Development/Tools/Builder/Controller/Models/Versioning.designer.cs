﻿#pragma warning disable 1591
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.17929
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Controller.Models
{
	using System.Data.Linq;
	using System.Data.Linq.Mapping;
	using System.Data;
	using System.Collections.Generic;
	using System.Reflection;
	using System.Linq;
	using System.Linq.Expressions;
	using System.ComponentModel;
	using System;
	
	
	[global::System.Data.Linq.Mapping.DatabaseAttribute(Name="Builder")]
	public partial class VersioningDataContext : System.Data.Linq.DataContext
	{
		
		private static System.Data.Linq.Mapping.MappingSource mappingSource = new AttributeMappingSource();
		
    #region Extensibility Method Definitions
    partial void OnCreated();
    partial void InsertVersioning(Versioning instance);
    partial void UpdateVersioning(Versioning instance);
    partial void DeleteVersioning(Versioning instance);
    #endregion
		
		public VersioningDataContext() : 
				base(global::Controller.Properties.Settings.Default.BuilderConnectionString, mappingSource)
		{
			OnCreated();
		}
		
		public VersioningDataContext(string connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public VersioningDataContext(System.Data.IDbConnection connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public VersioningDataContext(string connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public VersioningDataContext(System.Data.IDbConnection connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public System.Data.Linq.Table<Versioning> Versionings
		{
			get
			{
				return this.GetTable<Versioning>();
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.Versioning")]
	public partial class Versioning : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private int _ID;
		
		private string _Label;
		
		private int _EngineVersion;
		
		private int _Changelist;
		
    #region Extensibility Method Definitions
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void OnIDChanging(int value);
    partial void OnIDChanged();
    partial void OnLabelChanging(string value);
    partial void OnLabelChanged();
    partial void OnEngineVersionChanging(int value);
    partial void OnEngineVersionChanged();
    partial void OnChangelistChanging(int value);
    partial void OnChangelistChanged();
    #endregion
		
		public Versioning()
		{
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_ID", AutoSync=AutoSync.OnInsert, DbType="Int NOT NULL IDENTITY", IsPrimaryKey=true, IsDbGenerated=true)]
		public int ID
		{
			get
			{
				return this._ID;
			}
			set
			{
				if ((this._ID != value))
				{
					this.OnIDChanging(value);
					this.SendPropertyChanging();
					this._ID = value;
					this.SendPropertyChanged("ID");
					this.OnIDChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Label", DbType="VarChar(96) NOT NULL", CanBeNull=false)]
		public string Label
		{
			get
			{
				return this._Label;
			}
			set
			{
				if ((this._Label != value))
				{
					this.OnLabelChanging(value);
					this.SendPropertyChanging();
					this._Label = value;
					this.SendPropertyChanged("Label");
					this.OnLabelChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_EngineVersion", DbType="Int NOT NULL")]
		public int EngineVersion
		{
			get
			{
				return this._EngineVersion;
			}
			set
			{
				if ((this._EngineVersion != value))
				{
					this.OnEngineVersionChanging(value);
					this.SendPropertyChanging();
					this._EngineVersion = value;
					this.SendPropertyChanged("EngineVersion");
					this.OnEngineVersionChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Changelist", DbType="Int NOT NULL")]
		public int Changelist
		{
			get
			{
				return this._Changelist;
			}
			set
			{
				if ((this._Changelist != value))
				{
					this.OnChangelistChanging(value);
					this.SendPropertyChanging();
					this._Changelist = value;
					this.SendPropertyChanged("Changelist");
					this.OnChangelistChanged();
				}
			}
		}
		
		public event PropertyChangingEventHandler PropertyChanging;
		
		public event PropertyChangedEventHandler PropertyChanged;
		
		protected virtual void SendPropertyChanging()
		{
			if ((this.PropertyChanging != null))
			{
				this.PropertyChanging(this, emptyChangingEventArgs);
			}
		}
		
		protected virtual void SendPropertyChanged(String propertyName)
		{
			if ((this.PropertyChanged != null))
			{
				this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
			}
		}
	}
}
#pragma warning restore 1591
