# eotl_gameme_uber_types

This is a TF2 sourcemod plugin I wrote for the [EOTL](https://www.endofthelinegaming.com/) community.

This plugin replaces the generic "chargedeployed" logged event with logged events for each charge type

chargedeployed_medigun<br/>
chargedeployed_kritzkrieg<br/>
chargedeployed_quickfix<br/>
chargedeployed_vaccinator<br/>

This plugin also adds the following new logged events that will trigger when a medic ubers an enemy spy.  This check is only done when a normal uberchange is deployed.

ubered_enemy_spy<br/>
ubered_by_enemy_medic<br/>

These can then be added as actions in [GameMe](https://www.gameme.com) for tracking / points.  ie:

[Spy Ubered By Enemy Medic](https://eotl.gameme.com/actioninfo/732)<br>
[Medic Ubered Enemy Spy](https://eotl.gameme.com/actioninfo/731)

In the event of an error or not being able to determine which charge type, the plugin will log a normal "chargedeployed" event.

Additionally this plugin will drop/block chargedeployed messages that occur during round setup time.  This was added to stop vaccinator medics from being able to abuse the fast charge in setup to deploy 30+ uberchanges and get a ton of GameMe points.