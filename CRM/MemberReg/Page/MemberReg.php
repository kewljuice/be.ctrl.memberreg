<?php

require_once 'CRM/Core/Page.php';

class CRM_MemberReg_Page_MemberReg extends CRM_Core_Page {

  function run() {
    // Page title.
    CRM_Utils_System::setTitle(ts('Member Registration'));
    // Set url.
    $url = CRM_Utils_System::baseURL() . 'civicrm/ctrl/memberreg';
    $this->assign('url', $url);
    // Form submit.
    if (isset($_REQUEST['action']) && $_REQUEST['action'] == 'update') {
      // CSS.
      $css = (isset($_REQUEST['css']) ? 1 : 0);
      CRM_Core_BAO_Setting::setItem($css, 'memberreg', 'memberreg-css');
      // JS.
      $js = (isset($_REQUEST['js']) ? 1 : 0);
      CRM_Core_BAO_Setting::setItem($js, 'memberreg', 'memberreg-js');

      CRM_Core_Session::setStatus(ts('Settings changed'), ts('Saved'), 'success');
    }
    // Variables.
    $css = CRM_Core_BAO_Setting::getItem('memberreg', 'memberreg-css');
    $js = CRM_Core_BAO_Setting::getItem('memberreg', 'memberreg-js');
    // Build form.
    $form = "<form action=" . $url . " method='post'>";
    $form .= "<input type='hidden' name='action' value='update'>";
    // CSS.
    $form .= "<label><input type='checkbox' id='css' name='css' value='1' " . ($css ? " checked='checked' " : "") . ">Include extension stylesheet</label><br>";
    // JS.
    $form .= "<label><input type='checkbox' id='js' name='js' value='1' " . ($js ? " checked='checked' " : "") . ">Include extension javascript</label><br>";
    $form .= "<div class='crm-submit-buttons'>";
    $form .= "<span class='crm-button'><input class='crm-form-submit default' type='submit' value='Submit'></span>";
    $form .= "</div>";
    $form .= "</form>";
    // Assign form.
    $this->assign('form', $form);
    // Render page.
    parent::run();
  }
}
