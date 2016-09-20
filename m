Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bmHcw-0002Jk-8K
 for kexec@lists.infradead.org; Tue, 20 Sep 2016 09:46:11 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH v3 3/3] close_dump_bitmap: simplify logic
Date: Tue, 20 Sep 2016 09:43:28 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E6A4CF@BPXM01GP.gisp.nec.co.jp>
References: <20160914101723.19003-3-mwilck@suse.de>
 <20160914115009.20220-1-mwilck@suse.de>
In-Reply-To: <20160914115009.20220-1-mwilck@suse.de>
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
To: Martin Wilck <mwilck@suse.de>
Cc: "ptesarik@suse.cz" <ptesarik@suse.cz>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Martin,

>The boolean expression replicates the logic of open_dump_bitmap().
>It's simpler and less error-prone to simply check if fd_bitmap is
>valid.
>
>(I forgot to apply the very change that Petr had asked for in V2 of
>this patch. I'm very sorry. Please apply V3).

This version looks good, so could you add your Signed-off-by ?

Thanks,
Atsushi Kumagai

>---
> makedumpfile.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/makedumpfile.c b/makedumpfile.c
>index 30e1fa8..0f5be7f 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -8615,8 +8615,7 @@ close_dump_file(void)
> void
> close_dump_bitmap(void)
> {
>-	if (!info->working_dir && !info->flag_reassemble && !info->flag_refiltering
>-	    && !info->flag_sadump && !info->flag_mem_usage)
>+	if (info->fd_bitmap < 0)
> 		return;
>
> 	if (close(info->fd_bitmap) < 0)
>--
>2.9.3

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
