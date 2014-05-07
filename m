Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WhwTh-0000Yo-2R
 for kexec@lists.infradead.org; Wed, 07 May 2014 07:41:22 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] makedumpfile: fix bug on is_sparsemem_extreme
Date: Wed, 7 May 2014 07:38:36 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9720EDDB@BPXM01GP.gisp.nec.co.jp>
References: <1399427016-54289-1-git-send-email-sdu.liu@huawei.com>
In-Reply-To: <1399427016-54289-1-git-send-email-sdu.liu@huawei.com>
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
To: "sdu.liu@huawei.com" <sdu.liu@huawei.com>, "chaowang@redhat.com" <chaowang@redhat.com>
Cc: "wangnan0@huawei.com" <wangnan0@huawei.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "peifeiyue@huawei.com" <peifeiyue@huawei.com>

>The kernel gets the length of mem_section use this
>from: include/linux/mmzone.h:1134
>
> "#define NR_SECTION_ROOTS  DIV_ROUND_UP(NR_MEM_SECTIONS,
>					 SECTIONS_PER_ROOT)"
>
>But when we check the memory model. We forget the
>"DIV_ROUND_UP" method.
>
>So when 32-bit ARM linux is in sparsemem_extreme memory:
> with SECTION_SIZE_BIT=28 and 16 byte-size mem_section.
>The makedumpfile can not  identify the memory correctly.
>
>This patch introduce the "DIV_ROUND_UP" method in this check.

Thanks, I'll merge this patch into v1.5.7.

Atsushi Kumagai

>Signed-off-by: Liu Hua <sdu.liu@huawei.com>
>---
> makedumpfile.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/makedumpfile.c b/makedumpfile.c
>index 0b31932..16081a5 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -1599,7 +1599,7 @@ int
> is_sparsemem_extreme(void)
> {
> 	if (ARRAY_LENGTH(mem_section)
>-	     == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
>+	     == divideup(NR_MEM_SECTIONS(), _SECTIONS_PER_ROOT_EXTREME()))
> 		return TRUE;
> 	else
> 		return FALSE;
>--
>1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
