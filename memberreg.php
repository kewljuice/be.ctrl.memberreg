<?php

require_once 'memberreg.civix.php';

/**
 * Implements hook_civicrm_config().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_config
 */
function memberreg_civicrm_config(&$config) {
  _memberreg_civix_civicrm_config($config);
}

/**
 * Implements hook_civicrm_xmlMenu().
 *
 * @param $files array(string)
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_xmlMenu
 */
function memberreg_civicrm_xmlMenu(&$files) {
  _memberreg_civix_civicrm_xmlMenu($files);
}

/**
 * Implements hook_civicrm_install().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_install
 */
function memberreg_civicrm_install() {
  _memberreg_civix_civicrm_install();
}

/**
 * Implements hook_civicrm_uninstall().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_uninstall
 */
function memberreg_civicrm_uninstall() {
  _memberreg_civix_civicrm_uninstall();
}

/**
 * Implements hook_civicrm_enable().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_enable
 */
function memberreg_civicrm_enable() {
  // Assign default parameters.
  CRM_Core_BAO_Setting::setItem(0, 'memberreg', 'memberreg-css');
  CRM_Core_BAO_Setting::setItem(0, 'memberreg', 'memberreg-js');
  // Continue.
  _memberreg_civix_civicrm_enable();
}

/**
 * Implements hook_civicrm_disable().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_disable
 */
function memberreg_civicrm_disable() {
  _memberreg_civix_civicrm_disable();
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
function memberreg_civicrm_upgrade($op, CRM_Queue_Queue $queue = NULL) {
  return _memberreg_civix_civicrm_upgrade($op, $queue);
}

/**
 * Implements hook_civicrm_managed().
 *
 * Generate a list of entities to create/deactivate/delete when this module
 * is installed, disabled, uninstalled.
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_managed
 */
function memberreg_civicrm_managed(&$entities) {
  _memberreg_civix_civicrm_managed($entities);
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
function memberreg_civicrm_caseTypes(&$caseTypes) {
  _memberreg_civix_civicrm_caseTypes($caseTypes);
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
function memberreg_civicrm_angularModules(&$angularModules) {
  _memberreg_civix_civicrm_angularModules($angularModules);
}

/**
 * Implements hook_civicrm_alterSettingsFolders().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_alterSettingsFolders
 */
function memberreg_civicrm_alterSettingsFolders(&$metaDataFolders = NULL) {
  _memberreg_civix_civicrm_alterSettingsFolders($metaDataFolders);
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
function memberreg_civicrm_buildForm($formName, &$form) {
  /*
   * Include JS & CSS
   * https://forum.civicrm.org/index.php?topic=27216.0
   */
  if (strpos($formName, 'CRM_Contribute_Form_Contribution_') !== FALSE) {
    // include CSS file.
    if (CRM_Core_BAO_Setting::getItem('memberreg', 'memberreg-css')) {
      CRM_Core_Resources::singleton()
        ->addStyleFile('be.ctrl.memberreg', 'css/ctrl-memberreg.css');
    }
    // include JS file.
    if (CRM_Core_BAO_Setting::getItem('memberreg', 'memberreg-js')) {
      CRM_Core_Resources::singleton()
        ->addScriptFile('be.ctrl.memberreg', 'js/ctrl-memberreg.js');
    }
  }
}

/**
 * CiviCRM hook navigationMenu
 */
function memberreg_civicrm_navigationMenu(&$params) {
  //  Get the maximum key of $params.
  $nextKey = (max(array_keys($params)));
  // Check for Administer navID.
  $AdministerKey = '';
  foreach ($params as $k => $v) {
    if ($v['attributes']['name'] == 'Administer') {
      $AdministerKey = $k;
    }
  }
  // Check for Parent navID.
  foreach ($params[$AdministerKey]['child'] as $k => $v) {
    if ($v['attributes']['name'] == 'CTRL') {
      $parentKey = $v['attributes']['navID'];
    }
  }
  // If Parent navID doesn't exist create.
  if (!isset($parentKey)) {
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
        'navID' => $nextKey,
        'active' => 1,
      ],
      'child' => NULL,
    ];
    // Add parent to Administer
    $params[$AdministerKey]['child'][$nextKey] = $parent;
    $parentKey = $nextKey;
    $nextKey++;
  }
  // Create child(s) array
  $child = [
    'attributes' => [
      'label' => 'MemberReg',
      'name' => 'ctrl_memberreg',
      'url' => 'civicrm/ctrl/memberreg',
      'permission' => 'access CiviCRM',
      'operator' => NULL,
      'separator' => 0,
      'parentID' => $parentKey,
      'navID' => $nextKey,
      'active' => 1,
    ],
    'child' => NULL,
  ];
  // Add child(s) for this extension
  $params[$AdministerKey]['child'][$parentKey]['child'][$nextKey] = $child;
}