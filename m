Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlxHl-0005SF-Sb
 for kexec@lists.infradead.org; Thu, 28 Nov 2013 08:49:23 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 023AD3EE0DE
 for <kexec@lists.infradead.org>; Thu, 28 Nov 2013 17:48:56 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id E42C645DE4D
 for <kexec@lists.infradead.org>; Thu, 28 Nov 2013 17:48:55 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.nic.fujitsu.com [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id CA4D445DE4C
 for <kexec@lists.infradead.org>; Thu, 28 Nov 2013 17:48:55 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id BE6251DB8038
 for <kexec@lists.infradead.org>; Thu, 28 Nov 2013 17:48:55 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 6C6891DB802C
 for <kexec@lists.infradead.org>; Thu, 28 Nov 2013 17:48:55 +0900 (JST)
Message-ID: <52970342.8090302@jp.fujitsu.com>
Date: Thu, 28 Nov 2013 17:48:02 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH] vmcore: call remap_pfn_range() separately for respective
 partial pages
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hello Vivek,

Here is a patch set for mmap failure for /proc/vmcore.
Could you try to use this on the problematic system?

This patch doesn't copy partial pages to the 2nd kernel, only prepares
vmcore objects for respective partial pages to invoke remap_pfn_range()
for individual partial pages.

From c83dddd23be2a2972dcb3f252598c39abfa23078 Mon Sep 17 00:00:00 2001
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Thu, 28 Nov 2013 14:51:22 +0900
Subject: [PATCH] vmcore: call remap_pfn_range() separately for respective
 partial pages

Acording to the report by Vivek in
https://lkml.org/lkml/2013/11/13/439, on some specific systems, some
of the System RAM ranges don't end at page boundary and the later part
of the same page is used for some kind of ACPI data. As a result,
remap_pfn_range() to the partial page failed if mapping range covers a
boundary of the System RAM part and the ACPI data part in the partial
page, due to the detection of different cache types in
track_pfn_remap().

To resolve the issue, call remap_pfn_range() separately for respective
partial pages, not for multiple consequtive pages that don't either
start or end at page boundary, by creating vmcore objects for
respective partial pages.

This patch never changes shape of /proc/vmcore visible from user-land.

Reported-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 fs/proc/vmcore.c | 108 ++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 84 insertions(+), 24 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 9100d69..e396a1d 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -816,26 +816,56 @@ static int __init process_ptload_program_headers_elf64(char *elfptr,
 	vmcore_off = elfsz + elfnotes_sz;
 
 	for (i = 0; i < ehdr_ptr->e_phnum; i++, phdr_ptr++) {
-		u64 paddr, start, end, size;
+		u64 start, end, size, rest;
+		u64 start_up, start_down, end_up, end_down;
 
 		if (phdr_ptr->p_type != PT_LOAD)
 			continue;
 
-		paddr = phdr_ptr->p_offset;
-		start = rounddown(paddr, PAGE_SIZE);
-		end = roundup(paddr + phdr_ptr->p_memsz, PAGE_SIZE);
-		size = end - start;
+		start = phdr_ptr->p_offset;
+		start_up = roundup(start, PAGE_SIZE);
+		start_down = rounddown(start, PAGE_SIZE);
+		end = phdr_ptr->p_offset + phdr_ptr->p_memsz;
+		end_up = roundup(end, PAGE_SIZE);
+		end_down = rounddown(end, PAGE_SIZE);
+		size = end_up - start_down;
+		rest = phdr_ptr->p_memsz;
+
+		if (!PAGE_ALIGNED(start)) {
+			new = get_new_element();
+			if (!new)
+				return -ENOMEM;
+			new->paddr = start_down;
+			new->size = PAGE_SIZE;
+			list_add_tail(&new->list, vc_list);
+			rest -= min(start_up, end) - start;
+		}
 
 		/* Add this contiguous chunk of memory to vmcore list.*/
-		new = get_new_element();
-		if (!new)
-			return -ENOMEM;
-		new->paddr = start;
-		new->size = size;
-		list_add_tail(&new->list, vc_list);
+		if (rest > 0 && start_up < end_down) {
+			new = get_new_element();
+			if (!new)
+				return -ENOMEM;
+			new->paddr = start_up;
+			new->size = end_down - start_up;
+			list_add_tail(&new->list, vc_list);
+			rest -= end_down - start_up;
+		}
+
+		if (rest > 0) {
+			new = get_new_element();
+			if (!new)
+				return -ENOMEM;
+			new->paddr = end_down;
+			new->size = PAGE_SIZE;
+			list_add_tail(&new->list, vc_list);
+			rest -= end - end_down;
+		}
+
+		WARN_ON(rest > 0);
 
 		/* Update the program header offset. */
-		phdr_ptr->p_offset = vmcore_off + (paddr - start);
+		phdr_ptr->p_offset = vmcore_off + (start - start_down);
 		vmcore_off = vmcore_off + size;
 	}
 	return 0;
@@ -859,26 +889,56 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
 	vmcore_off = elfsz + elfnotes_sz;
 
 	for (i = 0; i < ehdr_ptr->e_phnum; i++, phdr_ptr++) {
-		u64 paddr, start, end, size;
+		u64 start, end, size, rest;
+		u64 start_up, start_down, end_up, end_down;
 
 		if (phdr_ptr->p_type != PT_LOAD)
 			continue;
 
-		paddr = phdr_ptr->p_offset;
-		start = rounddown(paddr, PAGE_SIZE);
-		end = roundup(paddr + phdr_ptr->p_memsz, PAGE_SIZE);
-		size = end - start;
+		start = phdr_ptr->p_offset;
+		start_up = roundup(start, PAGE_SIZE);
+		start_down = rounddown(start, PAGE_SIZE);
+		end = phdr_ptr->p_offset + phdr_ptr->p_memsz;
+		end_up = roundup(end, PAGE_SIZE);
+		end_down = rounddown(end, PAGE_SIZE);
+		rest = phdr_ptr->p_memsz;
+		size = end_up - start_down;
+
+		if (!PAGE_ALIGNED(start)) {
+			new = get_new_element();
+			if (!new)
+				return -ENOMEM;
+			new->paddr = start_down;
+			new->size = PAGE_SIZE;
+			list_add_tail(&new->list, vc_list);
+			rest -= min(start_up, end) - start;
+		}
 
 		/* Add this contiguous chunk of memory to vmcore list.*/
-		new = get_new_element();
-		if (!new)
-			return -ENOMEM;
-		new->paddr = start;
-		new->size = size;
-		list_add_tail(&new->list, vc_list);
+		if (rest > 0 && start_up < end_down) {
+			new = get_new_element();
+			if (!new)
+				return -ENOMEM;
+			new->paddr = start_up;
+			new->size = end_down - start_up;
+			list_add_tail(&new->list, vc_list);
+			rest -= end_down - start_up;
+		}
+
+		if (rest > 0) {
+			new = get_new_element();
+			if (!new)
+				return -ENOMEM;
+			new->paddr = end_down;
+			new->size = PAGE_SIZE;
+			list_add_tail(&new->list, vc_list);
+			rest -= end - end_down;
+		}
+
+		WARN_ON(rest > 0);
 
 		/* Update the program header offset */
-		phdr_ptr->p_offset = vmcore_off + (paddr - start);
+		phdr_ptr->p_offset = vmcore_off + (start - start_down);
 		vmcore_off = vmcore_off + size;
 	}
 	return 0;
-- 
1.8.3.1

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
