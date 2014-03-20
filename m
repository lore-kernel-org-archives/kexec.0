Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WQTDg-0000fD-4V
 for kexec@lists.infradead.org; Thu, 20 Mar 2014 03:00:38 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] Allow --dump-dmesg for Xen vmcores
Date: Thu, 20 Mar 2014 02:58:49 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971F80E1@BPXM01GP.gisp.nec.co.jp>
References: <20140319093321.27CF36013F@nathan.suse.cz>
In-Reply-To: <20140319093321.27CF36013F@nathan.suse.cz>
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
To: "ptesarik@suse.cz" <ptesarik@suse.cz>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Petr,

>If a Xen dump is detected, makedumpfile checks that the target format is
>ELF. The real reason is that compressed formats are not possible with Xen.
>
>But there's a third way initial_xen() can be called: with --dump-dmesg.
>This variant works in fact, so it's enough to extend the check so that
>it covers this case.
>
>Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

Good fix, I'll merge this patch into v1.5.6.


Thanks
Atsushi Kumagai

>---
> makedumpfile.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/makedumpfile.c b/makedumpfile.c
>index 0bd8b55..ea29239 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -7660,7 +7660,7 @@ initial_xen(void)
> 	MSG("Xen is not supported on powerpc.\n");
> 	return FALSE;
> #else
>-	if(!info->flag_elf_dumpfile) {
>+	if(!info->flag_elf_dumpfile && !info->flag_dmesg) {
> 		MSG("Specify '-E' option for Xen.\n");
> 		MSG("Commandline parameter is invalid.\n");
> 		MSG("Try `makedumpfile --help' for more information.\n");
>--
>1.8.4.5
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
