/**
 * This file is part of OpenMediaVault.
 *
 * @license   http://www.gnu.org/licenses/gpl.html GPL Version 3
 * @author    Volker Theile <volker.theile@openmediavault.org>
 * @copyright Copyright (c) 2009-2020 Volker Theile
 *
 * OpenMediaVault is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * OpenMediaVault is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with OpenMediaVault. If not, see <http://www.gnu.org/licenses/>.
 */
// require("js/omv/WorkspaceManager.js")
// require("js/omv/workspace/form/Panel.js")

/**
 * @class OMV.module.admin.privilege.ldap.Settings
 * @derived OMV.workspace.form.Panel
 */
Ext.define("OMV.module.admin.privilege.ldap.Settings", {
	extend: "OMV.workspace.form.Panel",

	rpcService: "LDAP",
	rpcGetMethod: "getSettings",
	rpcSetMethod: "setSettings",

	getFormItems: function() {
		return [{
			xtype: "fieldset",
			title: _("General settings"),
			fieldDefaults: {
				labelSeparator: ""
			},
			items: [{
				xtype: "checkbox",
				name: "enable",
				fieldLabel: _("Enable"),
				checked: false
			},{
				xtype: "textfield",
				name: "host",
				fieldLabel: _("Host"),
				allowBlank: false,
				vtype: "domainnameIP",
				plugins: [{
					ptype: "fieldinfo",
					text: _("The FQDN or IP address of the server.")
				}],
				value: 'ldap.example.net'
			},{
				xtype: "numberfield",
				name: "port",
				fieldLabel: "Port",
				vtype: "port",
				minValue: 1,
				maxValue: 65535,
				allowDecimals: false,
				allowBlank: false,
				plugins: [{
					ptype: "fieldinfo",
					text: _("Specifies the port to connect to. Default 389 StartTLS")
				}],
				value: 389
			},{
				xtype: "checkbox",
				name: "enablessl",
				fieldLabel: _("Enable explicit SSL instead of StartTLS"),
				checked: false,
				boxLabel: _("Enable SSL secure connection.")
			},{
				xtype: "textfield",
				name: "base",
				fieldLabel: _("Base DN"),
				allowBlank: false,
				plugins: [{
					ptype: "fieldinfo",
					text: _("Specifies the base distinguished name (DN) to use as search base, e.g. 'dc=example,dc=net'.")
				}],
				value: 'dc=example,dc=net'
			},{
				xtype: "textfield",
				name: "rootbinddn",
				fieldLabel: _("Root Bind DN"),
				allowBlank: false,
				plugins: [{
					ptype: "fieldinfo",
					text: _("Specifies the distinguished name (DN) with which to bind to the directory server for lookups, e.g. 'cn=manager,dc=example,dc=net'.")
				}]
			},{
				xtype: "passwordfield",
				name: "rootbindpw",
				fieldLabel: _("Password"),
				allowBlank: true,
				plugins: [{
					ptype: "fieldinfo",
					text: _("Specifies the credentials with which to bind.")
				}],
				value: 'cn=manager,dc=example,dc=net'
			},{
				xtype: "textfield",
				name: "usersuffix",
				fieldLabel: _("Users suffix"),
				allowBlank: true,
				plugins: [{
					ptype: "fieldinfo",
					text: _("Specifies the user suffix, e.g. 'ou=Users'."),
				}],
				value: "ou=Users"
			},{
				xtype: "textfield",
				name: "groupsuffix",
				fieldLabel: _("Groups suffix"),
				allowBlank: true,
				plugins: [{
					ptype: "fieldinfo",
					text: _("Specifies the group suffix, e.g. 'ou=Groups'."),
				}],
				value: "ou=Groups"
			},{
				xtype: "textfield",
				name: "machinessuffix",
				fieldLabel: _("Machine suffix"),
				allowBlank: true,
				plugins: [{
					ptype: "fieldinfo",
					text: _("Specifies the machines (serveurs) suffix, e.g. 'ou=Computers'."),
				}],
				value: "ou=Computers"
			},{
				xtype: "textfield",
				name: "idmapsuffix",
				fieldLabel: _("IdMap suffix"),
				allowBlank: true,
				plugins: [{
					ptype: "fieldinfo",
					text: _("Specifies the idmap suffix, e.g. 'ou=idmap'."),
				}],
				value: "ou=idmap"
			},{
				xtype: "checkbox",
				name: "enablepam",
				fieldLabel: _("Enable PAM"),
				checked: true,
				boxLabel: _("Use LDAP for authentication system-wide along with other authentication sources.")
			},{
				xtype: "textarea",
				name: "extraoptions",
				fieldLabel: _("Extra options"),
				allowBlank: true,
				plugins: [{
					ptype: "fieldinfo",
					text: _("Please check the <a href='https://wiki.debian.org/fr/LDAP/NSS' target='_blank'>manual page</a> for more details.")
				}]
			},{
				xtype: "textarea",
				name: "extraclientoptions",
				fieldLabel: _("Extra client options"),
				allowBlank: true,
				plugins: [{
					ptype: "fieldinfo",
					text: _("Please check the <a href='https://manpages.debian.org/bullseye/libnss-ldap/libnss-ldap.conf.5.en.html' target='_blank'>manual page</a> for more details. Ex: tls_cert *** tls_key *** tls_cacertfile ***")
				}]
			}]
		}];
	}
});

OMV.WorkspaceManager.registerPanel({
	id: "settings",
	path: "/privilege/ldap",
	text: _("Settings"),
	position: 10,
	className: "OMV.module.admin.privilege.ldap.Settings"
});
