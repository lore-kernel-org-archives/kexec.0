Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga03-in.huawei.com ([119.145.14.66])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WhvGC-00064p-4W
 for kexec@lists.infradead.org; Wed, 07 May 2014 06:23:21 +0000
From: Liu Hua <sdu.liu@huawei.com>
Subject: [PATCH] makedumpfile: ARM: get correct mem_map offset
Date: Wed, 7 May 2014 14:15:56 +0800
Message-ID: <1399443356-46732-1-git-send-email-sdu.liu@huawei.com>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp, chaowang@redhat.com
Cc: wangnan0@huawei.com, kexec@lists.infradead.org, peifeiyue@huawei.com, sdu.liu@huawei.com, ext-mika.1.westerberg@nokia.com

When converting paddr to pfn, makedumpfile firstly minuses the
offset of physical memory, and then do the right shift. But the
kernel only does the right shift.

For the cases of ARCH_PFN_OFFSET=0 or non sparse memormy model,
this introduces no problem.

But for my arma9 platform with ARCH_PFN_OFFSET=0x80000 and sparse
memory model. Makedumfile can not get the mem_map correctly. It it
due to there is still offset for mem_map array.

This patch introduces the offset of the mem_map.

But I have no environment to test this patch for other paltfrom.
So I am not sure this patch works on other platforms.

Signed-off-by: Liu Hua <sdu.liu@huawei.com>
---
 makedumpfile.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 94515f6..6cf6e24 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2807,6 +2807,7 @@ int
 get_mm_sparsemem(void)
 {
 	unsigned int section_nr, mem_section_size, num_section;
+	unsigned int section_start;
 	mdf_pfn_t pfn_start, pfn_end;
 	unsigned long section, mem_map;
 	unsigned long *mem_sec = NULL;
@@ -2817,6 +2818,7 @@ get_mm_sparsemem(void)
 	 * Get the address of the symbol "mem_section".
 	 */
 	num_section = divideup(info->max_mapnr, PAGES_PER_SECTION());
+	section_start = ARCH_PFN_OFFSET / PAGES_PER_SECTION();
 	if (is_sparsemem_extreme()) {
 		info->sections_per_root = _SECTIONS_PER_ROOT_EXTREME();
 		mem_section_size = sizeof(void *) * NR_SECTION_ROOTS();
@@ -2842,7 +2844,7 @@ get_mm_sparsemem(void)
 		goto out;
 	}
 	for (section_nr = 0; section_nr < num_section; section_nr++) {
-		section = nr_to_section(section_nr, mem_sec);
+		section = nr_to_section(section_nr + section_start, mem_sec);
 		if (section == NOT_KV_ADDR) {
 			mem_map = NOT_MEMMAP_ADDR;
 		} else {
@@ -2851,7 +2853,7 @@ get_mm_sparsemem(void)
 				mem_map = NOT_MEMMAP_ADDR;
 			} else {
 				mem_map = sparse_decode_mem_map(mem_map,
-								section_nr);
+								section_nr + section_start);
 				if (!is_kvaddr(mem_map))
 					mem_map = NOT_MEMMAP_ADDR;
 			}
-- 
1.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
