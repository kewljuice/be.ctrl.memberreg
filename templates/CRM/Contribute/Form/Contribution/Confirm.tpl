{*
 +--------------------------------------------------------------------+
 | CiviCRM version 4.5                                                |
 +--------------------------------------------------------------------+
 | Copyright CiviCRM LLC (c) 2004-2014                                |
 +--------------------------------------------------------------------+
 | This file is a part of CiviCRM.                                    |
 |                                                                    |
 | CiviCRM is free software; you can copy, modify, and distribute it  |
 | under the terms of the GNU Affero General Public License           |
 | Version 3, 19 November 2007 and the CiviCRM Licensing Exception.   |
 |                                                                    |
 | CiviCRM is distributed in the hope that it will be useful, but     |
 | WITHOUT ANY WARRANTY; without even the implied warranty of         |
 | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.               |
 | See the GNU Affero General Public License for more details.        |
 |                                                                    |
 | You should have received a copy of the GNU Affero General Public   |
 | License and the CiviCRM Licensing Exception along                  |
 | with this program; if not, contact CiviCRM LLC                     |
 | at info[AT]civicrm[DOT]org. If you have questions about the        |
 | GNU Affero General Public License or the licensing of CiviCRM,     |
 | see the CiviCRM license FAQ at http://civicrm.org/licensing        |
 +--------------------------------------------------------------------+
*}
{if $action & 1024}
    {include file="CRM/Contribute/Form/Contribution/PreviewHeader.tpl"}
{/if}

{include file="CRM/common/TrackingFields.tpl"}

