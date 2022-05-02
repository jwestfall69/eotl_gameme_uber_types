# eotl_gameme_uber_types

This is a TF2 sourcemod plugin.

This plugin replaces the generic "chargedeployed" logged event with logged events for each charge type

chargedeployed_medigun<br/>
chargedeployed_kritzkrieg<br/>
chargedeployed_quickfix<br/>
chargedeployed_vaccinator<br/>

These can then be added as actions in gameme for tracking / points.

In the event of an error or not being able to determine which charge type, the plugin will log a normal "chargedeployed" event.

Additionally this plugin will drop/block chargedeployed messages that occur during round setup time.  This was added to stop vaccinator medics from being able to abuse the fast charge in setup to deploy 30+ uberchanges and get points for them.