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
	public partial class JobsDataContext : System.Data.Linq.DataContext
	{
		
		private static System.Data.Linq.Mapping.MappingSource mappingSource = new AttributeMappingSource();
		
    #region Extensibility Method Definitions
    partial void OnCreated();
    partial void InsertJob(Job instance);
    partial void UpdateJob(Job instance);
    partial void DeleteJob(Job instance);
    #endregion
		
		public JobsDataContext() : 
				base(global::Controller.Properties.Settings.Default.BuilderConnectionString, mappingSource)
		{
			OnCreated();
		}
		
		public JobsDataContext(string connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public JobsDataContext(System.Data.IDbConnection connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public JobsDataContext(string connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public JobsDataContext(System.Data.IDbConnection connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public System.Data.Linq.Table<Job> Jobs
		{
			get
			{
				return this.GetTable<Job>();
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.Jobs")]
	public partial class Job : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private int _ID;
		
		private string _Name;
		
		private string _Command;
		
		private string _Platform;
		
		private string _Game;
		
		private string _Config;
		
		private string _ScriptConfig;
		
		private string _Language;
		
		private string _Define;
		
		private string _Parameter;
		
		private bool _Remote;
		
		private int _BranchConfigID;
		
		private int _CISTaskID;
		
		private int _CISJobStateID;
		
		private string _Label;
		
		private string _Machine;
		
		private System.Nullable<int> _BuildLogID;
		
		private bool _PrimaryBuild;
		
		private bool _Active;
		
		private bool _Complete;
		
		private bool _Succeeded;
		
		private bool _Optional;
		
		private bool _Killing;
		
		private bool _Suppressed;
		
		private System.Nullable<long> _SpawnTime;
		
    #region Extensibility Method Definitions
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void OnIDChanging(int value);
    partial void OnIDChanged();
    partial void OnNameChanging(string value);
    partial void OnNameChanged();
    partial void OnCommandChanging(string value);
    partial void OnCommandChanged();
    partial void OnPlatformChanging(string value);
    partial void OnPlatformChanged();
    partial void OnGameChanging(string value);
    partial void OnGameChanged();
    partial void OnConfigChanging(string value);
    partial void OnConfigChanged();
    partial void OnScriptConfigChanging(string value);
    partial void OnScriptConfigChanged();
    partial void OnLanguageChanging(string value);
    partial void OnLanguageChanged();
    partial void OnDefineChanging(string value);
    partial void OnDefineChanged();
    partial void OnParameterChanging(string value);
    partial void OnParameterChanged();
    partial void OnRemoteChanging(bool value);
    partial void OnRemoteChanged();
    partial void OnBranchConfigIDChanging(int value);
    partial void OnBranchConfigIDChanged();
    partial void OnCISTaskIDChanging(int value);
    partial void OnCISTaskIDChanged();
    partial void OnCISJobStateIDChanging(int value);
    partial void OnCISJobStateIDChanged();
    partial void OnLabelChanging(string value);
    partial void OnLabelChanged();
    partial void OnMachineChanging(string value);
    partial void OnMachineChanged();
    partial void OnBuildLogIDChanging(System.Nullable<int> value);
    partial void OnBuildLogIDChanged();
    partial void OnPrimaryBuildChanging(bool value);
    partial void OnPrimaryBuildChanged();
    partial void OnActiveChanging(bool value);
    partial void OnActiveChanged();
    partial void OnCompleteChanging(bool value);
    partial void OnCompleteChanged();
    partial void OnSucceededChanging(bool value);
    partial void OnSucceededChanged();
    partial void OnOptionalChanging(bool value);
    partial void OnOptionalChanged();
    partial void OnKillingChanging(bool value);
    partial void OnKillingChanged();
    partial void OnSuppressedChanging(bool value);
    partial void OnSuppressedChanged();
    partial void OnSpawnTimeChanging(System.Nullable<long> value);
    partial void OnSpawnTimeChanged();
    #endregion
		
		public Job()
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
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Name", DbType="VarChar(64)")]
		public string Name
		{
			get
			{
				return this._Name;
			}
			set
			{
				if ((this._Name != value))
				{
					this.OnNameChanging(value);
					this.SendPropertyChanging();
					this._Name = value;
					this.SendPropertyChanged("Name");
					this.OnNameChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Command", DbType="VarChar(64)")]
		public string Command
		{
			get
			{
				return this._Command;
			}
			set
			{
				if ((this._Command != value))
				{
					this.OnCommandChanging(value);
					this.SendPropertyChanging();
					this._Command = value;
					this.SendPropertyChanged("Command");
					this.OnCommandChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Platform", DbType="VarChar(32)")]
		public string Platform
		{
			get
			{
				return this._Platform;
			}
			set
			{
				if ((this._Platform != value))
				{
					this.OnPlatformChanging(value);
					this.SendPropertyChanging();
					this._Platform = value;
					this.SendPropertyChanged("Platform");
					this.OnPlatformChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Game", DbType="VarChar(64)")]
		public string Game
		{
			get
			{
				return this._Game;
			}
			set
			{
				if ((this._Game != value))
				{
					this.OnGameChanging(value);
					this.SendPropertyChanging();
					this._Game = value;
					this.SendPropertyChanged("Game");
					this.OnGameChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Config", DbType="VarChar(32)")]
		public string Config
		{
			get
			{
				return this._Config;
			}
			set
			{
				if ((this._Config != value))
				{
					this.OnConfigChanging(value);
					this.SendPropertyChanging();
					this._Config = value;
					this.SendPropertyChanged("Config");
					this.OnConfigChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_ScriptConfig", DbType="VarChar(32)")]
		public string ScriptConfig
		{
			get
			{
				return this._ScriptConfig;
			}
			set
			{
				if ((this._ScriptConfig != value))
				{
					this.OnScriptConfigChanging(value);
					this.SendPropertyChanging();
					this._ScriptConfig = value;
					this.SendPropertyChanged("ScriptConfig");
					this.OnScriptConfigChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Language", DbType="VarChar(64)")]
		public string Language
		{
			get
			{
				return this._Language;
			}
			set
			{
				if ((this._Language != value))
				{
					this.OnLanguageChanging(value);
					this.SendPropertyChanging();
					this._Language = value;
					this.SendPropertyChanged("Language");
					this.OnLanguageChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Define", DbType="VarChar(64)")]
		public string Define
		{
			get
			{
				return this._Define;
			}
			set
			{
				if ((this._Define != value))
				{
					this.OnDefineChanging(value);
					this.SendPropertyChanging();
					this._Define = value;
					this.SendPropertyChanged("Define");
					this.OnDefineChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Parameter", DbType="VarChar(1024)")]
		public string Parameter
		{
			get
			{
				return this._Parameter;
			}
			set
			{
				if ((this._Parameter != value))
				{
					this.OnParameterChanging(value);
					this.SendPropertyChanging();
					this._Parameter = value;
					this.SendPropertyChanged("Parameter");
					this.OnParameterChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Remote", DbType="Bit NOT NULL")]
		public bool Remote
		{
			get
			{
				return this._Remote;
			}
			set
			{
				if ((this._Remote != value))
				{
					this.OnRemoteChanging(value);
					this.SendPropertyChanging();
					this._Remote = value;
					this.SendPropertyChanged("Remote");
					this.OnRemoteChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_BranchConfigID", DbType="Int NOT NULL")]
		public int BranchConfigID
		{
			get
			{
				return this._BranchConfigID;
			}
			set
			{
				if ((this._BranchConfigID != value))
				{
					this.OnBranchConfigIDChanging(value);
					this.SendPropertyChanging();
					this._BranchConfigID = value;
					this.SendPropertyChanged("BranchConfigID");
					this.OnBranchConfigIDChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_CISTaskID", DbType="Int NOT NULL")]
		public int CISTaskID
		{
			get
			{
				return this._CISTaskID;
			}
			set
			{
				if ((this._CISTaskID != value))
				{
					this.OnCISTaskIDChanging(value);
					this.SendPropertyChanging();
					this._CISTaskID = value;
					this.SendPropertyChanged("CISTaskID");
					this.OnCISTaskIDChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_CISJobStateID", DbType="Int NOT NULL")]
		public int CISJobStateID
		{
			get
			{
				return this._CISJobStateID;
			}
			set
			{
				if ((this._CISJobStateID != value))
				{
					this.OnCISJobStateIDChanging(value);
					this.SendPropertyChanging();
					this._CISJobStateID = value;
					this.SendPropertyChanged("CISJobStateID");
					this.OnCISJobStateIDChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Label", DbType="VarChar(96)")]
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
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Machine", DbType="VarChar(16)")]
		public string Machine
		{
			get
			{
				return this._Machine;
			}
			set
			{
				if ((this._Machine != value))
				{
					this.OnMachineChanging(value);
					this.SendPropertyChanging();
					this._Machine = value;
					this.SendPropertyChanged("Machine");
					this.OnMachineChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_BuildLogID", DbType="Int")]
		public System.Nullable<int> BuildLogID
		{
			get
			{
				return this._BuildLogID;
			}
			set
			{
				if ((this._BuildLogID != value))
				{
					this.OnBuildLogIDChanging(value);
					this.SendPropertyChanging();
					this._BuildLogID = value;
					this.SendPropertyChanged("BuildLogID");
					this.OnBuildLogIDChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_PrimaryBuild", DbType="Bit NOT NULL")]
		public bool PrimaryBuild
		{
			get
			{
				return this._PrimaryBuild;
			}
			set
			{
				if ((this._PrimaryBuild != value))
				{
					this.OnPrimaryBuildChanging(value);
					this.SendPropertyChanging();
					this._PrimaryBuild = value;
					this.SendPropertyChanged("PrimaryBuild");
					this.OnPrimaryBuildChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Active", DbType="Bit NOT NULL")]
		public bool Active
		{
			get
			{
				return this._Active;
			}
			set
			{
				if ((this._Active != value))
				{
					this.OnActiveChanging(value);
					this.SendPropertyChanging();
					this._Active = value;
					this.SendPropertyChanged("Active");
					this.OnActiveChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Complete", DbType="Bit NOT NULL")]
		public bool Complete
		{
			get
			{
				return this._Complete;
			}
			set
			{
				if ((this._Complete != value))
				{
					this.OnCompleteChanging(value);
					this.SendPropertyChanging();
					this._Complete = value;
					this.SendPropertyChanged("Complete");
					this.OnCompleteChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Succeeded", DbType="Bit NOT NULL")]
		public bool Succeeded
		{
			get
			{
				return this._Succeeded;
			}
			set
			{
				if ((this._Succeeded != value))
				{
					this.OnSucceededChanging(value);
					this.SendPropertyChanging();
					this._Succeeded = value;
					this.SendPropertyChanged("Succeeded");
					this.OnSucceededChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Optional", DbType="Bit NOT NULL")]
		public bool Optional
		{
			get
			{
				return this._Optional;
			}
			set
			{
				if ((this._Optional != value))
				{
					this.OnOptionalChanging(value);
					this.SendPropertyChanging();
					this._Optional = value;
					this.SendPropertyChanged("Optional");
					this.OnOptionalChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Killing", DbType="Bit NOT NULL")]
		public bool Killing
		{
			get
			{
				return this._Killing;
			}
			set
			{
				if ((this._Killing != value))
				{
					this.OnKillingChanging(value);
					this.SendPropertyChanging();
					this._Killing = value;
					this.SendPropertyChanged("Killing");
					this.OnKillingChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Suppressed", DbType="Bit NOT NULL")]
		public bool Suppressed
		{
			get
			{
				return this._Suppressed;
			}
			set
			{
				if ((this._Suppressed != value))
				{
					this.OnSuppressedChanging(value);
					this.SendPropertyChanging();
					this._Suppressed = value;
					this.SendPropertyChanged("Suppressed");
					this.OnSuppressedChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_SpawnTime", DbType="BigInt")]
		public System.Nullable<long> SpawnTime
		{
			get
			{
				return this._SpawnTime;
			}
			set
			{
				if ((this._SpawnTime != value))
				{
					this.OnSpawnTimeChanging(value);
					this.SendPropertyChanging();
					this._SpawnTime = value;
					this.SendPropertyChanged("SpawnTime");
					this.OnSpawnTimeChanged();
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
