Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d85aD-0008U8-VB
 for kexec@lists.infradead.org; Tue, 09 May 2017 13:53:47 +0000
Received: by mail-pf0-f175.google.com with SMTP id e193so527335pfh.0
 for <kexec@lists.infradead.org>; Tue, 09 May 2017 06:53:24 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile PATCH V2] elf_info: fix file_size if segment is excluded
Date: Tue,  9 May 2017 19:23:18 +0530
Message-Id: <6edcc4dfcd9ed60265a5fde658ad2db4c4f28cad.1494337896.git.panand@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ats-kumagai@wm.jp.nec.com
Cc: Pratyush Anand <panand@redhat.com>, dyoung@redhat.com, kexec@lists.infradead.org, bhe@redhat.com

I received following on a specific x86_64 hp virtual machine while
executing `makedumpfile --mem-usage /proc/kcore`.

vtop4_x86_64: Can't get a valid pte.
readmem: Can't convert a virtual address(ffffffff88115860) to physical address.
readmem: type_addr: 0, addr:ffffffff88115860, size:128
get_nodes_online: Can't get the node online map.

With some debug print in vtop4_x86_64() I noticed that pte value is read
as 0, while crash reads the value correctly:

from makedumpfile:
vaddr=ffffffff88115860
page_dir=59eaff8
pml4=59ed067
pgd_paddr=59edff0
pgd_pte=59ee063
pmd_paddr=59ee200
pmd_pte=3642f063
pte_paddr=3642f8a8
pte=0

from crash
crash> vtop ffffffff88115860
VIRTUAL           PHYSICAL
ffffffff88115860  5b15860

PML4 DIRECTORY: ffffffff87fea000
PAGE DIRECTORY: 59ed067
   PUD: 59edff0 => 59ee063
   PMD: 59ee200 => 3642f063
   PTE: 3642f8a8 => 5b15163
  PAGE: 5b15000

With some more debug prints in elf_info.c

Before calling exclude_segment()

LOAD (2)
  phys_start : 100000
  phys_end   : dfffd000
  virt_start : ffff8a5a40100000
  virt_end   : ffff8a5b1fffd000
  file_offset: a5a40102000
  file_size  : dfefd000

exclude_segment() is called for Crash Kernel whose range is
2b000000-350fffff.

We see following after exclude_segment()

LOAD (2)
  phys_start : 100000
  phys_end   : 2affffff
  virt_start : ffff8a5a40100000
  virt_end   : ffff8a5a6affffff
  file_offset: a5a40102000
  file_size  : dfefd000
LOAD (3)
  phys_start : 35100000
  phys_end   : dfffd000
  virt_start : ffff8a5a75100000
  virt_end   : ffff8a5b1fffd000
  file_offset: a5a75102000
  file_size  : 0

Since file_size is calculated wrong therefore readpage_elf() does not
behave correctly.

This patch fixes above wrong behavior.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
v1->v2 : subtracted (end - start) from file_size as well

 elf_info.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/elf_info.c b/elf_info.c
index 8e2437622141..5494c4dcbebe 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -826,9 +826,13 @@ static int exclude_segment(struct pt_load_segment **pt_loads,
 				temp_seg.virt_end = vend;
 				temp_seg.file_offset = (*pt_loads)[i].file_offset
 					+ temp_seg.virt_start - (*pt_loads)[i].virt_start;
+				temp_seg.file_size = temp_seg.phys_end
+					- temp_seg.phys_start;
 
 				(*pt_loads)[i].virt_end = kvstart - 1;
 				(*pt_loads)[i].phys_end =  start - 1;
+				(*pt_loads)[i].file_size -= (temp_seg.file_size
+					+ end - start);
 
 				tidx = i+1;
 			} else if (kvstart != vstart) {
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
