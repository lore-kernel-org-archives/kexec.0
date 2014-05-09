Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wifmz-0003Lk-9D
 for kexec@lists.infradead.org; Fri, 09 May 2014 08:04:19 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] makedumpfile: ARM: get correct mem_map offset
Date: Fri, 9 May 2014 08:02:05 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9720FA9B@BPXM01GP.gisp.nec.co.jp>
References: <1399443356-46732-1-git-send-email-sdu.liu@huawei.com>
In-Reply-To: <1399443356-46732-1-git-send-email-sdu.liu@huawei.com>
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
To: "sdu.liu@huawei.com" <sdu.liu@huawei.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>When converting paddr to pfn, makedumpfile firstly minuses the
>offset of physical memory, and then do the right shift. But the
>kernel only does the right shift.

Did you mean the patch below is wrong?

  commit 1e93ee75f9d47c219e833210eb31e4a747cc3a8d
  Author: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
  Date:   Tue Jun 22 09:59:10 2010 +0300

      use ARCH_PFN_OFFSET for pfn_to_paddr/paddr_to_pfn translations

Your description sounds we should fix the way to convert paddr to pfn,
but there is no such fix in your patch.

>For the cases of ARCH_PFN_OFFSET=0 or non sparse memormy model,
>this introduces no problem.
>
>But for my arma9 platform with ARCH_PFN_OFFSET=0x80000 and sparse
>memory model. Makedumfile can not get the mem_map correctly. It it
>due to there is still offset for mem_map array.

Why the other memory models are OK? There is no offset even if ARCH_PFN_OFFSET!=0?
I need more explanation to understand this issue.


Thanks
Atsushi Kumagai

>
>This patch introduces the offset of the mem_map.
>
>But I have no environment to test this patch for other paltfrom.
>So I am not sure this patch works on other platforms.
>
>Signed-off-by: Liu Hua <sdu.liu@huawei.com>
>---
> makedumpfile.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/makedumpfile.c b/makedumpfile.c
>index 94515f6..6cf6e24 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -2807,6 +2807,7 @@ int
> get_mm_sparsemem(void)
> {
> 	unsigned int section_nr, mem_section_size, num_section;
>+	unsigned int section_start;
> 	mdf_pfn_t pfn_start, pfn_end;
> 	unsigned long section, mem_map;
> 	unsigned long *mem_sec = NULL;
>@@ -2817,6 +2818,7 @@ get_mm_sparsemem(void)
> 	 * Get the address of the symbol "mem_section".
> 	 */
> 	num_section = divideup(info->max_mapnr, PAGES_PER_SECTION());
>+	section_start = ARCH_PFN_OFFSET / PAGES_PER_SECTION();
> 	if (is_sparsemem_extreme()) {
> 		info->sections_per_root = _SECTIONS_PER_ROOT_EXTREME();
> 		mem_section_size = sizeof(void *) * NR_SECTION_ROOTS();
>@@ -2842,7 +2844,7 @@ get_mm_sparsemem(void)
> 		goto out;
> 	}
> 	for (section_nr = 0; section_nr < num_section; section_nr++) {
>-		section = nr_to_section(section_nr, mem_sec);
>+		section = nr_to_section(section_nr + section_start, mem_sec);
> 		if (section == NOT_KV_ADDR) {
> 			mem_map = NOT_MEMMAP_ADDR;
> 		} else {
>@@ -2851,7 +2853,7 @@ get_mm_sparsemem(void)
> 				mem_map = NOT_MEMMAP_ADDR;
> 			} else {
> 				mem_map = sparse_decode_mem_map(mem_map,
>-								section_nr);
>+								section_nr + section_start);
> 				if (!is_kvaddr(mem_map))
> 					mem_map = NOT_MEMMAP_ADDR;
> 			}
>--
>1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
