Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1clWZw-00065b-9W
 for kexec@lists.infradead.org; Wed, 08 Mar 2017 08:04:14 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH] [PATCH] Fix typo in the ERRMSG of function
 show_mem_usage. "kernel" instead of "kenrel".
Date: Wed, 8 Mar 2017 07:53:18 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701EAC439@BPXM01GP.gisp.nec.co.jp>
References: <1488903948-13185-1-git-send-email-eric.desrochers@canonical.com>
In-Reply-To: <1488903948-13185-1-git-send-email-eric.desrochers@canonical.com>
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
To: Eric Desrochers <eric.desrochers@canonical.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Eric,

Thanks, I'll merge this fix into v1.6.2.

P.S. I fixed other typos on this occasion.

Regards,
Atsushi Kumagai

>---
> makedumpfile.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/makedumpfile.c b/makedumpfile.c
>index e3be1ab..18cf30f 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -10938,7 +10938,7 @@ int show_mem_usage(void)
> 	struct cycle cycle = {0};
>
> 	if (!is_crashkernel_mem_reserved()) {
>-		ERRMSG("No memory is reserved for crashkenrel!\n");
>+		ERRMSG("No memory is reserved for crashkernel!\n");
> 		return FALSE;
> 	}
>
>--
>2.7.4
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
