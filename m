Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwym04.jp.fujitsu.com ([211.128.242.43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gFDxW-0001hu-Ry
 for kexec@lists.infradead.org; Wed, 24 Oct 2018 07:52:08 +0000
Received: from g01jpfmpwyt01.exch.g01.fujitsu.local
 (g01jpfmpwyt01.exch.g01.fujitsu.local [10.128.193.38])
 by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 01228AC0232
 for <kexec@lists.infradead.org>; Wed, 24 Oct 2018 16:51:43 +0900 (JST)
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Subject: [PATCH] makedumpfile: Fix failure of detection of SPARSEMEM EXTREME
 in case of -x VMLINUX
Date: Wed, 24 Oct 2018 07:51:41 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E21B99CA54@G01JPEXMBYT03>
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
To: "'k-hagio@ab.jp.nec.com'" <k-hagio@ab.jp.nec.com>
Cc: "'kexec@lists.infradead.org'" <kexec@lists.infradead.org>

This issue was introduced by commit
f3c87e0ab1f62b118e738d046c3d676325770418.

Currently, is_sparsemem_extreme() compares ARRAY_LENGTH(mem_section)
with NOT_FOUND_SYMBOL but correct initial value for array table is
NOT_FOUND_STRUCTURE.

As a result, makedumpfile fails to detect SPARSEMEM EXTREME and so
fails to convert vmcore captured by sadump as follows:

    # LANG=C makedumpfile --message-level 31 -f -l -d 31 -x ./vmlinux /dev/sdc vmcore-ld31
    sadump: read dump device as single partition
    sadump: single partition configuration
    page_size    : 4096
    sadump: timezone information is missing
    sadump: idtr=fffffe0000000000
    sadump: cr3=ba4e0a000
    sadump: idtr(phys)=ba55cc000
    sadump: devide_error(vmlinux)=ffffffff81a00c50
    sadump: devide_error(vmcore)=ffffffff83c00c50
    sadump: cmdline vaddr: ffffffff84bcf008
    sadump: cmdline paddr: ba55cf008
    sadump: cmdline buf vaddr: ffff8fa39ffceec0
    sadump: cmdline buf paddr: 109ffceec0
    sadump: kaslr_offset=2200000
    sadump: phys_base=ba0a00000
    sadump: online cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59
    sadump: nr_cpus: 60
    The kernel version is not supported.
    The makedumpfile operation may be incomplete.
    sadump: SRC_START: 0x00000000001000 SRC_SIZE: 0x0000000009f000 SRC_OFFSET: 0x00000025f61000
    sadump: kdump backup region unused

    num of NODEs : 2

    Memory type  : SPARSEMEM

    get_mm_sparsemem: Can't get the address of mem_section.

    makedumpfile Failed.

This issue doesn't occur for vmcore captured by kdump because in that
case, the length of mem_section is provided via VMCOREINFO and
is_sparsemem_extreme() returns TRUE via the other path.

This issue occurs also for other mechanisms where we need to use
-x VMLINUX such as virsh dump.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 makedumpfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 1ed3d61..18b4364 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2084,7 +2084,7 @@ is_sparsemem_extreme(void)
 {
 	if ((ARRAY_LENGTH(mem_section)
 	     == divideup(NR_MEM_SECTIONS(), _SECTIONS_PER_ROOT_EXTREME()))
-	    || (ARRAY_LENGTH(mem_section) == NOT_FOUND_SYMBOL))
+	    || (ARRAY_LENGTH(mem_section) == NOT_FOUND_STRUCTURE))
 		return TRUE;
 	else
 		return FALSE;
-- 
2.18.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
