Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WadZe-0003ra-83
 for kexec@lists.infradead.org; Thu, 17 Apr 2014 04:05:19 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] eppic: makedumpfile fails to recognise between global
Date: Thu, 17 Apr 2014 04:00:24 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE972048CA@BPXM01GP.gisp.nec.co.jp>
References: <20140415050055.15599.6255.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20140415050055.15599.6255.stgit@aruna-ThinkPad-T420>
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
To: "aruna@linux.vnet.ibm.com" <aruna@linux.vnet.ibm.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>    symbol and structure of the same name

This must be a part of the subject :-)

>    Fix the eppic script to reflect the type
>
>    Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>

Thanks, I'll merge this patch into v1.5.6.

Atsushi Kumagai

>---
> eppic_scripts/udp_sk_buf.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/eppic_scripts/udp_sk_buf.c b/eppic_scripts/udp_sk_buf.c
>index 0fa1325..ca8c77b 100644
>--- a/eppic_scripts/udp_sk_buf.c
>+++ b/eppic_scripts/udp_sk_buf.c
>@@ -30,7 +30,7 @@ udp()
> 	struct udp_table *table;
> 	struct sock_common *off = 0;
>
>-	table = &udp_table;
>+	table = (struct udp_table *)&udp_table;
>
> 	for (i = 0; i < table->mask; i++) {
> 		struct hlist_nulls_node *pos;
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
