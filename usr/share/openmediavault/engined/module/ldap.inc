<?php

class LDAP extends \OMV\Engine\Module\ServiceAbstract
  implements \OMV\Engine\Notify\IListener {
	public function getName() {
		return "ldap";
	}

	function bindListeners(\OMV\Engine\Notify\Dispatcher $dispatcher) {
		$dispatcher->addListener(
		  OMV_NOTIFY_MODIFY,
		  "org.openmediavault.conf.service.ldap",
		  [ $this, "setDirty" ]);
		$moduleMngr = \OMV\Engine\Module\Manager::getInstance();
		$dispatcher->addListener(
		  OMV_NOTIFY_MODIFY,
		  "org.openmediavault.conf.service.ldap",
		  [ $moduleMngr->getModule("samba"), "setDirty" ]);
		$dispatcher->addListener(
		  OMV_NOTIFY_MODIFY,
		  "org.openmediavault.conf.service.ldap",
		  [ $moduleMngr->getModule("pam"), "setDirty" ]);
    }
}
