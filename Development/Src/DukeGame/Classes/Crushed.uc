class Crushed extends DamageType
	native
	abstract;

defaultproperties
{
	DeathString="%o was crushed by %k."
	MaleSuicide="%o was crushed."
	FemaleSuicide="%o was crushed."

    bAlwaysGibs=true
    GibPerterbation=1.0
    bLocationalHit=false
    bArmorStops=false
}