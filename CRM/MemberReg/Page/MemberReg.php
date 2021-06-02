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
      Civi::settings()->set('memberreg-css', $css);
      // JS.
      $js = (isset($_REQUEST['js']) ? 1 : 0);
      Civi::settings()->set('memberreg-js', $css);
      CRM_Core_Session::setStatus(ts('Settings changed'), ts('Saved'), 'success');
    }
    // Variables.
    $css = Civi::settings()->get('memberreg-css');
    $js = Civi::settings()->get('memberreg-js');
    // Build form.
    $form = "<form action=" . $url . " method='post'>";
    $form .= "<input type='hidden' name='action' value='update'>";
    // CSS.
    $form .= "<label><input type='checkbox' id='css' name='css' value='1' " . ($css ? " checked='checked' " : "") . ">Include extension stylesheet</label><br>";
    // JS.
    $form .= "<label><input type='checkbox' id='js' name='js' value='1' " . ($js ? " checked='checked' " : "") . ">Include extension javascript</label><br>";
    $form .= "<div class='crm-submit-buttons'>";
    $form .= "<input class='crm-form-submit default' type='submit' value='Submit'>";
    $form .= "</div>";
    $form .= "</form>";
    // Assign form.
    $this->assign('form', $form);
    // Render page.
    parent::run();
  }
}
