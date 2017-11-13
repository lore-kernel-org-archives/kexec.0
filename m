Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eEAsC-0001wX-BW
 for kexec@lists.infradead.org; Mon, 13 Nov 2017 09:17:46 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [makedumpfile PATCH] ppc64: update hash page table geometry
Date: Mon, 13 Nov 2017 09:14:29 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701F248FB@BPXM01GP.gisp.nec.co.jp>
References: <151033402186.13486.3228487082738293986.stgit@hbathini.in.ibm.com>
In-Reply-To: <151033402186.13486.3228487082738293986.stgit@hbathini.in.ibm.com>
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
To: Hari Bathini <hbathini@linux.vnet.ibm.com>, Kexec-ml <kexec@lists.infradead.org>
Cc: Keiichirou Suzuki <kei-suzuki@xr.jp.nec.com>, Ankit Kumar <ankit@linux.vnet.ibm.com>

Hello Hari,

>Starting with kernel 4.12, BOOK3S hash page table geometry is updated
>to accommodate larger virtual address range. Update here accordingly.
>
>Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>

Thanks, I'll merge this patch into v1.6.3.

Regards
Atsushi Kumagai

>---
> arch/ppc64.c   |   12 +++++++++---
> makedumpfile.h |    3 +++
> 2 files changed, 12 insertions(+), 3 deletions(-)
>
>diff --git a/arch/ppc64.c b/arch/ppc64.c
>index 2f5a0da..8bdbcc5 100644
>--- a/arch/ppc64.c
>+++ b/arch/ppc64.c
>@@ -245,10 +245,16 @@ ppc64_vmalloc_init(void)
>
> 		} else if (info->kernel_version >= KERNEL_VERSION(4, 6, 0)) {
> 			info->l1_index_size = PTE_INDEX_SIZE_L4_64K_3_10;
>-			info->l2_index_size = PMD_INDEX_SIZE_L4_64K_4_6;
>-			info->l3_index_size = PUD_INDEX_SIZE_L4_64K_4_6;
>-			info->l4_index_size = PGD_INDEX_SIZE_L4_64K_3_10;
>
>+			if (info->kernel_version >= KERNEL_VERSION(4, 12, 0)) {
>+				info->l2_index_size = PMD_INDEX_SIZE_L4_64K_4_12;
>+				info->l3_index_size = PUD_INDEX_SIZE_L4_64K_4_12;
>+				info->l4_index_size = PGD_INDEX_SIZE_L4_64K_4_12;
>+			} else {
>+				info->l2_index_size = PMD_INDEX_SIZE_L4_64K_4_6;
>+				info->l3_index_size = PUD_INDEX_SIZE_L4_64K_4_6;
>+				info->l4_index_size = PGD_INDEX_SIZE_L4_64K_3_10;
>+			}
> 		} else if (info->kernel_version >= KERNEL_VERSION(3, 10, 0)) {
> 			info->l1_index_size = PTE_INDEX_SIZE_L4_64K_3_10;
> 			info->l2_index_size = PMD_INDEX_SIZE_L4_64K_3_10;
>diff --git a/makedumpfile.h b/makedumpfile.h
>index db75379..b983aaf 100644
>--- a/makedumpfile.h
>+++ b/makedumpfile.h
>@@ -670,6 +670,9 @@ unsigned long get_kvbase_arm64(void);
> #define PGD_INDEX_SIZE_L4_64K_3_10  12
> #define PMD_INDEX_SIZE_L4_64K_4_6  5
> #define PUD_INDEX_SIZE_L4_64K_4_6  5
>+#define PMD_INDEX_SIZE_L4_64K_4_12 10
>+#define PUD_INDEX_SIZE_L4_64K_4_12 7
>+#define PGD_INDEX_SIZE_L4_64K_4_12 8
> #define PTE_INDEX_SIZE_RADIX_64K  5
> #define PMD_INDEX_SIZE_RADIX_64K  9
> #define PUD_INDEX_SIZE_RADIX_64K  9
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