<div class="crm-contribution-page-id-{$contributionPageID} crm-block crm-contribution-confirm-form-block">
    <div id="help">
        <p>{ts}Please verify the information below carefully. Click <strong>Go Back</strong> if you need to make changes.{/ts}
            {if $contributeMode EQ 'notify' and ! $is_pay_later}
                {if $paymentProcessor.payment_processor_type EQ 'Google_Checkout'}
                    {ts}Click the <strong>Google Checkout</strong> button to checkout to Google, where you will select your payment method and complete the contribution.{/ts}
                {else}
                    {ts 1=$paymentProcessor.name 2=$button}Click the <strong>%2</strong> button to go to %1, where you will select your payment method and complete the contribution.{/ts}
                {/if}
            {elseif ! $is_monetary or $amount LE 0.0 or $is_pay_later}
                {ts 1=$button}To complete this transaction, click the <strong>%1</strong> button below.{/ts}
            {else}
                {ts 1=$button}To complete your contribution, click the <strong>%1</strong> button below.{/ts}
            {/if}
        </p>
    </div>
    
  {* Display "Intro" *}
  <div class="crm-section intro" style="margin-bottom:20px">
  	<h2 class="intro-title">Membership</h2>
    <div class="intro-span">
    
      <div id="intro_text" class="crm-section intro_text-section">
        {$intro_text}
      </div>
      {include file="CRM/common/cidzero.tpl"}
      {if $islifetime or $ispricelifetime }
      <div id="help">{ts domain='be.2mpact.register'}You have a current Lifetime Membership which does not need to be renewed.{/ts}</div>
      {/if}
       
    </div>
  </div>
    
    {* Display "Index" *}
    <div class="crm-section">
      <!-- progressbar -->
      <ul id="progressbar" class="nav nav-tabs">
        <!-- <li role="presentation" class="active disabled step-1"><a>Login</a></li> -->
        <!-- <li role="presentation" class="disabled disabled step-2"><a>Gegevens</a></li> -->
        <li role="presentation" class="completed disabled step-1"><a>Step 1: {ts domain='be.2mpact.register'}Membership{/ts}</a></li>
        <li role="presentation" class="completed disabled step-2"><a>Step 2: {ts domain='be.2mpact.register'}Type{/ts}</a></li>
        <li role="presentation" class="completed disabled step-3"><a>Step 3: {ts domain='be.2mpact.register'}Your Profile{/ts}</a></li>
        <li role="presentation" class="completed disabled step-4"><a>Step 4: {ts domain='be.2mpact.register'}Payment Options{/ts}</a></li>
        <li role="presentation" class="inprogress step-5"><a>Step 5: {ts domain='be.2mpact.register'}Confirmation{/ts}</a></li>
      </ul>
    </div>
    
      {* Display "Panels" *}
      <div class="clearfix crm-section confirmation" id="formRegister">
      
        <fieldset class="reg step-1" name="Bevestiging">
          <div class="row">
            <div class="col-md-12">
              <div class="well">
                <div class="text-left">
                  <div class="crm-group custom_pre_profile-group">
                      <!-- <div><strong>Step 5: {ts domain='be.2mpact.register'}Confirmation{/ts}</strong></div> -->
                  </div>

                  {if $contributeMode NEQ 'notify' and $is_monetary and ( $amount GT 0 OR $minimum_fee GT 0 ) } {* In 'notify mode, contributor is taken to processor payment forms next *}
                  <div class="messages status continue_instructions-section">
                      <p>
                      {if $is_pay_later OR $amount LE 0.0}
                          {ts 1=$button}Your transaction will not be completed until you click the <strong>%1</strong> button. Please click the button one time only.{/ts}
                      {else}
                          {ts 1=$button}Your contribution will not be completed until you click the <strong>%1</strong> button. Please click the button one time only.{/ts}
                      {/if}
                      </p>
                  </div>
                  {/if}
                  
                  <div id="crm-submit-buttons" class="crm-submit-buttons">
                    {include file="CRM/common/formButtons.tpl"}
                  </div>
                  
                  <!--{include file="CRM/Contribute/Form/Contribution/MembershipBlock.tpl" context="confirmContribution" }-->
                
                  {if $amount GT 0 OR $minimum_fee GT 0 OR ( $priceSetID and $lineItem ) }
                    <div class="crm-group amount_display-group">
                      {if !$useForMember}
                      <div class="header-dark">
                          {if !$membershipBlock AND $amount OR ( $priceSetID and $lineItem ) }{ts}Contribution Amount{/ts}{else}{ts}Membership Fee{/ts} {/if}
                      </div>
                      {/if}
                      <div class="display-block">
                          {if !$useForMember}
                            {if $lineItem and $priceSetID}
                              {if !$amount}{assign var="amount" value=0}{/if}
                              {assign var="totalAmount" value=$amount}
                              {include file="CRM/Price/Page/LineItem.tpl" context="Contribution"}
                            {elseif $is_separate_payment }
                              {if $amount AND $minimum_fee}
                                  {$membership_name|ucwords}: <strong>{$minimum_fee|crmMoney}</strong><br />
                                  Gift: <strong>{$amount|crmMoney}</strong><br />
                                  <strong> -------------------------------------------</strong><br />
                                  {ts}Total{/ts}: <strong>{$amount+$minimum_fee|crmMoney}</strong><br />
                              {elseif $amount }
                                  {ts}Amount{/ts}: <strong>{$amount|crmMoney} {if $amount_level } - {$amount_level} {/if}</strong>
                              {else}
                                  {$membership_name|ucfirst} : <strong>{$minimum_fee|crmMoney}</strong>
                              {/if}
                            {else}
                              {if $amount }
                                  {ts}Total Amount{/ts}: <strong>{$amount|crmMoney} {if $amount_level } - {$amount_level} {/if}</strong>
                              {else}
                                  {$membership_name|ucfirst} : <strong>{$minimum_fee|crmMoney}</strong>
                              {/if}
                            {/if}
                              {/if}
                      
                          {if $is_recur}
                              {if $membershipBlock} {* Auto-renew membership confirmation *}
                      {crmRegion name="contribution-confirm-recur-membership"}
                                  <br />
                                  <p><strong>{ts 1=$frequency_interval 2=$frequency_unit}I want this membership to be renewed automatically every %1 %2(s).{/ts}</strong></p>
                                  <div class="description crm-auto-renew-cancel-info">({ts}Your initial membership fee will be processed once you complete the confirmation step. You will be able to cancel the auto-renewal option by visiting the web page link that will be included in your receipt.{/ts})</div>
                      {/crmRegion}
                              {else}
                      {crmRegion name="contribution-confirm-recur"}
                                  {if $installments}
                                      <p><strong>{ts 1=$frequency_interval 2=$frequency_unit 3=$installments}I want to contribute this amount every %1 %2(s) for %3 installments.{/ts}</strong></p>
                                  {else}
                                      <p><strong>{ts 1=$frequency_interval 2=$frequency_unit}I want to contribute this amount every %1 %2(s).{/ts}</strong></p>
                                  {/if}
                                  <p>{ts}Your initial contribution will be processed once you complete the confirmation step. You will be able to cancel the recurring contribution by visiting the web page link that will be included in your receipt.{/ts}</p>
                      {/crmRegion}
                              {/if}
                          {/if}
                      
                          {if $is_pledge }
                              {if $pledge_frequency_interval GT 1}
                                  <p><strong>{ts 1=$pledge_frequency_interval 2=$pledge_frequency_unit 3=$pledge_installments}I pledge to contribute this amount every %1 %2s for %3 installments.{/ts}</strong></p>
                              {else}
                                  <p><strong>{ts 1=$pledge_frequency_interval 2=$pledge_frequency_unit 3=$pledge_installments}I pledge to contribute this amount every %2 for %3 installments.{/ts}</strong></p>
                              {/if}
                              {if $is_pay_later}
                                  <p>{ts 1=$receiptFromEmail 2=$button}Click &quot;%2&quot; below to register your pledge. You will be able to modify or cancel future pledge payments at any time by logging in to your account or contacting us at %1.{/ts}</p>
                              {else}
                                  <p>{ts 1=$receiptFromEmail 2=$button}Your initial pledge payment will be processed when you click &quot;%2&quot; below. You will be able to modify or cancel future pledge payments at any time by logging in to your account or contacting us at %1.{/ts}
                                  </p>
                              {/if}
                          {/if}
                      </div>
                    </div>
                  {/if}               

                  {if $customPre}
                    <fieldset class="label-left crm-profile-view col-md-12">
                        {include file="CRM/UF/Form/Block.tpl" fields=$customPre}
                    </fieldset>
                  {/if}
                      
                  {if $email}
                    <div class="crm-group contributor_email-group col-md-12">
                      <div class="crm-section label-left contributor_email-section">
                        <div class="label"><label for="email">{ts}Email{/ts}</label></div>
                        <div class="content">{$email}</div>
                        <div class="clear"></div>
                      </div>
                    </div>
                  {/if}

                  {if $customPost}
                    <div class="label-left crm-profile-view col-md-12">
                      <div class="well">
                        {include file="CRM/UF/Form/Block.tpl" fields=$customPost}
                      </div>
                    </div>
                  {/if}
  
                  {* buttons were here *}
                </div>
              </div>
            </div>
          </div> 
        </fieldset>
    </div>
</div>