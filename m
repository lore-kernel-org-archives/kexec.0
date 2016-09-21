Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bmb6L-0006gR-Mf
 for kexec@lists.infradead.org; Wed, 21 Sep 2016 06:33:50 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH v3 1/3] open_dump_bitmap: open bitmap file in non-cyclic
 case
Date: Wed, 21 Sep 2016 06:29:34 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E6A9FB@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE9701E6A4CF@BPXM01GP.gisp.nec.co.jp>
 <20160920103329.3023-1-mwilck@suse.de>
In-Reply-To: <20160920103329.3023-1-mwilck@suse.de>
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

>The logic of set_bitmap() requires that a bitmap fd exists in the
>non-cyclic case.
>
>Signed-off-by: Martin Wilck <mwilck@suse.de>

I'll merge this version into v1.6.1, thanks for your work.

Regards,
Atsushi Kumagai

>---
> makedumpfile.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/makedumpfile.c b/makedumpfile.c
>index d168dfd..6164468 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -1365,7 +1365,7 @@ open_dump_bitmap(void)
>
> 	/* Unnecessary to open */
> 	if (!info->working_dir && !info->flag_reassemble && !info->flag_refiltering
>-	    && !info->flag_sadump && !info->flag_mem_usage)
>+	    && !info->flag_sadump && !info->flag_mem_usage && info->flag_cyclic)
> 		return TRUE;
>
> 	tmpname = getenv("TMPDIR");
>--
>2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
