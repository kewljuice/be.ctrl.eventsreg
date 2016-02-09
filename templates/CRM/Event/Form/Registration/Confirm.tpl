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
    {include file="CRM/Event/Form/Registration/PreviewHeader.tpl"}
{/if}

{include file="CRM/common/TrackingFields.tpl"}

<div class="crm-event-id-{$event.id} crm-block crm-event-confirm-form-block">

    <!-- 
    <div id="crm-submit-buttons" class="crm-submit-buttons">
      {include file="CRM/common/formButtons.tpl" location="top"}
    </div>
    -->

    {if $isOnWaitlist}
        <div class="help">
            {ts domain='be.ctrl.eventsreg'}Please verify the information below.{/ts} <span
                    class="bold">{ts domain='be.ctrl.eventsreg'}Then click 'Continue' to be added to the WAIT LIST for this event{/ts}</span>. {ts domain='be.ctrl.eventsreg'}If space becomes available you will receive an email with a link to a web page where you can complete your registration.{/ts}
        </div>
    {elseif $isRequireApproval}
        <div class="help">
            {ts domain='be.ctrl.eventsreg'}Please verify the information below. Then click 'Continue' to submit your registration.{/ts}
            <span class="bold">{ts domain='be.ctrl.eventsreg'}Once approved, you will receive an email with a link to a web page where you can complete the registration process.{/ts}</span>
        </div>
    {else}
        <div id="help">
            {ts domain='be.ctrl.eventsreg'}Please verify the information below. Click the Go Back button below if you need to make changes.{/ts}
            {if $contributeMode EQ 'notify' and !$is_pay_later and ! $isAmountzero }
                {if $paymentProcessor.payment_processor_type EQ 'Google_Checkout'}
                    {ts 1=$paymentProcessor.name domain='be.ctrl.eventsreg'}Click the %1 button to checkout to Google, where you will select your payment method and complete the registration.{/ts}
                {else}
                    {ts 1=$paymentProcessor.name domain='be.ctrl.eventsreg'}Click the Continue button to checkout to %1, where you will select your payment method and complete the registration.{/ts}
                {/if }
            {else}
                {ts domain='be.ctrl.eventsreg'}Otherwise, click the Continue button below to complete your registration.{/ts}
            {/if}
        </div>
    {/if}

    {if $event.confirm_text}
        <div id="intro_text" class="crm-section event_confirm_text-section">
            <p>{$event.confirm_text}</p>
        </div>
    {else if $event.intro_text}
        <div id="intro_text" class="crm-section intro_text-section">
            <p>{$event.intro_text}</p>
        </div>
    {/if}

    {* Display "Index" *}
    <div class="crm-section">
        <!-- progressbar -->
        <ul id="progressbar" class="nav nav-tabs">
            <li role="presentation" class="disabled step-1">
                <a>{ts domain='be.ctrl.eventsreg'}Data{/ts}</a>
            </li>
            <li role="presentation" class="disabled step-2">
                <a>{ts domain='be.ctrl.eventsreg'}Event{/ts}</a>
            </li>
            <li role="presentation" class="disabled step-3">
                <a>{ts domain='be.ctrl.eventsreg'}Profile{/ts}</a>
            </li>
            {if $form.payment_processor.label}
                <li role="presentation" class="disabled step-4">
                    <a>{ts domain='be.ctrl.eventsreg'}Payment Options{/ts}</a>
                </li>
            {/if}
            <li role="presentation" class="inprogress step-5">
                <a>{ts domain='be.ctrl.eventsreg'}Confirmation{/ts}</a>
            </li>
        </ul>
    </div>

    <!-- PAY LATER MESSAGE -->
    {if $isOnWaitlist}

    {elseif $isRequireApproval}

    {else}
        {if $is_pay_later and !$isAmountzero}
            <div class="pay_later_receipt">{$pay_later_receipt}</div>
        {/if}
    {/if}

    {* Display "Panels" *}
    <div class="crm-section" id="formRegister">

        <fieldset class="reg step-5" name="Bevestig">
            <div class="well">
                <div class="text-left">

                    <div class="crm-group event_info-group">
                        <div class="header-dark">
                            {ts domain='be.ctrl.eventsreg'}Event Information{/ts}
                        </div>
                        <div class="display-block">
                            {include file="CRM/Event/Form/Registration/EventInfoBlock.tpl"}
                        </div>
                    </div>

                    {if $pcpBlock}
                        <div class="crm-group pcp_display-group">
                            <div class="header-dark">
                                {ts domain='be.ctrl.eventsreg'}Contribution Honor Roll{/ts}
                            </div>
                            <div class="display-block">
                                {if $pcp_display_in_roll}
                                    {ts domain='be.ctrl.eventsreg'}List my contribution{/ts}
                                    {if $pcp_is_anonymous}
                                        <strong>{ts domain='be.ctrl.eventsreg'}anonymously{/ts}.</strong>
                                    {else}
                                        {ts domain='be.ctrl.eventsreg'}under the name{/ts}:
                                        <strong>{$pcp_roll_nickname}</strong>
                                        <br/>
                                        {if $pcp_personal_note}
                                            {ts domain='be.ctrl.eventsreg'}With the personal note{/ts}:
                                            <strong>{$pcp_personal_note}</strong>
                                        {else}
                                            <strong>{ts domain='be.ctrl.eventsreg'}With no personal note{/ts}</strong>
                                        {/if}
                                    {/if}
                                {else}
                                    {ts domain='be.ctrl.eventsreg'}Don't list my contribution in the honor roll.{/ts}
                                {/if}
                                <br/>
                            </div>
                        </div>
                    {/if}

                    {if $paidEvent}
                        <div class="crm-group event_fees-group">

                            {if $lineItem}
                                {include file="CRM/Price/Page/LineItem.tpl" context="Event"}
                            {elseif $amounts || $amount == 0}
                                <div class="crm-section no-label amount-item-section">
                                    {foreach from= $amounts item=amount key=level}
                                        <!--
                                          <div class="content">
                                              {$amount.amount|crmMoney}&nbsp;&nbsp;{$amount.label}
                                          </div>
                                        -->
                                        <div class="clear"></div>
                                    {/foreach}
                                </div>
                                {if $totalAmount}
                                    <div class="crm-section no-label total-amount-section">
                                        <div class="content bold">{ts domain='be.ctrl.eventsreg'}Total Amount{/ts}:&nbsp;&nbsp;{$totalAmount|crmMoney}</div>
                                        <div class="clear"></div>
                                    </div>
                                {/if}
                                {if $hookDiscount.message}
                                    <div class="crm-section hookDiscount-section">
                                        <em>({$hookDiscount.message})</em>
                                    </div>
                                {/if}
                            {/if}

                        </div>
                    {/if}

                    {if $event.participant_role neq 'Attendee' and $defaultRole}
                        <!--
                        <div class="crm-group participant_role-group">
                            <div class="header-dark">
                                {ts domain='be.ctrl.eventsreg'}Participant Role{/ts}
                            </div>
                            <div class="crm-section no-label participant_role-section">
                                <div class="content">
                                    {$event.participant_role}
                                </div>
                              <div class="clear"></div>
                            </div>
                        </div>
                        -->
                    {/if}


                    {*include file="CRM/Event/Form/Registration/DisplayProfile.tpl"*}
                    {if $contributeMode ne 'notify' and !$is_pay_later and $paidEvent and !$isAmountzero and !$isOnWaitlist and !$isRequireApproval}
                        <div class="crm-group billing_name_address-group">
                            <div class="header-dark">
                                {ts domain='be.ctrl.eventsreg'}Billing Name and Address{/ts}
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

                    {if $contributeMode eq 'direct' and ! $is_pay_later and !$isAmountzero and !$isOnWaitlist and !$isRequireApproval}
                        <div class="crm-group credit_card-group">
                            <div class="header-dark">
                                {ts domain='be.ctrl.eventsreg'}Credit Card Information{/ts}
                            </div>
                            <div class="crm-section no-label credit_card_details-section">
                                <div class="content">{$credit_card_type}</div>
                                <div class="content">{$credit_card_number}</div>
                                <div class="content">{ts domain='be.ctrl.eventsreg'}Expires{/ts}
                                    : {$credit_card_exp_date|truncate:7:''|crmDate}</div>
                                <div class="clear"></div>
                            </div>
                        </div>
                    {/if}

                    {if $contributeMode NEQ 'notify'} {* In 'notify mode, contributor is taken to processor payment forms next *}
                        <div class="messages status section continue_message-section">
                            <p>
                                {ts domain='be.ctrl.eventsreg'}Your registration will not be submitted until you click the Continue button. Please click the button one time only. If you need to change any details, click the Go Back button below to return to the previous screen.{/ts}
                            </p>
                        </div>
                    {/if}

                    {if $paymentProcessor.payment_processor_type EQ 'Google_Checkout' and $paidEvent and !$is_pay_later and ! $isAmountzero and !$isOnWaitlist and !$isRequireApproval}
                        <fieldset>
                            <legend>{ts domain='be.ctrl.eventsreg'}Checkout with Google{/ts}</legend>
                            <div class="crm-section google_checkout-section">
                                <table class="form-layout-compressed">
                                    <tr>
                                        <td class="description">{ts domain='be.ctrl.eventsreg'}Click the Google Checkout button to continue.{/ts}</td>
                                    </tr>
                                    <tr>
                                        <td>{$form._qf_Confirm_next_checkout.html} <span
                                                    style="font-size:11px; font-family: Arial, Verdana;">{ts domain='be.ctrl.eventsreg'}Checkout securely. Pay without sharing your financial information.{/ts} </span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </fieldset>
                    {/if}


                </div>
            </div>

            <div style="text-align:right">
                <div id="crm-submit-buttons" class="crm-submit-buttons">
                    {include file="CRM/common/formButtons.tpl" location="bottom"}
                </div>
            </div>

            {if $event.confirm_footer_text}
                <div id="footer_text" class="crm-section event_confirm_footer-section">
                    <p>{$event.confirm_footer_text}</p>
                </div>
            {elseif $event.footer_text}
                <div id="footer_text" class="crm-section event_footer_text-section">
                    <p>{$event.footer_text}</p>
                </div>
            {/if}

        </fieldset>
    </div>

</div>
{include file="CRM/common/showHide.tpl"}
