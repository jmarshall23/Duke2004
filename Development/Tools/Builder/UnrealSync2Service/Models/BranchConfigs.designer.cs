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
	public partial class BranchConfigsDataContext : System.Data.Linq.DataContext
	{
		
		private static System.Data.Linq.Mapping.MappingSource mappingSource = new AttributeMappingSource();
		
    #region Extensibility Method Definitions
    partial void OnCreated();
    partial void InsertBranchConfig(BranchConfig instance);
    partial void UpdateBranchConfig(BranchConfig instance);
    partial void DeleteBranchConfig(BranchConfig instance);
    #endregion
		
		public BranchConfigsDataContext() : 
				base(global::Builder.UnrealSyncService.Properties.Settings.Default.BuilderConnectionString, mappingSource)
		{
			OnCreated();
		}
		
		public BranchConfigsDataContext(string connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public BranchConfigsDataContext(System.Data.IDbConnection connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public BranchConfigsDataContext(string connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public BranchConfigsDataContext(System.Data.IDbConnection connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public System.Data.Linq.Table<BranchConfig> BranchConfigs
		{
			get
			{
				return this.GetTable<BranchConfig>();
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.BranchConfig")]
	public partial class BranchConfig : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private int _ID;
		
		private int _Version;
		
		private int _DisplayOrder;
		
		private string _Branch;
		
		private string _Server;
		
		private string _P4User;
		
		private string _P4Password;
		
		private string _P4ActualPassword;
		
		private string _P4SyncUser;
		
		private string _P4SyncPassword;
		
		private string _P4ActualSyncPassword;
		
		private string _P4ClientSpec;
		
		private string _BranchAdmin;
		
		private string _SDKRequirements;
		
		private string _DirectXVersion;
		
		private string _AndroidSDKVersion;
		
		private string _iPhoneSDKVersion;
		
		private string _MacSDKVersion;
		
		private string _NGPSDKVersion;
		
		private string _PS3SDKVersion;
		
		private string _WiiUSDKVersion;
		
		private string _Xbox360SDKVersion;
		
		private string _FlashSDKVersion;
		
		private string _PFXSubjectName;
		
		private string _IPhone_DeveloperSigningIdentity;
		
		private string _IPhone_DistributionSigningIdentity;
		
		private int _HeadChangelist;
		
		private int _LastFullyKnown;
		
		private int _LastGoodOverall;
		
		private int _LastFailOverall;
		
		private int _LastAttemptedOverall;
		
		private EntityRef<BranchConfig> _BranchConfig2;
		
		private EntityRef<BranchConfig> _BranchConfig1;
		
    #region Extensibility Method Definitions
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void OnIDChanging(int value);
    partial void OnIDChanged();
    partial void OnVersionChanging(int value);
    partial void OnVersionChanged();
    partial void OnDisplayOrderChanging(int value);
    partial void OnDisplayOrderChanged();
    partial void OnBranchChanging(string value);
    partial void OnBranchChanged();
    partial void OnServerChanging(string value);
    partial void OnServerChanged();
    partial void OnP4UserChanging(string value);
    partial void OnP4UserChanged();
    partial void OnP4PasswordChanging(string value);
    partial void OnP4PasswordChanged();
    partial void OnP4ActualPasswordChanging(string value);
    partial void OnP4ActualPasswordChanged();
    partial void OnP4SyncUserChanging(string value);
    partial void OnP4SyncUserChanged();
    partial void OnP4SyncPasswordChanging(string value);
    partial void OnP4SyncPasswordChanged();
    partial void OnP4ActualSyncPasswordChanging(string value);
    partial void OnP4ActualSyncPasswordChanged();
    partial void OnP4ClientSpecChanging(string value);
    partial void OnP4ClientSpecChanged();
    partial void OnBranchAdminChanging(string value);
    partial void OnBranchAdminChanged();
    partial void OnSDKRequirementsChanging(string value);
    partial void OnSDKRequirementsChanged();
    partial void OnDirectXVersionChanging(string value);
    partial void OnDirectXVersionChanged();
    partial void OnAndroidSDKVersionChanging(string value);
    partial void OnAndroidSDKVersionChanged();
    partial void OniPhoneSDKVersionChanging(string value);
    partial void OniPhoneSDKVersionChanged();
    partial void OnMacSDKVersionChanging(string value);
    partial void OnMacSDKVersionChanged();
    partial void OnNGPSDKVersionChanging(string value);
    partial void OnNGPSDKVersionChanged();
    partial void OnPS3SDKVersionChanging(string value);
    partial void OnPS3SDKVersionChanged();
    partial void OnWiiUSDKVersionChanging(string value);
    partial void OnWiiUSDKVersionChanged();
    partial void OnXbox360SDKVersionChanging(string value);
    partial void OnXbox360SDKVersionChanged();
    partial void OnFlashSDKVersionChanging(string value);
    partial void OnFlashSDKVersionChanged();
    partial void OnPFXSubjectNameChanging(string value);
    partial void OnPFXSubjectNameChanged();
    partial void OnIPhone_DeveloperSigningIdentityChanging(string value);
    partial void OnIPhone_DeveloperSigningIdentityChanged();
    partial void OnIPhone_DistributionSigningIdentityChanging(string value);
    partial void OnIPhone_DistributionSigningIdentityChanged();
    partial void OnHeadChangelistChanging(int value);
    partial void OnHeadChangelistChanged();
    partial void OnLastFullyKnownChanging(int value);
    partial void OnLastFullyKnownChanged();
    partial void OnLastGoodOverallChanging(int value);
    partial void OnLastGoodOverallChanged();
    partial void OnLastFailOverallChanging(int value);
    partial void OnLastFailOverallChanged();
    partial void OnLastAttemptedOverallChanging(int value);
    partial void OnLastAttemptedOverallChanged();
    #endregion
		
		public BranchConfig()
		{
			this._BranchConfig2 = default(EntityRef<BranchConfig>);
			this._BranchConfig1 = default(EntityRef<BranchConfig>);
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
					if (this._BranchConfig1.HasLoadedOrAssignedValue)
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
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Version", DbType="Int NOT NULL")]
		public int Version
		{
			get
			{
				return this._Version;
			}
			set
			{
				if ((this._Version != value))
				{
					this.OnVersionChanging(value);
					this.SendPropertyChanging();
					this._Version = value;
					this.SendPropertyChanged("Version");
					this.OnVersionChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_DisplayOrder", DbType="Int NOT NULL")]
		public int DisplayOrder
		{
			get
			{
				return this._DisplayOrder;
			}
			set
			{
				if ((this._DisplayOrder != value))
				{
					this.OnDisplayOrderChanging(value);
					this.SendPropertyChanging();
					this._DisplayOrder = value;
					this.SendPropertyChanged("DisplayOrder");
					this.OnDisplayOrderChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Branch", DbType="VarChar(32) NOT NULL", CanBeNull=false)]
		public string Branch
		{
			get
			{
				return this._Branch;
			}
			set
			{
				if ((this._Branch != value))
				{
					this.OnBranchChanging(value);
					this.SendPropertyChanging();
					this._Branch = value;
					this.SendPropertyChanged("Branch");
					this.OnBranchChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Server", DbType="VarChar(64) NOT NULL", CanBeNull=false)]
		public string Server
		{
			get
			{
				return this._Server;
			}
			set
			{
				if ((this._Server != value))
				{
					this.OnServerChanging(value);
					this.SendPropertyChanging();
					this._Server = value;
					this.SendPropertyChanged("Server");
					this.OnServerChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P4User", DbType="VarChar(64) NOT NULL", CanBeNull=false)]
		public string P4User
		{
			get
			{
				return this._P4User;
			}
			set
			{
				if ((this._P4User != value))
				{
					this.OnP4UserChanging(value);
					this.SendPropertyChanging();
					this._P4User = value;
					this.SendPropertyChanged("P4User");
					this.OnP4UserChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P4Password", DbType="VarChar(32) NOT NULL", CanBeNull=false)]
		public string P4Password
		{
			get
			{
				return this._P4Password;
			}
			set
			{
				if ((this._P4Password != value))
				{
					this.OnP4PasswordChanging(value);
					this.SendPropertyChanging();
					this._P4Password = value;
					this.SendPropertyChanged("P4Password");
					this.OnP4PasswordChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P4ActualPassword", DbType="VarChar(32) NOT NULL", CanBeNull=false)]
		public string P4ActualPassword
		{
			get
			{
				return this._P4ActualPassword;
			}
			set
			{
				if ((this._P4ActualPassword != value))
				{
					this.OnP4ActualPasswordChanging(value);
					this.SendPropertyChanging();
					this._P4ActualPassword = value;
					this.SendPropertyChanged("P4ActualPassword");
					this.OnP4ActualPasswordChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P4SyncUser", DbType="VarChar(64) NOT NULL", CanBeNull=false)]
		public string P4SyncUser
		{
			get
			{
				return this._P4SyncUser;
			}
			set
			{
				if ((this._P4SyncUser != value))
				{
					this.OnP4SyncUserChanging(value);
					this.SendPropertyChanging();
					this._P4SyncUser = value;
					this.SendPropertyChanged("P4SyncUser");
					this.OnP4SyncUserChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P4SyncPassword", DbType="VarChar(32) NOT NULL", CanBeNull=false)]
		public string P4SyncPassword
		{
			get
			{
				return this._P4SyncPassword;
			}
			set
			{
				if ((this._P4SyncPassword != value))
				{
					this.OnP4SyncPasswordChanging(value);
					this.SendPropertyChanging();
					this._P4SyncPassword = value;
					this.SendPropertyChanged("P4SyncPassword");
					this.OnP4SyncPasswordChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P4ActualSyncPassword", DbType="VarChar(32) NOT NULL", CanBeNull=false)]
		public string P4ActualSyncPassword
		{
			get
			{
				return this._P4ActualSyncPassword;
			}
			set
			{
				if ((this._P4ActualSyncPassword != value))
				{
					this.OnP4ActualSyncPasswordChanging(value);
					this.SendPropertyChanging();
					this._P4ActualSyncPassword = value;
					this.SendPropertyChanged("P4ActualSyncPassword");
					this.OnP4ActualSyncPasswordChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P4ClientSpec", DbType="VarChar(32) NOT NULL", CanBeNull=false)]
		public string P4ClientSpec
		{
			get
			{
				return this._P4ClientSpec;
			}
			set
			{
				if ((this._P4ClientSpec != value))
				{
					this.OnP4ClientSpecChanging(value);
					this.SendPropertyChanging();
					this._P4ClientSpec = value;
					this.SendPropertyChanged("P4ClientSpec");
					this.OnP4ClientSpecChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_BranchAdmin", DbType="VarChar(64) NOT NULL", CanBeNull=false)]
		public string BranchAdmin
		{
			get
			{
				return this._BranchAdmin;
			}
			set
			{
				if ((this._BranchAdmin != value))
				{
					this.OnBranchAdminChanging(value);
					this.SendPropertyChanging();
					this._BranchAdmin = value;
					this.SendPropertyChanged("BranchAdmin");
					this.OnBranchAdminChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_SDKRequirements", DbType="VarChar(MAX)")]
		public string SDKRequirements
		{
			get
			{
				return this._SDKRequirements;
			}
			set
			{
				if ((this._SDKRequirements != value))
				{
					this.OnSDKRequirementsChanging(value);
					this.SendPropertyChanging();
					this._SDKRequirements = value;
					this.SendPropertyChanged("SDKRequirements");
					this.OnSDKRequirementsChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_DirectXVersion", DbType="VarChar(32)")]
		public string DirectXVersion
		{
			get
			{
				return this._DirectXVersion;
			}
			set
			{
				if ((this._DirectXVersion != value))
				{
					this.OnDirectXVersionChanging(value);
					this.SendPropertyChanging();
					this._DirectXVersion = value;
					this.SendPropertyChanged("DirectXVersion");
					this.OnDirectXVersionChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_AndroidSDKVersion", DbType="VarChar(32)")]
		public string AndroidSDKVersion
		{
			get
			{
				return this._AndroidSDKVersion;
			}
			set
			{
				if ((this._AndroidSDKVersion != value))
				{
					this.OnAndroidSDKVersionChanging(value);
					this.SendPropertyChanging();
					this._AndroidSDKVersion = value;
					this.SendPropertyChanged("AndroidSDKVersion");
					this.OnAndroidSDKVersionChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_iPhoneSDKVersion", DbType="VarChar(32)")]
		public string iPhoneSDKVersion
		{
			get
			{
				return this._iPhoneSDKVersion;
			}
			set
			{
				if ((this._iPhoneSDKVersion != value))
				{
					this.OniPhoneSDKVersionChanging(value);
					this.SendPropertyChanging();
					this._iPhoneSDKVersion = value;
					this.SendPropertyChanged("iPhoneSDKVersion");
					this.OniPhoneSDKVersionChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_MacSDKVersion", DbType="VarChar(32)")]
		public string MacSDKVersion
		{
			get
			{
				return this._MacSDKVersion;
			}
			set
			{
				if ((this._MacSDKVersion != value))
				{
					this.OnMacSDKVersionChanging(value);
					this.SendPropertyChanging();
					this._MacSDKVersion = value;
					this.SendPropertyChanged("MacSDKVersion");
					this.OnMacSDKVersionChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_NGPSDKVersion", DbType="VarChar(32)")]
		public string NGPSDKVersion
		{
			get
			{
				return this._NGPSDKVersion;
			}
			set
			{
				if ((this._NGPSDKVersion != value))
				{
					this.OnNGPSDKVersionChanging(value);
					this.SendPropertyChanging();
					this._NGPSDKVersion = value;
					this.SendPropertyChanged("NGPSDKVersion");
					this.OnNGPSDKVersionChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_PS3SDKVersion", DbType="VarChar(32)")]
		public string PS3SDKVersion
		{
			get
			{
				return this._PS3SDKVersion;
			}
			set
			{
				if ((this._PS3SDKVersion != value))
				{
					this.OnPS3SDKVersionChanging(value);
					this.SendPropertyChanging();
					this._PS3SDKVersion = value;
					this.SendPropertyChanged("PS3SDKVersion");
					this.OnPS3SDKVersionChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_WiiUSDKVersion", DbType="VarChar(32)")]
		public string WiiUSDKVersion
		{
			get
			{
				return this._WiiUSDKVersion;
			}
			set
			{
				if ((this._WiiUSDKVersion != value))
				{
					this.OnWiiUSDKVersionChanging(value);
					this.SendPropertyChanging();
					this._WiiUSDKVersion = value;
					this.SendPropertyChanged("WiiUSDKVersion");
					this.OnWiiUSDKVersionChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Xbox360SDKVersion", DbType="VarChar(32)")]
		public string Xbox360SDKVersion
		{
			get
			{
				return this._Xbox360SDKVersion;
			}
			set
			{
				if ((this._Xbox360SDKVersion != value))
				{
					this.OnXbox360SDKVersionChanging(value);
					this.SendPropertyChanging();
					this._Xbox360SDKVersion = value;
					this.SendPropertyChanged("Xbox360SDKVersion");
					this.OnXbox360SDKVersionChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_FlashSDKVersion", DbType="VarChar(32)")]
		public string FlashSDKVersion
		{
			get
			{
				return this._FlashSDKVersion;
			}
			set
			{
				if ((this._FlashSDKVersion != value))
				{
					this.OnFlashSDKVersionChanging(value);
					this.SendPropertyChanging();
					this._FlashSDKVersion = value;
					this.SendPropertyChanged("FlashSDKVersion");
					this.OnFlashSDKVersionChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_PFXSubjectName", DbType="VarChar(64) NOT NULL", CanBeNull=false)]
		public string PFXSubjectName
		{
			get
			{
				return this._PFXSubjectName;
			}
			set
			{
				if ((this._PFXSubjectName != value))
				{
					this.OnPFXSubjectNameChanging(value);
					this.SendPropertyChanging();
					this._PFXSubjectName = value;
					this.SendPropertyChanged("PFXSubjectName");
					this.OnPFXSubjectNameChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_IPhone_DeveloperSigningIdentity", DbType="VarChar(64) NOT NULL", CanBeNull=false)]
		public string IPhone_DeveloperSigningIdentity
		{
			get
			{
				return this._IPhone_DeveloperSigningIdentity;
			}
			set
			{
				if ((this._IPhone_DeveloperSigningIdentity != value))
				{
					this.OnIPhone_DeveloperSigningIdentityChanging(value);
					this.SendPropertyChanging();
					this._IPhone_DeveloperSigningIdentity = value;
					this.SendPropertyChanged("IPhone_DeveloperSigningIdentity");
					this.OnIPhone_DeveloperSigningIdentityChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_IPhone_DistributionSigningIdentity", DbType="VarChar(64) NOT NULL", CanBeNull=false)]
		public string IPhone_DistributionSigningIdentity
		{
			get
			{
				return this._IPhone_DistributionSigningIdentity;
			}
			set
			{
				if ((this._IPhone_DistributionSigningIdentity != value))
				{
					this.OnIPhone_DistributionSigningIdentityChanging(value);
					this.SendPropertyChanging();
					this._IPhone_DistributionSigningIdentity = value;
					this.SendPropertyChanged("IPhone_DistributionSigningIdentity");
					this.OnIPhone_DistributionSigningIdentityChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_HeadChangelist", DbType="Int NOT NULL")]
		public int HeadChangelist
		{
			get
			{
				return this._HeadChangelist;
			}
			set
			{
				if ((this._HeadChangelist != value))
				{
					this.OnHeadChangelistChanging(value);
					this.SendPropertyChanging();
					this._HeadChangelist = value;
					this.SendPropertyChanged("HeadChangelist");
					this.OnHeadChangelistChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_LastFullyKnown", DbType="Int NOT NULL")]
		public int LastFullyKnown
		{
			get
			{
				return this._LastFullyKnown;
			}
			set
			{
				if ((this._LastFullyKnown != value))
				{
					this.OnLastFullyKnownChanging(value);
					this.SendPropertyChanging();
					this._LastFullyKnown = value;
					this.SendPropertyChanged("LastFullyKnown");
					this.OnLastFullyKnownChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_LastGoodOverall", DbType="Int NOT NULL")]
		public int LastGoodOverall
		{
			get
			{
				return this._LastGoodOverall;
			}
			set
			{
				if ((this._LastGoodOverall != value))
				{
					this.OnLastGoodOverallChanging(value);
					this.SendPropertyChanging();
					this._LastGoodOverall = value;
					this.SendPropertyChanged("LastGoodOverall");
					this.OnLastGoodOverallChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_LastFailOverall", DbType="Int NOT NULL")]
		public int LastFailOverall
		{
			get
			{
				return this._LastFailOverall;
			}
			set
			{
				if ((this._LastFailOverall != value))
				{
					this.OnLastFailOverallChanging(value);
					this.SendPropertyChanging();
					this._LastFailOverall = value;
					this.SendPropertyChanged("LastFailOverall");
					this.OnLastFailOverallChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_LastAttemptedOverall", DbType="Int NOT NULL")]
		public int LastAttemptedOverall
		{
			get
			{
				return this._LastAttemptedOverall;
			}
			set
			{
				if ((this._LastAttemptedOverall != value))
				{
					this.OnLastAttemptedOverallChanging(value);
					this.SendPropertyChanging();
					this._LastAttemptedOverall = value;
					this.SendPropertyChanged("LastAttemptedOverall");
					this.OnLastAttemptedOverallChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.AssociationAttribute(Name="BranchConfig_BranchConfig", Storage="_BranchConfig2", ThisKey="ID", OtherKey="ID", IsUnique=true, IsForeignKey=false)]
		public BranchConfig BranchConfig2
		{
			get
			{
				return this._BranchConfig2.Entity;
			}
			set
			{
				BranchConfig previousValue = this._BranchConfig2.Entity;
				if (((previousValue != value) 
							|| (this._BranchConfig2.HasLoadedOrAssignedValue == false)))
				{
					this.SendPropertyChanging();
					if ((previousValue != null))
					{
						this._BranchConfig2.Entity = null;
						previousValue.BranchConfig1 = null;
					}
					this._BranchConfig2.Entity = value;
					if ((value != null))
					{
						value.BranchConfig1 = this;
					}
					this.SendPropertyChanged("BranchConfig2");
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.AssociationAttribute(Name="BranchConfig_BranchConfig", Storage="_BranchConfig1", ThisKey="ID", OtherKey="ID", IsForeignKey=true)]
		public BranchConfig BranchConfig1
		{
			get
			{
				return this._BranchConfig1.Entity;
			}
			set
			{
				BranchConfig previousValue = this._BranchConfig1.Entity;
				if (((previousValue != value) 
							|| (this._BranchConfig1.HasLoadedOrAssignedValue == false)))
				{
					this.SendPropertyChanging();
					if ((previousValue != null))
					{
						this._BranchConfig1.Entity = null;
						previousValue.BranchConfig2 = null;
					}
					this._BranchConfig1.Entity = value;
					if ((value != null))
					{
						value.BranchConfig2 = this;
						this._ID = value.ID;
					}
					else
					{
						this._ID = default(int);
					}
					this.SendPropertyChanged("BranchConfig1");
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
