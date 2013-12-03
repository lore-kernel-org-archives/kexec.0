Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VniZA-0001LB-My
 for kexec@lists.infradead.org; Tue, 03 Dec 2013 05:30:38 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v2 3/4] makedumpfile/xen: Fail immediately on every
 architecture if dump level is invalid
Date: Tue, 3 Dec 2013 05:27:03 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971C9FF0@BPXM01GP.gisp.nec.co.jp>
References: <1385993804-27721-1-git-send-email-daniel.kiper@oracle.com>
 <1385993804-27721-4-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1385993804-27721-4-git-send-email-daniel.kiper@oracle.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "david.vrabel@citrix.com" <david.vrabel@citrix.com>, Kenichi Oomichi <oomichi@mxs.nes.nec.co.jp>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On 2013/12/02 23:17:59, kexec <kexec-bounces@lists.infradead.org> wrote:
> Do not try to process Xen crash dump on every architecture if dump level
> is invalid. Fail immediately and print relevant error message.
> 
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> ---
>  makedumpfile.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 5a378d1..45f96aa 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -7637,14 +7637,14 @@ initial_xen(void)
>  		MSG("Try `makedumpfile --help' for more information.\n");
>  		return FALSE;
>  	}
> -#ifndef __x86_64__
> +
>  	if (DL_EXCLUDE_ZERO < info->max_dump_level) {
>  		MSG("Dump_level is invalid. It should be 0 or 1.\n");
>  		MSG("Commandline parameter is invalid.\n");
>  		MSG("Try `makedumpfile --help' for more information.\n");
>  		return FALSE;
>  	}
> -#endif
> +

Did you say that dump level 2 or larger are no longer effective even for x86_64 ?
I thought it works by the patch below, but I'm not sure about Xen.
So I would like to know why you sent this patch.


commit ec5b5835a113cf62a168d4a7354564a38de6b52c
Author: ken1_ohmichi <ken1_ohmichi>
Date:   Fri Oct 9 03:05:41 2009 +0000

    [v1.3.4-10] Add dump filtering on an x86_64 xen domain-0.

    This patch adds the dump filtering for excluding unnecessary pages (cache
    pages, user process data pages, and free pages) on on x86_64 xen domain-0.

    On the existing makedumpfile (v1.3.3 or former), a user could specify 0
    or 1 only as a dump_level. By this patch, he/she can specify 2 or larger
    also as a dump_level.

    Now, this feature is effective on x86_64 machine only.


Thanks
Atsushi Kumagai

>  	if (!init_xen_crash_info())
>  		return FALSE;
>  	/*
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
