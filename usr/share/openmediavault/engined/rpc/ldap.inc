<?php

class OMVRpcServiceLDAP extends \OMV\Rpc\ServiceAbstract {
	public function getName() {
		return "LDAP";
	}

	public function initialize() {
		$this->registerMethod("getSettings");
		$this->registerMethod("setSettings");
	}

	/**
	 * Get the LDAP configuration settings.
	 * @param params The method parameters.
	 * @param context The context of the caller.
	 * @return An JSON object containing the fields required
	 *	to configure LDAP.
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
	 * @param params An array containing all of the fields and values.
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
