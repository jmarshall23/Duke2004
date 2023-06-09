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

namespace Builder.UnrealSyncService.Models
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
	public partial class CommandsDataContext : System.Data.Linq.DataContext
	{
		
		private static System.Data.Linq.Mapping.MappingSource mappingSource = new AttributeMappingSource();
		
    #region Extensibility Method Definitions
    partial void OnCreated();
    partial void InsertCommand(Command instance);
    partial void UpdateCommand(Command instance);
    partial void DeleteCommand(Command instance);
    #endregion
		
		public CommandsDataContext() : 
				base(global::Builder.UnrealSyncService.Properties.Settings.Default.BuilderConnectionString, mappingSource)
		{
			OnCreated();
		}
		
		public CommandsDataContext(string connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public CommandsDataContext(System.Data.IDbConnection connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public CommandsDataContext(string connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public CommandsDataContext(System.Data.IDbConnection connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public System.Data.Linq.Table<Command> Commands
		{
			get
			{
				return this.GetTable<Command>();
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.Commands")]
	public partial class Command : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private int _ID;
		
		private string _Command1;
		
		private byte _Type;
		
		private string _Description;
		
		private int _BranchConfigID;
		
		private string _Platform;
		
		private string _Game;
		
		private string _Config;
		
		private string _Language;
		
		private string _Parameter;
		
		private bool _IsPromotable;
		
		private string _MachineLock;
		
		private System.Nullable<int> _NextTriggerDelay;
		
		private System.Nullable<System.DateTime> _NextTrigger;
		
		private bool _PrimaryBuild;
		
		private int _LastAttemptedChangeList;
		
		private System.DateTime _LastAttemptedDateTime;
		
		private int _LastFailedChangeList;
		
		private System.DateTime _LastFailedDateTime;
		
		private int _LastGoodChangeList;
		
		private string _LastGoodLabel;
		
		private System.DateTime _LastGoodDateTime;
		
		private string _LatestApprovedLabel;
		
		private string _Operator;
		
		private string _Killer;
		
		private bool _Pending;
		
		private bool _Killing;
		
		private string _Machine;
		
		private System.Nullable<int> _BuildLogID;
		
		private System.Nullable<System.DateTime> _ConchHolder;
		
		private short _UserLevel;
		
		private int _Access;
		
		private int _Display;
		
		private int _DisplayDetail;
		
		private string _Hint;
		
		private EntityRef<Command> _Command3;
		
		private EntityRef<Command> _Command2;
		
    #region Extensibility Method Definitions
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void OnIDChanging(int value);
    partial void OnIDChanged();
    partial void OnCommand1Changing(string value);
    partial void OnCommand1Changed();
    partial void OnTypeChanging(byte value);
    partial void OnTypeChanged();
    partial void OnDescriptionChanging(string value);
    partial void OnDescriptionChanged();
    partial void OnBranchConfigIDChanging(int value);
    partial void OnBranchConfigIDChanged();
    partial void OnPlatformChanging(string value);
    partial void OnPlatformChanged();
    partial void OnGameChanging(string value);
    partial void OnGameChanged();
    partial void OnConfigChanging(string value);
    partial void OnConfigChanged();
    partial void OnLanguageChanging(string value);
    partial void OnLanguageChanged();
    partial void OnParameterChanging(string value);
    partial void OnParameterChanged();
    partial void OnIsPromotableChanging(bool value);
    partial void OnIsPromotableChanged();
    partial void OnMachineLockChanging(string value);
    partial void OnMachineLockChanged();
    partial void OnNextTriggerDelayChanging(System.Nullable<int> value);
    partial void OnNextTriggerDelayChanged();
    partial void OnNextTriggerChanging(System.Nullable<System.DateTime> value);
    partial void OnNextTriggerChanged();
    partial void OnPrimaryBuildChanging(bool value);
    partial void OnPrimaryBuildChanged();
    partial void OnLastAttemptedChangeListChanging(int value);
    partial void OnLastAttemptedChangeListChanged();
    partial void OnLastAttemptedDateTimeChanging(System.DateTime value);
    partial void OnLastAttemptedDateTimeChanged();
    partial void OnLastFailedChangeListChanging(int value);
    partial void OnLastFailedChangeListChanged();
    partial void OnLastFailedDateTimeChanging(System.DateTime value);
    partial void OnLastFailedDateTimeChanged();
    partial void OnLastGoodChangeListChanging(int value);
    partial void OnLastGoodChangeListChanged();
    partial void OnLastGoodLabelChanging(string value);
    partial void OnLastGoodLabelChanged();
    partial void OnLastGoodDateTimeChanging(System.DateTime value);
    partial void OnLastGoodDateTimeChanged();
    partial void OnLatestApprovedLabelChanging(string value);
    partial void OnLatestApprovedLabelChanged();
    partial void OnOperatorChanging(string value);
    partial void OnOperatorChanged();
    partial void OnKillerChanging(string value);
    partial void OnKillerChanged();
    partial void OnPendingChanging(bool value);
    partial void OnPendingChanged();
    partial void OnKillingChanging(bool value);
    partial void OnKillingChanged();
    partial void OnMachineChanging(string value);
    partial void OnMachineChanged();
    partial void OnBuildLogIDChanging(System.Nullable<int> value);
    partial void OnBuildLogIDChanged();
    partial void OnConchHolderChanging(System.Nullable<System.DateTime> value);
    partial void OnConchHolderChanged();
    partial void OnUserLevelChanging(short value);
    partial void OnUserLevelChanged();
    partial void OnAccessChanging(int value);
    partial void OnAccessChanged();
    partial void OnDisplayChanging(int value);
    partial void OnDisplayChanged();
    partial void OnDisplayDetailChanging(int value);
    partial void OnDisplayDetailChanged();
    partial void OnHintChanging(string value);
    partial void OnHintChanged();
    #endregion
		
		public Command()
		{
			this._Command3 = default(EntityRef<Command>);
			this._Command2 = default(EntityRef<Command>);
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
					if (this._Command2.HasLoadedOrAssignedValue)
					{
						throw new System.Data.Linq.ForeignKeyReferenceAlreadyHasValueException();
					}
					this.OnIDChanging(value);
					this.SendPropertyChanging();
					this._ID = value;
					this.SendPropertyChanged("ID");
					this.OnIDChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Name="Command", Storage="_Command1", DbType="VarChar(64) NOT NULL", CanBeNull=false)]
		public string Command1
		{
			get
			{
				return this._Command1;
			}
			set
			{
				if ((this._Command1 != value))
				{
					this.OnCommand1Changing(value);
					this.SendPropertyChanging();
					this._Command1 = value;
					this.SendPropertyChanged("Command1");
					this.OnCommand1Changed();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Type", DbType="TinyInt NOT NULL")]
		public byte Type
		{
			get
			{
				return this._Type;
			}
			set
			{
				if ((this._Type != value))
				{
					this.OnTypeChanging(value);
					this.SendPropertyChanging();
					this._Type = value;
					this.SendPropertyChanged("Type");
					this.OnTypeChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Description", DbType="VarChar(64) NOT NULL", CanBeNull=false)]
		public string Description
		{
			get
			{
				return this._Description;
			}
			set
			{
				if ((this._Description != value))
				{
					this.OnDescriptionChanging(value);
					this.SendPropertyChanging();
					this._Description = value;
					this.SendPropertyChanged("Description");
					this.OnDescriptionChanged();
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
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Platform", DbType="VarChar(32) NOT NULL", CanBeNull=false)]
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
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Game", DbType="VarChar(64) NOT NULL", CanBeNull=false)]
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
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Config", DbType="VarChar(32) NOT NULL", CanBeNull=false)]
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
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Language", DbType="VarChar(32) NOT NULL", CanBeNull=false)]
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
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Parameter", DbType="VarChar(64) NOT NULL", CanBeNull=false)]
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
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_IsPromotable", DbType="Bit NOT NULL")]
		public bool IsPromotable
		{
			get
			{
				return this._IsPromotable;
			}
			set
			{
				if ((this._IsPromotable != value))
				{
					this.OnIsPromotableChanging(value);
					this.SendPropertyChanging();
					this._IsPromotable = value;
					this.SendPropertyChanged("IsPromotable");
					this.OnIsPromotableChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_MachineLock", DbType="VarChar(32) NOT NULL", CanBeNull=false)]
		public string MachineLock
		{
			get
			{
				return this._MachineLock;
			}
			set
			{
				if ((this._MachineLock != value))
				{
					this.OnMachineLockChanging(value);
					this.SendPropertyChanging();
					this._MachineLock = value;
					this.SendPropertyChanged("MachineLock");
					this.OnMachineLockChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_NextTriggerDelay", DbType="Int")]
		public System.Nullable<int> NextTriggerDelay
		{
			get
			{
				return this._NextTriggerDelay;
			}
			set
			{
				if ((this._NextTriggerDelay != value))
				{
					this.OnNextTriggerDelayChanging(value);
					this.SendPropertyChanging();
					this._NextTriggerDelay = value;
					this.SendPropertyChanged("NextTriggerDelay");
					this.OnNextTriggerDelayChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_NextTrigger", DbType="DateTime")]
		public System.Nullable<System.DateTime> NextTrigger
		{
			get
			{
				return this._NextTrigger;
			}
			set
			{
				if ((this._NextTrigger != value))
				{
					this.OnNextTriggerChanging(value);
					this.SendPropertyChanging();
					this._NextTrigger = value;
					this.SendPropertyChanged("NextTrigger");
					this.OnNextTriggerChanged();
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
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_LastAttemptedChangeList", DbType="Int NOT NULL")]
		public int LastAttemptedChangeList
		{
			get
			{
				return this._LastAttemptedChangeList;
			}
			set
			{
				if ((this._LastAttemptedChangeList != value))
				{
					this.OnLastAttemptedChangeListChanging(value);
					this.SendPropertyChanging();
					this._LastAttemptedChangeList = value;
					this.SendPropertyChanged("LastAttemptedChangeList");
					this.OnLastAttemptedChangeListChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_LastAttemptedDateTime", DbType="DateTime NOT NULL")]
		public System.DateTime LastAttemptedDateTime
		{
			get
			{
				return this._LastAttemptedDateTime;
			}
			set
			{
				if ((this._LastAttemptedDateTime != value))
				{
					this.OnLastAttemptedDateTimeChanging(value);
					this.SendPropertyChanging();
					this._LastAttemptedDateTime = value;
					this.SendPropertyChanged("LastAttemptedDateTime");
					this.OnLastAttemptedDateTimeChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_LastFailedChangeList", DbType="Int NOT NULL")]
		public int LastFailedChangeList
		{
			get
			{
				return this._LastFailedChangeList;
			}
			set
			{
				if ((this._LastFailedChangeList != value))
				{
					this.OnLastFailedChangeListChanging(value);
					this.SendPropertyChanging();
					this._LastFailedChangeList = value;
					this.SendPropertyChanged("LastFailedChangeList");
					this.OnLastFailedChangeListChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_LastFailedDateTime", DbType="DateTime NOT NULL")]
		public System.DateTime LastFailedDateTime
		{
			get
			{
				return this._LastFailedDateTime;
			}
			set
			{
				if ((this._LastFailedDateTime != value))
				{
					this.OnLastFailedDateTimeChanging(value);
					this.SendPropertyChanging();
					this._LastFailedDateTime = value;
					this.SendPropertyChanged("LastFailedDateTime");
					this.OnLastFailedDateTimeChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_LastGoodChangeList", DbType="Int NOT NULL")]
		public int LastGoodChangeList
		{
			get
			{
				return this._LastGoodChangeList;
			}
			set
			{
				if ((this._LastGoodChangeList != value))
				{
					this.OnLastGoodChangeListChanging(value);
					this.SendPropertyChanging();
					this._LastGoodChangeList = value;
					this.SendPropertyChanged("LastGoodChangeList");
					this.OnLastGoodChangeListChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_LastGoodLabel", DbType="VarChar(96)")]
		public string LastGoodLabel
		{
			get
			{
				return this._LastGoodLabel;
			}
			set
			{
				if ((this._LastGoodLabel != value))
				{
					this.OnLastGoodLabelChanging(value);
					this.SendPropertyChanging();
					this._LastGoodLabel = value;
					this.SendPropertyChanged("LastGoodLabel");
					this.OnLastGoodLabelChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_LastGoodDateTime", DbType="DateTime NOT NULL")]
		public System.DateTime LastGoodDateTime
		{
			get
			{
				return this._LastGoodDateTime;
			}
			set
			{
				if ((this._LastGoodDateTime != value))
				{
					this.OnLastGoodDateTimeChanging(value);
					this.SendPropertyChanging();
					this._LastGoodDateTime = value;
					this.SendPropertyChanged("LastGoodDateTime");
					this.OnLastGoodDateTimeChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_LatestApprovedLabel", DbType="VarChar(96)")]
		public string LatestApprovedLabel
		{
			get
			{
				return this._LatestApprovedLabel;
			}
			set
			{
				if ((this._LatestApprovedLabel != value))
				{
					this.OnLatestApprovedLabelChanging(value);
					this.SendPropertyChanging();
					this._LatestApprovedLabel = value;
					this.SendPropertyChanged("LatestApprovedLabel");
					this.OnLatestApprovedLabelChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Operator", DbType="VarChar(32) NOT NULL", CanBeNull=false)]
		public string Operator
		{
			get
			{
				return this._Operator;
			}
			set
			{
				if ((this._Operator != value))
				{
					this.OnOperatorChanging(value);
					this.SendPropertyChanging();
					this._Operator = value;
					this.SendPropertyChanged("Operator");
					this.OnOperatorChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Killer", DbType="VarChar(32) NOT NULL", CanBeNull=false)]
		public string Killer
		{
			get
			{
				return this._Killer;
			}
			set
			{
				if ((this._Killer != value))
				{
					this.OnKillerChanging(value);
					this.SendPropertyChanging();
					this._Killer = value;
					this.SendPropertyChanged("Killer");
					this.OnKillerChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Pending", DbType="Bit NOT NULL")]
		public bool Pending
		{
			get
			{
				return this._Pending;
			}
			set
			{
				if ((this._Pending != value))
				{
					this.OnPendingChanging(value);
					this.SendPropertyChanging();
					this._Pending = value;
					this.SendPropertyChanged("Pending");
					this.OnPendingChanged();
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
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Machine", DbType="VarChar(32) NOT NULL", CanBeNull=false)]
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
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_ConchHolder", DbType="DateTime")]
		public System.Nullable<System.DateTime> ConchHolder
		{
			get
			{
				return this._ConchHolder;
			}
			set
			{
				if ((this._ConchHolder != value))
				{
					this.OnConchHolderChanging(value);
					this.SendPropertyChanging();
					this._ConchHolder = value;
					this.SendPropertyChanged("ConchHolder");
					this.OnConchHolderChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UserLevel", DbType="SmallInt NOT NULL")]
		public short UserLevel
		{
			get
			{
				return this._UserLevel;
			}
			set
			{
				if ((this._UserLevel != value))
				{
					this.OnUserLevelChanging(value);
					this.SendPropertyChanging();
					this._UserLevel = value;
					this.SendPropertyChanged("UserLevel");
					this.OnUserLevelChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Access", DbType="Int NOT NULL")]
		public int Access
		{
			get
			{
				return this._Access;
			}
			set
			{
				if ((this._Access != value))
				{
					this.OnAccessChanging(value);
					this.SendPropertyChanging();
					this._Access = value;
					this.SendPropertyChanged("Access");
					this.OnAccessChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Display", DbType="Int NOT NULL")]
		public int Display
		{
			get
			{
				return this._Display;
			}
			set
			{
				if ((this._Display != value))
				{
					this.OnDisplayChanging(value);
					this.SendPropertyChanging();
					this._Display = value;
					this.SendPropertyChanged("Display");
					this.OnDisplayChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_DisplayDetail", DbType="Int NOT NULL")]
		public int DisplayDetail
		{
			get
			{
				return this._DisplayDetail;
			}
			set
			{
				if ((this._DisplayDetail != value))
				{
					this.OnDisplayDetailChanging(value);
					this.SendPropertyChanging();
					this._DisplayDetail = value;
					this.SendPropertyChanged("DisplayDetail");
					this.OnDisplayDetailChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Hint", DbType="VarChar(16) NOT NULL", CanBeNull=false)]
		public string Hint
		{
			get
			{
				return this._Hint;
			}
			set
			{
				if ((this._Hint != value))
				{
					this.OnHintChanging(value);
					this.SendPropertyChanging();
					this._Hint = value;
					this.SendPropertyChanged("Hint");
					this.OnHintChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.AssociationAttribute(Name="Command_Command", Storage="_Command3", ThisKey="ID", OtherKey="ID", IsUnique=true, IsForeignKey=false)]
		public Command Command3
		{
			get
			{
				return this._Command3.Entity;
			}
			set
			{
				Command previousValue = this._Command3.Entity;
				if (((previousValue != value) 
							|| (this._Command3.HasLoadedOrAssignedValue == false)))
				{
					this.SendPropertyChanging();
					if ((previousValue != null))
					{
						this._Command3.Entity = null;
						previousValue.Command2 = null;
					}
					this._Command3.Entity = value;
					if ((value != null))
					{
						value.Command2 = this;
					}
					this.SendPropertyChanged("Command3");
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.AssociationAttribute(Name="Command_Command", Storage="_Command2", ThisKey="ID", OtherKey="ID", IsForeignKey=true)]
		public Command Command2
		{
			get
			{
				return this._Command2.Entity;
			}
			set
			{
				Command previousValue = this._Command2.Entity;
				if (((previousValue != value) 
							|| (this._Command2.HasLoadedOrAssignedValue == false)))
				{
					this.SendPropertyChanging();
					if ((previousValue != null))
					{
						this._Command2.Entity = null;
						previousValue.Command3 = null;
					}
					this._Command2.Entity = value;
					if ((value != null))
					{
						value.Command3 = this;
						this._ID = value.ID;
					}
					else
					{
						this._ID = default(int);
					}
					this.SendPropertyChanged("Command2");
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
