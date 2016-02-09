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

<div class="crm-contribution-page-id-{$contributionPageID} crm-block crm-contribution-thankyou-form-block">

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
        <li role="presentation" class=" disabled completed step-1"><a>Step 1: {ts domain='be.2mpact.register'}Membership{/ts}</a></li>
        <li role="presentation" class=" disabled completed step-2"><a>Step 2: {ts domain='be.2mpact.register'}Type{/ts}</a></li>
        <li role="presentation" class=" disabled completed step-3"><a>Step 3: {ts domain='be.2mpact.register'}Your Profile{/ts}</a></li>
        <li role="presentation" class=" disabled completed step-4"><a>Step 4: {ts domain='be.2mpact.register'}Payment Options{/ts}</a></li>
        <li role="presentation" class="completed step-5"><a>Step 5: {ts domain='be.2mpact.register'}Confirmation{/ts}</a></li>
      </ul>
    </div>

      {* Display "Panels" *}
      <div class="crm-section" id="formRegister">
        <fieldset class="reg step-1" name="Bevestiging">
          <div class="row">
            <div class="col-md-12">
              <div class="">
                <div class="text-left">
                  <div class="crm-group custom_pre_profile-group">
                      <!-- <div><strong>Step 5: {ts domain='be.2mpact.register'}Confirmation{/ts}</strong></div> -->
                       
                       {if $is_pay_later}
                       <div class="alert alert-info" role="alert">
                          <div class="bold pay_later_receipt-section">
                          {php}
                            print str_replace('[token_ogm]', $_SESSION["2Mpact"]["membership"]["ogm"], $this->get_template_vars('pay_later_receipt')); 
                          {/php}
                          </div>
                       </div>
                       {/if}
                 
                      <div>
                          {if $thankyou_text}
                              <div id="thankyou_text" class="crm-section thankyou_text-section">
                                  {$thankyou_text}
                              </div>
                          {/if}
                      </div>
                  </div>
									<br>
                 
                </div>
              </div>
            </div>
          </div> 
          
          <div id="crm-submit-buttons" class="crm-submit-buttons">
        		{include file="CRM/common/formButtons.tpl" location="bottom"}
    			</div>
            
        </fieldset>
    </div>
    
