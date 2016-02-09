/**
 * This is our closure - all of our code goes inside it
 *
 * This style of closure is provided by jquery and automatically
 * waits for document.ready. It also provides us with a local
 * alias of jQuery as $.
 *
 * ES5 specifies that the first line inside our closure
 * should be 'use strict';
 */

/*jslint indent: 2 */
/*global CRM, cj, ts */

cj(function ($, ts) {
    'use strict';

    /*
     /* The code below will create multistep tabs.
     */

    // Variables
    var current_fs, next_fs, previous_fs;

    // Next button.
    $(".nextRegistration").click(function () {
        // current & next
        current_fs = $(this).closest("fieldset");
        next_fs = $(this).closest("fieldset").next();

        //activate next step on progressbar using the index of next_fs
        $("#progressbar li").eq($("fieldset.reg").index(current_fs)).removeClass("inprogress");
        $("#progressbar li").eq($("fieldset.reg").index(current_fs)).addClass("completed");
        $("#progressbar li").eq($("fieldset.reg").index(next_fs)).addClass("inprogress");

        //show the next fieldset
        next_fs.show();
        current_fs.hide();

    });

    // Previous button.
    $(".previousRegistration").click(function () {
        // current & prev
        current_fs = $(this).closest("fieldset");
        previous_fs = $(this).closest("fieldset").prev();

        //de-activate current step on progressbar
        $("#progressbar li").eq($("fieldset.reg").index(current_fs)).removeClass("inprogress");
        $("#progressbar li").eq($("fieldset.reg").index(current_fs)).removeClass("completed");

        //show the previous fieldset
        current_fs.hide();
        previous_fs.show();

    });

    // Submit button.
    $(".submit").click(function () {
        return false;
    });

}(CRM.$, CRM.ts('be.ctrl.eventsreg')));