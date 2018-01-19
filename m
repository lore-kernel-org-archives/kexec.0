Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ecV7m-0006nO-5i
 for kexec@lists.infradead.org; Fri, 19 Jan 2018 11:46:25 +0000
From: Petr Tesarik <ptesarik@suse.com>
Subject: [makedumpfile PATCH 1/2] Fix off-by-one errors in exclude_segment()
Date: Fri, 19 Jan 2018 12:45:23 +0100
Message-Id: <ca842e328fcf6565a4cf0c8747367b3560d09412.1516354241.git.ptesarik@suse.com>
In-Reply-To: <cover.1516354241.git.ptesarik@suse.com>
References: <cover.1516354241.git.ptesarik@suse.com>
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
To: kexec@lists.infradead.org, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: Baoquan He <bhe@redhat.com>, Petr Tesarik <ptesarik@suse.com>

The crashed reserved memory end offset is the last address within
range, whereas the end offset in the pt_loads[] denotes the first
address past the range. This has caused a number of off-by-one
errors in exclude_segment().

First, let's unify the meaning of "end" to be the first out-of-range
address, i.e. start + size. Thanks to that, no +1 or -1 adjustments
are needed in exclude_segment().

Second, since the value read from /proc/iomem is the last address
within range, add one when passing it as an argument to
exclude_segment(). This is now the only adjustment by one.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 elf_info.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/elf_info.c b/elf_info.c
index 69b1719..1eaddd9 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -820,26 +820,26 @@ static int exclude_segment(struct pt_load_segment **pt_loads,
 		if (kvstart <  vend && kvend > vstart) {
 			if (kvstart != vstart && kvend != vend) {
 				/* Split load segment */
-				temp_seg.phys_start = end + 1;
+				temp_seg.phys_start = end;
 				temp_seg.phys_end = (*pt_loads)[i].phys_end;
-				temp_seg.virt_start = kvend + 1;
+				temp_seg.virt_start = kvend;
 				temp_seg.virt_end = vend;
 				temp_seg.file_offset = (*pt_loads)[i].file_offset
 					+ temp_seg.virt_start - (*pt_loads)[i].virt_start;
 				temp_seg.file_size = temp_seg.phys_end
 					- temp_seg.phys_start;
 
-				(*pt_loads)[i].virt_end = kvstart - 1;
-				(*pt_loads)[i].phys_end =  start - 1;
+				(*pt_loads)[i].virt_end = kvstart;
+				(*pt_loads)[i].phys_end =  start;
 				(*pt_loads)[i].file_size -= temp_seg.file_size;
 
 				tidx = i+1;
 			} else if (kvstart != vstart) {
-				(*pt_loads)[i].phys_end = start - 1;
-				(*pt_loads)[i].virt_end = kvstart - 1;
+				(*pt_loads)[i].phys_end = start;
+				(*pt_loads)[i].virt_end = kvstart;
 			} else {
-				(*pt_loads)[i].phys_start = end + 1;
-				(*pt_loads)[i].virt_start = kvend + 1;
+				(*pt_loads)[i].phys_start = end;
+				(*pt_loads)[i].virt_start = kvend;
 			}
 			(*pt_loads)[i].file_size -= (end -start);
 		}
@@ -917,7 +917,7 @@ int get_kcore_dump_loads(void)
 
 	for (i = 0; i < crash_reserved_mem_nr; i++)	{
 		exclude_segment(&pt_loads, &num_pt_loads,
-				crash_reserved_mem[i].start, crash_reserved_mem[i].end);
+				crash_reserved_mem[i].start, crash_reserved_mem[i].end + 1);
 	}
 
 	max_file_offset = 0;
-- 
2.13.6



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