<div style="display:none">

    {* Show link to Tell a Friend (CRM-2153) *}
    {if $friendText}
        <div id="tell-a-friend" class="crm-section friend_link-section">
            <a href="{$friendURL}" title="{$friendText}" class="button"><span>&raquo; {$friendText}</span></a>
       </div>{if !$linkText}<br /><br />{/if}
    {/if}
    {* Add button for donor to create their own Personal Campaign page *}
    {if $linkText}
   <div class="crm-section create_pcp_link-section">
        <a href="{$linkTextUrl}" title="{$linkText}" class="button"><span>&raquo; {$linkText}</span></a>
    </div><br /><br />
    {/if}

    <div id="help">
        {* PayPal_Standard sets contribution_mode to 'notify'. We don't know if transaction is successful until we receive the IPN (payment notification) *}
        {if $is_pay_later}
      <div class="bold">{$pay_later_receipt}</div>
      {if $is_email_receipt}
                <div>
        {if $onBehalfEmail AND ($onBehalfEmail neq $email)}
      {ts 1=$email 2=$onBehalfEmail}An email confirmation with these payment instructions has been sent to %1 and to %2.{/ts}
        {else}
      {ts 1=$email}An email confirmation with these payment instructions has been sent to %1.{/ts}
        {/if}
    </div>
            {/if}
        {elseif $contributeMode EQ 'notify' OR ($contributeMode EQ 'direct' && $is_recur) }
            <div>{ts 1=$paymentProcessor.name}Your contribution has been submitted to %1 for processing. Please print this page for your records.{/ts}</div>
            {if $is_email_receipt}
                <div>
        {if $onBehalfEmail AND ($onBehalfEmail neq $email)}
      {ts 1=$email 2=$onBehalfEmail}An email receipt will be sent to %1 and to %2 once the transaction is processed successfully.{/ts}
        {else}
      {ts 1=$email}An email receipt will be sent to %1 once the transaction is processed successfully.{/ts}
        {/if}
    </div>
            {/if}
        {else}
            <div>{ts}Your transaction has been processed successfully. Please print this page for your records.{/ts}</div>
            {if $is_email_receipt}
                <div>
        {if $onBehalfEmail AND ($onBehalfEmail neq $email)}
      {ts 1=$email 2=$onBehalfEmail}An email receipt has also been sent to %1 and to %2{/ts}
        {else}
      {ts 1=$email}An email receipt has also been sent to %1{/ts}
        {/if}
    </div>
            {/if}
        {/if}
    </div>
    <div class="spacer"></div>

    {include file="CRM/Contribute/Form/Contribution/MembershipBlock.tpl" context="thankContribution"}

    {if $amount GT 0 OR $minimum_fee GT 0 OR ( $priceSetID and $lineItem ) }
    <div class="crm-group amount_display-group">
        {if !$useForMember}
        <div class="header-dark">
            {if !$membershipBlock AND $amount OR ( $priceSetID and $lineItem )}{ts}Contribution Information{/ts}{else}{ts}Membership Fee{/ts}{/if}
        </div>
  {/if}
        <div class="display-block">
         {if !$useForMember}
        {if $lineItem and $priceSetID}
          {if !$amount}{assign var="amount" value=0}{/if}
            {assign var="totalAmount" value=$amount}
            {include file="CRM/Price/Page/LineItem.tpl" context="Contribution"}
          {elseif $membership_amount}
            {$membership_name} {ts}Membership{/ts}: <strong>{$membership_amount|crmMoney}</strong><br />
            {if $amount}
              {if !$is_separate_payment}
                {ts}Contribution Amount{/ts}: <strong>{$amount|crmMoney}</strong><br />
              {else}
                {ts}Additional Contribution{/ts}: <strong>{$amount|crmMoney}</strong><br />
              {/if}
            {/if}
            <strong> -------------------------------------------</strong><br />
            {ts}Total{/ts}: <strong>{$amount+$membership_amount|crmMoney}</strong><br />
          {else}
            {ts}Amount{/ts}: <strong>{$amount|crmMoney} {if $amount_level} - {$amount_level} {/if}</strong><br />
          {/if}
    {/if}
          {if $receive_date}
            {ts}Date{/ts}: <strong>{$receive_date|crmDate}</strong><br />
          {/if}
          {if $contributeMode ne 'notify' and $is_monetary and ! $is_pay_later and $trxn_id}
            {ts}Transaction #{/ts}: {$trxn_id}<br />
          {/if}
          {if $membership_trx_id}
            {ts}Membership Transaction #{/ts}: {$membership_trx_id}
          {/if}

            {* Recurring contribution / pledge information *}
            {if $is_recur}
                {if $membershipBlock} {* Auto-renew membership confirmation *}
{crmRegion name="contribution-thankyou-recur-membership"}
                    <br />
                    <strong>{ts 1=$frequency_interval 2=$frequency_unit}This membership will be renewed automatically every %1 %2(s).{/ts}</strong>
                    <div class="description crm-auto-renew-cancel-info">({ts}You will receive an email receipt which includes information about how to cancel the auto-renewal option.{/ts})</div>
{/crmRegion}
                {else}
{crmRegion name="contribution-thankyou-recur"}
                    {if $installments}
                 <p><strong>{ts 1=$frequency_interval 2=$frequency_unit 3=$installments}This recurring contribution will be automatically processed every %1 %2(s) for a total %3 installments (including this initial contribution).{/ts}</strong></p>
                    {else}
                        <p><strong>{ts 1=$frequency_interval 2=$frequency_unit}This recurring contribution will be automatically processed every %1 %2(s).{/ts}</strong></p>
                    {/if}
                    <p>
                    {if $is_email_receipt}
                        {ts}You will receive an email receipt which includes information about how to update or cancel this recurring contribution.{/ts}
                    {/if}
                    </p>
{/crmRegion}
                {/if}
            {/if}

            {if $is_pledge}
                {if $pledge_frequency_interval GT 1}
                    <p><strong>{ts 1=$pledge_frequency_interval 2=$pledge_frequency_unit 3=$pledge_installments}I pledge to contribute this amount every %1 %2s for %3 installments.{/ts}</strong></p>
                {else}
                    <p><strong>{ts 1=$pledge_frequency_interval 2=$pledge_frequency_unit 3=$pledge_installments}I pledge to contribute this amount every %2 for %3 installments.{/ts}</strong></p>
                {/if}
                <p>
                {if $is_pay_later}
                    {ts 1=$receiptFromEmail}We will record your initial pledge payment when we receive it from you. You will be able to modify or cancel future pledge payments at any time by logging in to your account or contacting us at %1.{/ts}
                {else}
                    {ts 1=$receiptFromEmail}Your initial pledge payment has been processed. You will be able to modify or cancel future pledge payments at any time by contacting us at %1.{/ts}
                {/if}
                {if $max_reminders}
                    {ts 1=$initial_reminder_day}We will send you a payment reminder %1 days prior to each scheduled payment date. The reminder will include a link to a page where you can make your payment online.{/ts}
                {/if}
                </p>
            {/if}
        </div>
    </div>
    {/if}

    {if $honor_block_is_active}
        <div class="crm-group honor_block-group">
            <div class="header-dark">
                {$soft_credit_type}
            </div>
            <div class="display-block">
                <div class="label-left crm-section honoree_profile-section">
                    <strong>{$honorName}</strong></br>
                    {include file="CRM/UF/Form/Block.tpl" fields=$honoreeProfileFields prefix='honor'}
                </div>
            </div>
         </div>
    {/if}

    {if $customPre}
      <fieldset class="label-left crm-profile-view">
        {include file="CRM/UF/Form/Block.tpl" fields=$customPre}
      </fieldset>
    {/if}

    {if $pcpBlock}
    <div class="crm-group pcp_display-group">
        <div class="header-dark">
            {ts}Contribution Honor Roll{/ts}
        </div>
        <div class="display-block">
            {if $pcp_display_in_roll}
                {ts}List my contribution{/ts}
                {if $pcp_is_anonymous}
                    <strong>{ts}anonymously{/ts}.</strong>
                {else}
                    {ts}under the name{/ts}: <strong>{$pcp_roll_nickname}</strong><br/>
                    {if $pcp_personal_note}
                        {ts}With the personal note{/ts}: <strong>{$pcp_personal_note}</strong>
                    {else}
                     <strong>{ts}With no personal note{/ts}</strong>
                     {/if}
                {/if}
            {else}
            {ts}Don't list my contribution in the honor roll.{/ts}
            {/if}
            <br />
       </div>
    </div>
    {/if}

    {if $onbehalfProfile}
      <div class="crm-group onBehalf_display-group label-left crm-profile-view">
         {include file="CRM/UF/Form/Block.tpl" fields=$onbehalfProfile prefix='onbehalf'}
         <div class="crm-section organization_email-section">
            <div class="label">{ts}Organization Email{/ts}</div>
            <div class="content">{$onBehalfEmail}</div>
            <div class="clear"></div>
         </div>
      </div>
    {/if}

    {if ( $contributeMode ne 'notify' and ! $is_pay_later and $is_monetary and ( $amount GT 0 OR $minimum_fee GT 0 ) ) or $email }
        {if $contributeMode ne 'notify' and ! $is_pay_later and $is_monetary and ( $amount GT 0 OR $minimum_fee GT 0 ) }
          {if $billingName or $address}
            <div class="crm-group billing_name_address-group">
                <div class="header-dark">
                    {ts}Billing Name and Address{/ts}
                </div>
              <div class="crm-section no-label billing_name-section">
                <div class="content">{$billingName}</div>
                <div class="clear"></div>
              </div>
              <div class="crm-section no-label billing_address-section">
                <div class="content">{$address|nl2br}</div>
                <div class="clear"></div>
              </div>
             </div>
          {/if}
        {/if}
        {if $email}
            <div class="crm-group contributor_email-group">
                <div class="header-dark">
                    {ts}Your Email{/ts}
                </div>
                <div class="crm-section no-label contributor_email-section">
                  <div class="content">{$email}</div>
                  <div class="clear"></div>
                </div>
            </div>
        {/if}
    {/if}

    {if $contributeMode eq 'direct' and ! $is_pay_later and $is_monetary and ( $amount GT 0 OR $minimum_fee GT 0 )}
{crmRegion name="contribution-thankyou-billing-block"}
    <div class="crm-group credit_card-group">
        <div class="header-dark">
         {if $paymentProcessor.payment_type & 2}
            {ts}Direct Debit Information{/ts}
         {else}
            {ts}Credit Card Information{/ts}
         {/if}
        </div>
         {if $paymentProcessor.payment_type & 2}
            <div class="display-block">
                {ts}Account Holder{/ts}: {$account_holder}<br />
                {ts}Bank Identification Number{/ts}: {$bank_identification_number}<br />
                {ts}Bank Name{/ts}: {$bank_name}<br />
                {ts}Bank Account Number{/ts}: {$bank_account_number}<br />
            </div>
         {else}
             <div class="crm-section no-label credit_card_details-section">
                 <div class="content">{$credit_card_type}</div>
               <div class="content">{$credit_card_number}</div>
               <div class="content">{ts}Expires{/ts}: {$credit_card_exp_date|truncate:7:''|crmDate}</div>
               <div class="clear"></div>
             </div>
         {/if}
    </div>
{/crmRegion}
    {/if}

    {include file="CRM/Contribute/Form/Contribution/PremiumBlock.tpl" context="thankContribution"}

    {if $customPost}
      <fieldset class="label-left crm-profile-view">
        {include file="CRM/UF/Form/Block.tpl" fields=$customPost}
      </fieldset>
    {/if}

    <div id="thankyou_footer" class="contribution_thankyou_footer-section">
        <p>
        {$thankyou_footer}
        </p>
    </div>
    {if $isShare}
    {capture assign=contributionUrl}{crmURL p='civicrm/contribute/transact' q="$qParams" a=1 fe=1 h=1}{/capture}
    {include file="CRM/common/SocialNetwork.tpl" url=$contributionUrl title=$title pageURL=$contributionUrl}
    {/if}

</div>
</div>
