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
     /* The code below will alter the membership registration.
     */

    // Print log if javascript file is loaded.
    console.log("ctrl-memberreg.js loaded");

}(CRM.$, CRM.ts('be.ctrl.memberreg')));