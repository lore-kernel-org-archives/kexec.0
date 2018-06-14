Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fTOmW-0007wJ-Cl
 for kexec@lists.infradead.org; Thu, 14 Jun 2018 09:43:06 +0000
From: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>
Subject: RE: [PATCH] makedumpfile tries to output infinite ETA
Date: Thu, 14 Jun 2018 09:42:06 +0000
Message-ID: <61D4E5D821F1674CB87C99F080A210BE011B6401@BPXM01GP.gisp.nec.co.jp>
References: <CAPyQhPLctgUWK-56FL7-k_p0=68=8j_z8vE8M_0X5CkANw_pJg@mail.gmail.com>
 <CAPyQhP+juWLja=4jiCm017mw30x=XBiM5iXOF-63+xE0fY=JJA@mail.gmail.com>
In-Reply-To: <CAPyQhP+juWLja=4jiCm017mw30x=XBiM5iXOF-63+xE0fY=JJA@mail.gmail.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: Michael Breen <michael.breen@mpstor.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Keiichi Nakamura <kei-nakamura@vt.jp.nec.com>

Hi Michael,

Thank you very much for your comment.
Certainly makedumpfile can print an invalid value at the progress bar.
Well, this problem was also argued in other mails, and Petr Tesarik posted the patch.
I'll merge the v2 patch into v1.6.4.
We are debugging V1.6.4 now and planning to release it within a month.

http://lists.infradead.org/pipermail/kexec/2018-March/020139.html
http://lists.infradead.org/pipermail/kexec/2018-April/020426.html
http://lists.infradead.org/pipermail/kexec/2018-April/020436.html

Thanks,
Tachibana

> -----Original Message-----
> From: kexec [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Michael Breen
> Sent: Wednesday, June 13, 2018 5:06 PM
> To: kexec@lists.infradead.org
> Subject: Re: [PATCH] makedumpfile tries to output infinite ETA
> 
> makedumpfile-1.6.3
> 
> At the beginning of writing the dumpfile, print_progress can attempt
> to output a progress line like
> 
> Copying data                    : [  0.0 %] -  eta: -2147483648s
> 
> This happens because the ETA can evaluate as infinity when there has
> not yet been any progress: the number it is trying to output is the
> result of casting an infinite float to an int, which is undefined,
> i.e., compiler-dependent. Where it has not been possible to calculate
> a sensible ETA, no attempt should be made to output one.
> 
> More seriously in this case, combined with "eta: ", this length
> exceeds the remaining characters of the buffer into which it is
> writing (eta_msg).
> 
> This code executes even if the progress output is disabled, so there
> is no workaround not involving a code change.
> 
> (While not an immediate issue, there are also some type discrepancies,
> e.g., print_progress takes unsigned longs but is passed mdf_pfn_t
> which is unsigned long long.)
> 
> A minimal, tested fix is:
> 
> --- makedumpfile-1.6.3.org/print_info.c    2018-01-26 01:30:25.000000000 +0000
> +++ makedumpfile-1.6.3/print_info.c    2018-06-11 14:44:48.111182518 +0100
> @@ -16,6 +16,7 @@
>  #include "print_info.h"
>  #include <time.h>
>  #include <string.h>
> +#include <math.h>
> 
>  #define PROGRESS_MAXLEN        "50"
> 
> @@ -395,7 +396,8 @@ print_progress(const char *msg, unsigned
>          calc_delta(start, &delta);
>          eta = delta.tv_sec + delta.tv_usec / 1e6;
>          eta = (100 - progress) * eta / progress;
> -        eta_to_human_short(eta, eta_msg);
> +        if (isfinite(eta))
> +            eta_to_human_short(eta, eta_msg);
>      }
>      if (flag_ignore_r_char) {
>          PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%5.1f %%] %c  %16s\n",
> 
> --
> CONFIDENTIALITY
> This e-mail message and any attachments thereto, is
> intended only for use by the addressee(s) named herein and may contain
> legally privileged and/or confidential information. If you are not the
> intended recipient of this e-mail message, you are hereby notified that any
> dissemination, distribution or copying of this e-mail message, and any
> attachments thereto, is strictly prohibited. If you have received this
> e-mail message in error, please immediately notify the sender and
> permanently delete the original and any copies of this email and any prints
> thereof.
> ABSENT AN EXPRESS STATEMENT TO THE CONTRARY HEREINABOVE, THIS
> E-MAIL IS NOT INTENDED AS A SUBSTITUTE FOR A WRITING. Notwithstanding the
> Uniform Electronic Transactions Act or the applicability of any other law
> of similar substance and effect, absent an express statement to the
> contrary hereinabove, this e-mail message its contents, and any attachments
> hereto are not intended to represent an offer or acceptance to enter into a
> contract and are not otherwise intended to bind the sender, MPSTOR, or any
> other person or entity.
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
