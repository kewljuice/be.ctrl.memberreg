<?php

require_once 'CRM/Core/Page.php';

class CRM_memberreg_Page_memberreg extends CRM_Core_Page {

  function run() {
    // Page title.
    CRM_Utils_System::setTitle(ts('MemberReg'));
    // Set url.
    $url = CRM_Utils_System::baseURL() . 'civicrm/ctrl/memberreg';
    $this->assign('url', $url);
    // Form submit.
    if (isset($_REQUEST['action']) && $_REQUEST['action'] == 'update') {
      if (isset($_REQUEST['css'])) {
        CRM_Core_BAO_Setting::setItem(1, 'memberreg', 'memberreg-css');
      }
      else {
        CRM_Core_BAO_Setting::setItem(0, 'memberreg', 'memberreg-css');
      }
      if (isset($_REQUEST['js'])) {
        CRM_Core_BAO_Setting::setItem(1, 'memberreg', 'memberreg-js');
      }
      else {
        CRM_Core_BAO_Setting::setItem(0, 'memberreg', 'memberreg-js');
      }
      // Notification.
      CRM_Core_Session::setStatus(ts('Settings changed'), ts('Saved'), 'success');
    }
    // Variables.
    $css = CRM_Core_BAO_Setting::getItem('memberreg', 'memberreg-css');
    $js = CRM_Core_BAO_Setting::getItem('memberreg', 'memberreg-js');
    // Build form.
    $form = "";
    $form .= "<form action=" . $url . " method='post'>";
    $form .= "<input type='hidden' name='action' value='update'>";
    // CSS.
    $checked = "";
    if ($css) { $checked = " checked='checked' "; }
    $form .= "Stylesheet <input type='checkbox' id='css' name='css' value='1' $checked><br>";
    // JS.
    $checked = "";
    if ($js) { $checked = " checked='checked' "; }
    $form .= "Javascript <input type='checkbox' id='js' name='js' value='1' $checked><br>";
    $form .= "<div class='crm-submit-buttons'><span class='crm-button'><input class='crm-form-submit default' type='submit' value='Submit'></span></div>";
    $form .= "</form>";
    // Assign form.
    $this->assign('content', $form);
    // Render page.
    parent::run();
  }
}
