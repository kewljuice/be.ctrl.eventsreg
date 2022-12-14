<?php

require_once 'eventsreg.civix.php';

/**
 * Implements hook_civicrm_config().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_config
 */
function eventsreg_civicrm_config(&$config) {
  _eventsreg_civix_civicrm_config($config);
}

/**
 * Implements hook_civicrm_xmlMenu().
 *
 * @param $files array(string)
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_xmlMenu
 */
function eventsreg_civicrm_xmlMenu(&$files) {
  _eventsreg_civix_civicrm_xmlMenu($files);
}

/**
 * Implements hook_civicrm_install().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_install
 */
function eventsreg_civicrm_install() {
  _eventsreg_civix_civicrm_install();
}

/**
 * Implements hook_civicrm_uninstall().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_uninstall
 */
function eventsreg_civicrm_uninstall() {
  _eventsreg_civix_civicrm_uninstall();
}

/**
 * Implements hook_civicrm_enable().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_enable
 */
function eventsreg_civicrm_enable() {
  // Assign default parameters.
  Civi::settings()->set('eventsreg-css', 0);
  Civi::settings()->set('eventsreg-js', 0);
  _eventsreg_civix_civicrm_enable();
}

/**
 * Implements hook_civicrm_disable().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_disable
 */
function eventsreg_civicrm_disable() {
  _eventsreg_civix_civicrm_disable();
}

/**
 * Implements hook_civicrm_upgrade().
 *
 * @param $op string, the type of operation being performed; 'check' or
 *   'enqueue'
 * @param $queue CRM_Queue_Queue, (for 'enqueue') the modifiable list of
 *   pending up upgrade tasks
 *
 * @return mixed
 *   Based on op. for 'check', returns array(boolean) (TRUE if upgrades are
 *   pending) for 'enqueue', returns void
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_upgrade
 */
function eventsreg_civicrm_upgrade($op, CRM_Queue_Queue $queue = NULL) {
  return _eventsreg_civix_civicrm_upgrade($op, $queue);
}

/**
 * Implements hook_civicrm_managed().
 *
 * Generate a list of entities to create/deactivate/delete when this module
 * is installed, disabled, uninstalled.
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_managed
 */
function eventsreg_civicrm_managed(&$entities) {
  _eventsreg_civix_civicrm_managed($entities);
}

/**
 * Implements hook_civicrm_caseTypes().
 *
 * Generate a list of case-types
 *
 * Note: This hook only runs in CiviCRM 4.4+.
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_caseTypes
 */
function eventsreg_civicrm_caseTypes(&$caseTypes) {
  _eventsreg_civix_civicrm_caseTypes($caseTypes);
}

/**
 * Implements hook_civicrm_angularModules().
 *
 * Generate a list of Angular modules.
 *
 * Note: This hook only runs in CiviCRM 4.5+. It may
 * use features only available in v4.6+.
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_caseTypes
 */
function eventsreg_civicrm_angularModules(&$angularModules) {
  _eventsreg_civix_civicrm_angularModules($angularModules);
}

/**
 * Implements hook_civicrm_alterSettingsFolders().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_alterSettingsFolders
 */
function eventsreg_civicrm_alterSettingsFolders(&$metaDataFolders = NULL) {
  _eventsreg_civix_civicrm_alterSettingsFolders($metaDataFolders);
}

/**
 * CiviCRM hook buildForm
 */
function eventsreg_civicrm_buildForm($formName, &$form) {
  /*
   * Include JS & CSS
   * https://forum.civicrm.org/index.php?topic=27216.0
   */
  if (strpos($formName, 'CRM_Event_Form_Registration_') !== FALSE) {
    // include CSS file.
    if (Civi::settings()->get('eventsreg-css')) {
      CRM_Core_Resources::singleton()
        ->addStyleFile('be.ctrl.eventsreg', 'css/ctrl-eventsreg.css');
    }
    // include JS file.
    if (Civi::settings()->get('eventsreg-js')) {
      CRM_Core_Resources::singleton()
        ->addScriptFile('be.ctrl.eventsreg', 'js/ctrl-eventsreg.js');
    }
  }
}

/**
 * Implements hook_civicrm_navigationMenu().
 *
 * @param array $params
 */
function eventsreg_civicrm_navigationMenu(&$params) {
  // Check for Administer navID.
  $AdministerKey = '';
  foreach ($params as $k => $v) {
    if ($v['attributes']['name'] == 'Administer') {
      $AdministerKey = $k;
    }
  }
  // Check for Parent navID.
  $parentKey = '';
  foreach ($params[$AdministerKey]['child'] as $k => $v) {
    if (
      isset($v['attributes']) &&
      isset($v['attributes']['label']) &&
      $v['attributes']['label'] === 'CTRL'
    ) {
      $parentKey = $k;
      // Check if the key is the string CTRL in which case we should rebuild it to have an integer key.
      if ($parentKey === 'CTRL') {
        $params[$AdministerKey]['child'][] = $params[$AdministerKey]['child']['CTRL'];
        unset($params[$AdministerKey]['child']['CTRL']);
        eventsreg_civicrm_navigationMenu($params);
      }
      break;
    }
  }
  // If Parent navID doesn't exist create.
  if ($parentKey === '') {
    // Create parent array
    $parent = [
      'attributes' => [
        'label' => 'CTRL',
        'name' => 'CTRL',
        'url' => NULL,
        'permission' => 'access CiviCRM',
        'operator' => NULL,
        'separator' => 0,
        'parentID' => $AdministerKey,
        'active' => 1,
      ],
      'child' => NULL,
    ];
    // Add parent to Administer
    $params[$AdministerKey]['child'][] = $parent;
    $created = array_key_last($params[$AdministerKey]['child']);
    $params[$AdministerKey]['child'][$created]['attributes']['navID'] = $created;
    $parentKey = $created;
  }
  // Create child(s) array
  $child = [
    'attributes' => [
      'label' => 'EventsReg',
      'name' => 'ctrl_eventsreg',
      'url' => 'civicrm/ctrl/eventsreg',
      'permission' => 'access CiviCRM',
      'operator' => NULL,
      'separator' => 0,
      'parentID' => $parentKey,
      'active' => 1,
    ],
    'child' => NULL,
  ];
  // Add child(s) for this extension
  $params[$AdministerKey]['child'][$parentKey]['child'][] = $child;
  $created = array_key_last($params[$AdministerKey]['child'][$parentKey]['child']);
  $params[$AdministerKey]['child'][$parentKey]['child'][$created]['attributes']['navID'] = $created;
}
