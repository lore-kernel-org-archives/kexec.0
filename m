Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fT0nm-0001FB-Ad
 for kexec@lists.infradead.org; Wed, 13 Jun 2018 08:06:59 +0000
Received: by mail-qk0-x241.google.com with SMTP id c198-v6so971850qkg.12
 for <kexec@lists.infradead.org>; Wed, 13 Jun 2018 01:06:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPyQhPLctgUWK-56FL7-k_p0=68=8j_z8vE8M_0X5CkANw_pJg@mail.gmail.com>
References: <CAPyQhPLctgUWK-56FL7-k_p0=68=8j_z8vE8M_0X5CkANw_pJg@mail.gmail.com>
From: Michael Breen <michael.breen@mpstor.com>
Date: Wed, 13 Jun 2018 09:06:14 +0100
Message-ID: <CAPyQhP+juWLja=4jiCm017mw30x=XBiM5iXOF-63+xE0fY=JJA@mail.gmail.com>
Subject: Re: [PATCH] makedumpfile tries to output infinite ETA
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

makedumpfile-1.6.3

At the beginning of writing the dumpfile, print_progress can attempt
to output a progress line like

Copying data                    : [  0.0 %] -  eta: -2147483648s

This happens because the ETA can evaluate as infinity when there has
not yet been any progress: the number it is trying to output is the
result of casting an infinite float to an int, which is undefined,
i.e., compiler-dependent. Where it has not been possible to calculate
a sensible ETA, no attempt should be made to output one.

More seriously in this case, combined with "eta: ", this length
exceeds the remaining characters of the buffer into which it is
writing (eta_msg).

This code executes even if the progress output is disabled, so there
is no workaround not involving a code change.

(While not an immediate issue, there are also some type discrepancies,
e.g., print_progress takes unsigned longs but is passed mdf_pfn_t
which is unsigned long long.)

A minimal, tested fix is:

--- makedumpfile-1.6.3.org/print_info.c    2018-01-26 01:30:25.000000000 +0000
+++ makedumpfile-1.6.3/print_info.c    2018-06-11 14:44:48.111182518 +0100
@@ -16,6 +16,7 @@
 #include "print_info.h"
 #include <time.h>
 #include <string.h>
+#include <math.h>

 #define PROGRESS_MAXLEN        "50"

@@ -395,7 +396,8 @@ print_progress(const char *msg, unsigned
         calc_delta(start, &delta);
         eta = delta.tv_sec + delta.tv_usec / 1e6;
         eta = (100 - progress) * eta / progress;
-        eta_to_human_short(eta, eta_msg);
+        if (isfinite(eta))
+            eta_to_human_short(eta, eta_msg);
     }
     if (flag_ignore_r_char) {
         PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%5.1f %%] %c  %16s\n",

-- 
CONFIDENTIALITY
This e-mail message and any attachments thereto, is 
intended only for use by the addressee(s) named herein and may contain 
legally privileged and/or confidential information. If you are not the 
intended recipient of this e-mail message, you are hereby notified that any 
dissemination, distribution or copying of this e-mail message, and any 
attachments thereto, is strictly prohibited. If you have received this 
e-mail message in error, please immediately notify the sender and 
permanently delete the original and any copies of this email and any prints 
thereof.
ABSENT AN EXPRESS STATEMENT TO THE CONTRARY HEREINABOVE, THIS 
E-MAIL IS NOT INTENDED AS A SUBSTITUTE FOR A WRITING. Notwithstanding the 
Uniform Electronic Transactions Act or the applicability of any other law 
of similar substance and effect, absent an express statement to the 
contrary hereinabove, this e-mail message its contents, and any attachments 
hereto are not intended to represent an offer or acceptance to enter into a 
contract and are not otherwise intended to bind the sender, MPSTOR, or any 
other person or entity.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
