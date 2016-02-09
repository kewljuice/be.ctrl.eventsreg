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
 * @param $op string, the type of operation being performed; 'check' or 'enqueue'
 * @param $queue CRM_Queue_Queue, (for 'enqueue') the modifiable list of pending up upgrade tasks
 *
 * @return mixed
 *   Based on op. for 'check', returns array(boolean) (TRUE if upgrades are pending)
 *                for 'enqueue', returns void
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
 *
 * http://wiki.civicrm.org/confluence/display/CRMDOC/Hook+Reference
 * http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_post
 * http://wiki.civicrm.org/confluence/display/CRMDOC/Form+hooks
 * http://civicrm.stackexchange.com/questions/213/can-i-find-the-target-contact-id-in-hook-civicrm-buildform
 * http://www.smarty.net/forums/viewtopic.php?t=11435
 * http://www.jackrabbithanna.com/articles/easy-jquery-modificaiton-civicrm-forms
 * https://www.prestashop.com/forums/topic/218203-solved-how-to-view-module-smarty-variables
 * https://forum.civicrm.org/index.php?topic=31686.0
 *
 */
function eventsreg_civicrm_buildForm($formName, &$form) {
  /*
   * Include JS & CSS
   * https://forum.civicrm.org/index.php?topic=27216.0
   */
  if (strpos($formName, 'CRM_Event_Form_Registration_') !== FALSE) {
    CRM_Core_Resources::singleton()
      // include JS file
      ->addScriptFile('be.ctrl.eventsreg', 'js/ctrl-multistep.js')
      // include CSS file
      ->addStyleFile('be.ctrl.eventsreg', 'css/ctrl-eventsreg.css')
      ->addStyleFile('be.ctrl.eventsreg', 'css/font-awesome.min.css');
  }
  /*
   * Define Drupal node linked to event-id
   */

  // TODO

}
