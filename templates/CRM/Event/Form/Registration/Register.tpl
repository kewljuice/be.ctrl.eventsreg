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

{* Callback snippet: Load payment processor *}

{if $snippet}
    {include file="CRM/Core/BillingBlock.tpl" context="front-end"}
    <div id="paypalExpress">
        {* Put PayPal Express button after customPost block since it's the submit button in this case. *}
        {if $paymentProcessor.payment_processor_type EQ 'PayPal_Express'}
            {assign var=expressButtonName value='_qf_Register_upload_express'}
            <fieldset class="crm-group payPalExpress-group">
                <legend>{ts domain='be.ctrl.eventsreg'}Checkout with PayPal{/ts}</legend>
                <div class="description">{ts domain='be.ctrl.eventsreg'}Click the PayPal button to continue.{/ts}</div>
                <div>{$form.$expressButtonName.html} <span
                            style="font-size:11px; font-family: Arial, Verdana;">{ts domain='be.ctrl.eventsreg'}Checkout securely. Pay without sharing your financial information.{/ts} </span>
                </div>
            </fieldset>
        {/if}
    </div>
{else}

    {if $action & 1024}
        {include file="CRM/Event/Form/Registration/PreviewHeader.tpl"}
    {/if}

    {include file="CRM/common/TrackingFields.tpl"}
    {capture assign='reqMark'}<span class="marker"  title="{ts domain='be.ctrl.eventsreg'}This field is required.{/ts}">
            *</span>{/capture}
    <div class="crm-event-id-{$event.id} crm-block crm-event-register-form-block">

        {* moved to tpl since need to show only for primary participant page *}
        {if $requireApprovalMsg || $waitlistMsg}
            <div id="id-waitlist-approval-msg" class="messages status no-popup">
                {if $requireApprovalMsg}
                    <div id="id-req-approval-msg">{$requireApprovalMsg}</div>
                {/if}
                {if $waitlistMsg}
                    <div id="id-waitlist-msg">{$waitlistMsg}</div>
                {/if}
            </div>
        {/if}

        {if $contact_id}
            <div class="messages status no-popup" id="crm-event-register-different">
                {ts 1=$display_name domain='be.ctrl.eventsreg'}Welcome %1{/ts}. (<a
                        href="{crmURL p='civicrm/event/register' q="cid=0&reset=1&id=`$event.id`"}"
                        title="{ts domain='be.ctrl.eventsreg'}Click here to register a different person for this event.{/ts}">{ts 1=$display_name domain='be.ctrl.eventsreg'}Not %1, or want to register a different person{/ts}</a>?)
            </div>
        {/if}
        {if $event.intro_text}
            <div id="intro_text" class="crm-section intro_text-section">
                <p>{$event.intro_text}</p>
            </div>
        {/if}

        {include file="CRM/common/cidzero.tpl"}
        {if $pcpSupporterText}
            <div class="crm-section pcpSupporterText-section">
                <div class="content">{$pcpSupporterText}</div>
            </div>
        {/if}

        {if $form.additional_participants.html}
            <div class="crm-section additional_participants-section" id="noOfparticipants">
                <div class="label">{$form.additional_participants.label}</div>
                <div class="content">
                    {$form.additional_participants.html}{if $contact_id || $contact_id == NULL} &nbsp; ({ts domain='be.ctrl.eventsreg'}including yourself{/ts}){/if}
                    <br/>
          <span class="description"> {ts domain='be.ctrl.eventsreg'}Fill in your registration information on this page. If you are registering additional people, you will be able to enter their registration information after you complete this page and click Continue.{/ts} 
          </span>
                </div>
                <div class="clear"></div>
            </div>
        {/if}

        {* Display "Index" *}
        <div class="crm-section">
            <!-- progressbar -->
            <ul id="progressbar" class="nav nav-tabs">

                <li role="presentation" class="inprogress step-1">
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

                <li role="presentation" class="disabled step-5">
                    <a>{ts domain='be.ctrl.eventsreg'}Confirmation{/ts}</a>
                </li>
            </ul>
        </div>

        <div class="crm-section" id="formRegister">

            <!-- fieldset -->
            <fieldset class="reg step-1" name="Gegevens">
                <div class="well">
                    <div class="text-left">
                        <div id="">
                            <!-- This is step 1 -->
                            {* User account registration option. Displays if enabled for one of the profiles on this page. *}
                            {include file="CRM/common/CMSUser.tpl"}
                            {* Display "Top of page" profile immediately after the introductory text *}
                            { include file="CRM/UF/Form/Block.tpl" fields=$customPre }
                        </div>
                    </div>
                </div>
                <div style="text-align:right">
                    <input type="button" name="next" class="nextRegistration action-button"
                           value="{ts domain='be.ctrl.eventsreg'}Next step{/ts} >"/>
                </div>
            </fieldset>

            <!-- fieldset -->
            {if $priceSet}
                <fieldset class="reg step-2" name="Event">
                    <div class="row">
                        <div class="col-md-11">

                            <div class="well">
                                <div class="text-left">
                                    <!-- This is step 2 -->
                                    {* Display "Priceset" *}
                                    {if $priceSet}
                                        {if ! $quickConfig}<div id="priceset" class="crm-group priceset-group">
                                            <span>{$event.fee_label}</span>
                                        {/if}
                                        {include file="CRM/Price/Form/PriceSet.tpl" extends="Event"}
                                        {include file="CRM/Price/Form/ParticipantCount.tpl"}
                                        {if ! $quickConfig}</div>{/if}
                                    {/if}
                                    <fieldset id="customHolder" style=""></fieldset>
                                </div>
                            </div>

                        </div>
                        <div class="col-md-1">
                            <span class="label label-default" id="price-2"></span>
                        </div>
                    </div>
                    <div style="text-align:right">
                        <input type="button" name="previous" class="previousRegistration action-button"
                               value="< {ts domain='be.ctrl.eventsreg'}Previous step{/ts}"/>
                        <input type="button" name="next" class="nextRegistration action-button"
                               value="{ts domain='be.ctrl.eventsreg'}Next step{/ts} >"/>
                    </div>
                </fieldset>
            {/if}

            <!-- fieldset -->
            <fieldset class="reg step-3" name="Profiel">

                <div class="well">
                    <div class="text-left">
                        <!-- This is step 3 -->
                        <div id="customProfileContainer">
                            {* Display "Bottom of page" profile *}
                            {include file="CRM/UF/Form/Block.tpl" fields=$customPost}
                        </div>
                    </div>
                </div>

                <div style="text-align:right">
                    <input type="button" name="previous" class="previousRegistration action-button"
                           value="< {ts domain='be.ctrl.eventsreg'}Previous step{/ts}"/>
                    {if $form.payment_processor.label}
                        <input type="button" name="next" class="nextRegistration action-button"
                               value="{ts domain='be.ctrl.eventsreg'}Next step{/ts} >"/>
                    {/if}
                    {if !$form.payment_processor.label}
                        <div id="crm-submit-buttons" class="crm-submit-buttons">
                            {include file="CRM/common/formButtons.tpl" location="bottom"}
                        </div>
                    {/if}
                </div>

            </fieldset>

            <!-- fieldset -->
            {if $form.payment_processor.label}
                <fieldset class="reg step-4" name="Betaalopties">
                    <div class="row">
                        <div class="col-md-11">

                            <div class="well">
                                <div class="text-left">
                                    <!-- This is step 4 -->
                                    {if $form.payment_processor.label}
                                        <legend>{ts domain='be.ctrl.eventsreg'}Payment Options{/ts}</legend>
                                        <!-- <div id="billing-payment-choice" class="crm-section payment_processor-section"> -->
                                        <div>
                                            <div class="label">{$form.payment_processor.label}</div>
                                            <div class="content">{$form.payment_processor.html}</div>
                                            <div class="clear"></div>
                                        </div>
                                    {/if}
                                    {* Display "Billing" *}
                                    <div id="billing-payment-block" style="margin:30px;padding:30px;">
                                        {* If we have a payment processor, load it - otherwise it happens via ajax *}
                                        {if $ppType}
                                            {include file="CRM/Event/Form/Registration/Register.tpl" snippet=4}
                                        {/if}
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="col-md-1">
                            <span class="label label-default" id="price-4">    </span>
                        </div>
                    </div>
                    <div style="text-align:right">
                        <input type="button" name="previous" class="previousRegistration action-button"
                               value="< {ts domain='be.ctrl.eventsreg'}Previous step{/ts}"/>
                        {* SUBMIT *}
                        <div id="crm-submit-buttons" class="crm-submit-buttons">
                            {include file="CRM/common/formButtons.tpl" location="bottom"}
                        </div>
                    </div>
                </fieldset>
            {/if}
        </div>

        {if $pcp && $is_honor_roll }
            <fieldset class="crm-group pcp-group">
                <div class="crm-section pcp-section">
                    <div class="crm-section display_in_roll-section">
                        <div class="content">
                            {$form.pcp_display_in_roll.html} &nbsp;
                            {$form.pcp_display_in_roll.label}
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div id="nameID" class="crm-section is_anonymous-section">
                        <div class="content">
                            {$form.pcp_is_anonymous.html}
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div id="nickID" class="crm-section pcp_roll_nickname-section">
                        <div class="label">{$form.pcp_roll_nickname.label}</div>
                        <div class="content">{$form.pcp_roll_nickname.html}
                            <div
                                    class="description">{ts domain='be.ctrl.eventsreg'}Enter the name you want listed with this contribution. You can use a nick name like 'The Jones Family' or 'Sarah and Sam'.{/ts}</div>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div id="personalNoteID" class="crm-section pcp_personal_note-section">
                        <div class="label">{$form.pcp_personal_note.label}</div>
                        <div class="content">
                            {$form.pcp_personal_note.html}
                            <div class="description">{ts domain='be.ctrl.eventsreg'}Enter a message to accompany this contribution.{/ts}</div>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
            </fieldset>
        {/if}

        {include file="CRM/common/paymentBlock.tpl"}

        {if $isCaptcha}
            {include file='CRM/common/ReCAPTCHA.tpl'}
        {/if}

        {if $event.footer_text}
            <div id="footer_text" class="crm-section event_footer_text-section">
                <p>{$event.footer_text}</p>
            </div>
        {/if}
    </div>
    <script type="text/javascript">
        {literal}
        function toggleConfirmButton() {
            var payPalExpressId = "{/literal}{$payPalExpressId}{literal}";
            var elementObj = cj('input[name="payment_processor"]');
            if (elementObj.attr('type') == 'hidden') {
                var processorTypeId = elementObj.val();
            }
            else {
                var processorTypeId = elementObj.filter(':checked').val();
            }

            if (payPalExpressId != 0 && payPalExpressId == processorTypeId) {
                cj("#crm-submit-buttons").hide();
            }
            else {
                cj("#crm-submit-buttons").show();
            }
        }

        cj('input[name="payment_processor"]').change(function () {
            toggleConfirmButton();
        });

        cj("#additional_participants").change(function () {
            skipPaymentMethod();
        });

        CRM.$(function ($) {
            toggleConfirmButton();
            skipPaymentMethod();
        });

        // Hides billing and payment options block - but only if a price set is used.
        // Called from display() in Calculate.tpl, depends on display() having been called.
        function skipPaymentMethod() {
            // If we're in quick-config price set, we do not have the pricevalue hidden element, so just return.
            if (cj('#pricevalue').length == 0) {
                return;
            }
            // CRM-15433 Remove currency symbol, decimal separator so we can check for zero numeric total regardless of localization.
            currentTotal = cj('#pricevalue').text().replace(/[^\/\d]/g, '');
            var isMultiple = '{/literal}{$event.is_multiple_registrations}{literal}';

            var flag = 1;
            var payment_options = cj(".payment_options-group");
            var payment_processor = cj("div.payment_processor-section");
            var payment_information = cj("div#payment_information");

            // Do not hide billing and payment blocks if user is registering additional participants, since we do not know total owing.
            if (isMultiple && cj("#additional_participants").val() && currentTotal == 0) {
                flag = 0;
            }

            if (currentTotal == 0 && flag) {
                payment_options.hide();
                payment_processor.hide();
                payment_information.hide();
                // also unset selected payment methods
                cj('input[name="payment_processor"]').removeProp('checked');
            }
            else {
                payment_options.show();
                payment_processor.show();
                payment_information.show();
            }
        }

        {/literal}
    </script>
{/if}

{literal}
<script type="text/javascript">
    {/literal}{if $pcp && $is_honor_roll }pcpAnonymous();
    {/if}{literal}

    function allowParticipant() {
        {/literal}{if $allowGroupOnWaitlist}{literal}
        var additionalParticipants = cj('#additional_participants').val();
        var pricesetParticipantCount = 0;
        {/literal}{if $priceSet}{literal}
        pricesetParticipantCount = pPartiCount;
        {/literal}{/if}{literal}

        allowGroupOnWaitlist(additionalParticipants, pricesetParticipantCount);
        {/literal}{/if}{literal}
    }

    {/literal}{if ($bypassPayment) and $paymentProcessor.payment_processor_type EQ 'PayPal_Express'}
    {literal}
    showHidePayPalExpressOption();
    {/literal}{/if}{literal}

    function showHidePayPalExpressOption() {
        if (( cj("#bypass_payment").val() == 1 )) {
            cj("#crm-submit-buttons").show();
            cj("#paypalExpress").hide();
        }
        else {
            cj("#paypalExpress").show();
            cj("#crm-submit-buttons").hide();
        }
    }

    {/literal}{if ($bypassPayment and $showHidePaymentInformation)}{literal}
    showHidePaymentInfo();
    {/literal} {/if}{literal}

    function showHidePaymentInfo() {
        if (( cj("#bypass_payment").val() == 1 )) {
            cj('#billing-payment-block').hide();
        }
        else {
            cj('#billing-payment-block').show();
        }
    }

    {/literal}{if $allowGroupOnWaitlist}{literal}
    allowGroupOnWaitlist(0, 0);
    {/literal}{/if}{literal}

    function allowGroupOnWaitlist(additionalParticipants, pricesetParticipantCount) {
        {/literal}{if $isAdditionalParticipants}{literal}
        if (!additionalParticipants) {
            additionalParticipants = cj('#additional_participants').val();
        }
        {/literal}{else}{literal}
        additionalParticipants = 0;
        {/literal}{/if}{literal}

        additionalParticipants = parseInt(additionalParticipants);
        if (!additionalParticipants) {
            additionalParticipants = 0;
        }

        var availableRegistrations = {/literal}'{$availableRegistrations}'{literal};
        var totalParticipants = parseInt(additionalParticipants) + 1;

        if (pricesetParticipantCount) {
            // add priceset count if any
            totalParticipants += parseInt(pricesetParticipantCount) - 1;
        }
        var isrequireApproval = {/literal}'{$requireApprovalMsg}'{literal};

        if (totalParticipants > availableRegistrations) {
            cj("#id-waitlist-msg").show();
            cj("#id-waitlist-approval-msg").show();

            //set the value for hidden bypass payment.
            cj("#bypass_payment").val(1);
        }
        else {
            if (isrequireApproval) {
                cj("#id-waitlist-approval-msg").show();
                cj("#id-waitlist-msg").hide();
            }
            else {
                cj("#id-waitlist-approval-msg").hide();
            }
            //reset value since user don't want or not eligible for waitlist
            cj("#bypass_payment").val(0);
        }

        //now call showhide payment info.
        {/literal}
        {if ($bypassPayment) and $paymentProcessor.payment_processor_type EQ 'PayPal_Express'}{literal}
        showHidePayPalExpressOption();
        {/literal}{/if}
        {literal}

        {/literal}{if ($bypassPayment) and $showHidePaymentInformation}{literal}
        showHidePaymentInfo();
        {/literal}{/if}{literal}
    }

    {/literal}{if $pcp && $is_honor_roll }{literal}
    function pcpAnonymous() {
        // clear nickname field if anonymous is true
        if (document.getElementsByName("pcp_is_anonymous")[1].checked) {
            document.getElementById('pcp_roll_nickname').value = '';
        }
        if (!document.getElementsByName("pcp_display_in_roll")[0].checked) {
            cj('#nickID, #nameID, #personalNoteID').hide();
        }
        else {
            if (document.getElementsByName("pcp_is_anonymous")[0].checked) {
                cj('#nameID, #nickID, #personalNoteID').show();
            }
            else {
                cj('#nameID').show();
                cj('#nickID, #personalNoteID').hide();
            }
        }
    }
    {/literal}{/if}{literal}

</script>
{/literal}