Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dh4dE-00072z-W6
 for kexec@lists.infradead.org; Mon, 14 Aug 2017 01:57:31 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [Makedumpfile PATCH] Fix SECTION_MAP_MASK for kernel >= v.13
Date: Mon, 14 Aug 2017 01:53:21 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701EF87E0@BPXM01GP.gisp.nec.co.jp>
References: <7b445774345728d4a67e18513cb5ceb184f44d4c.1502385614.git.panand@redhat.com>
In-Reply-To: <7b445774345728d4a67e18513cb5ceb184f44d4c.1502385614.git.panand@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: "dyoung@redhat.com" <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Pratyush,

>commit 2d070eab2e82 "mm: consider zone which is not fully populated to
>have holes" added a new flag SECTION_IS_ONLINE and therefore
>SECTION_MAP_MASK has been changed. We are not able to find correct
>mem_map in makedumpfile for kernel version v4.13-rc1 and onward because
>of the above kernel change.
>
>This patch fixes the MASK value keeping the code backward compatible
>
>Signed-off-by: Pratyush Anand <panand@redhat.com>
>---
> makedumpfile.c | 5 ++++-
> makedumpfile.h | 4 +++-
> 2 files changed, 7 insertions(+), 2 deletions(-)
>
>diff --git a/makedumpfile.c b/makedumpfile.c
>index 30230a15a2e7..7350e5b5af95 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -3304,7 +3304,10 @@ section_mem_map_addr(unsigned long addr)
> 		return NOT_KV_ADDR;
> 	}
> 	map = ULONG(mem_section + OFFSET(mem_section.section_mem_map));
>-	map &= SECTION_MAP_MASK;
>+	if (info->kernel_version <= KERNEL_VERSION(4, 12, 0))

I think this condition should be "< KERNEL_VERSION(4, 13, 0)",
actually v4.12.7 doesn't have SECTION_IS_ONLINE.

Thanks,
Atsushi Kumagai

>+		map &= SECTION_MAP_MASK_4_12;
>+	else
>+		map &= SECTION_MAP_MASK;
> 	free(mem_section);
>
> 	return map;
>diff --git a/makedumpfile.h b/makedumpfile.h
>index 8a05794843fb..322f28c632b0 100644
>--- a/makedumpfile.h
>+++ b/makedumpfile.h
>@@ -183,7 +183,9 @@ isAnon(unsigned long mapping)
> #define SECTIONS_PER_ROOT()	(info->sections_per_root)
> #define SECTION_ROOT_MASK()	(SECTIONS_PER_ROOT() - 1)
> #define SECTION_NR_TO_ROOT(sec)	((sec) / SECTIONS_PER_ROOT())
>-#define SECTION_MAP_LAST_BIT	(1UL<<2)
>+#define SECTION_IS_ONLINE	(1UL<<2)
>+#define SECTION_MAP_LAST_BIT	(1UL<<3)
>+#define SECTION_MAP_MASK_4_12	(~(SECTION_IS_ONLINE-1))
> #define SECTION_MAP_MASK	(~(SECTION_MAP_LAST_BIT-1))
> #define NR_SECTION_ROOTS()	divideup(num_section, SECTIONS_PER_ROOT())
> #define SECTION_NR_TO_PFN(sec)	((sec) << PFN_SECTION_SHIFT())
>--
>2.9.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
