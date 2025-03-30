<?php

class OMVRpcServiceLDAP extends \OMV\Rpc\ServiceAbstract {
	/**
	 * Get the RPC service name.
	 */
	public function getName() {
		return "LDAP";
	}

	/**
	 * Initialize the RPC service.
	 */
	public function initialize() {
		$this->registerMethod("getSettings");
		$this->registerMethod("setSettings");
	}

	/**
	 * Get the LDAP configuration settings.
	 * @param params The method parameters.
	 * @param context The context of the caller.
	 * @return An JSON object containing the fields \em enable, \em host,
	 *   \em base, \em rootbinddn, \em rootbindpw, \em usersuffix,
	 *   \em groupsuffix and \em extraoptions.
	 */
	function getSettings($params, $context) {
		// Validate the RPC caller context.
		$this->validateMethodContext($context, [
			"role" => OMV_ROLE_ADMINISTRATOR
		]);
		// Get the configuration object.
		$db = \OMV\Config\Database::getInstance();
		return $db->getAssoc("conf.service.ldap");
	}

	/**
	 * Set the LDAP configuration settings.
	 * @param params An array containing the following fields:
	 *   \em enable Boolean value indicating wether the service is enabled.
	 *   \em host The FQDN or IP address of the LDAP server.
	 *   \em base The base DN.
	 *   \em rootbinddn The root bind DN.
	 *   \em rootbindpw The password used to bind to the LDAP server.
	 *   \em usersuffix The group suffix, e.g. ou=Users.
	 *   \em groupsuffix The group suffix, e.g. ou=Groups.
	 *   \em extraoptions The extra libnss.conf options.
	 * @param context The context of the caller.
	 * @return The stored configuration object.
	 */
	function setSettings($params, $context) {
		// Validate the RPC caller context.
		$this->validateMethodContext($context, [
			"role" => OMV_ROLE_ADMINISTRATOR
		]);
		// Validate the parameters of the RPC service method.
		$this->validateMethodParams($params, "rpc.ldap.setsettings");
		// Prepare the configuration object.
		$object = new \OMV\Config\ConfigObject("conf.service.ldap");
		$object->setAssoc($params);
		// Set the configuration object.
		$db = \OMV\Config\Database::getInstance();
		$db->set($object);
		// Return the configuration object.
		return $object->getAssoc();
	}
}
