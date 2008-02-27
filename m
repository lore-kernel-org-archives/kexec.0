Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JUGBv-0003VM-Hn
	for kexec@lists.infradead.org; Wed, 27 Feb 2008 06:55:00 +0000
Received: from tabatha.lab.ultramonkey.org (vagw.valinux.co.jp [210.128.90.14])
	by koto.vergenet.net (Postfix) with ESMTP id 94A06341D4
	for <kexec@lists.infradead.org>; Wed, 27 Feb 2008 15:54:52 +0900 (JST)
Message-Id: <20080227065343.288517175@vergenet.net>
References: <20080227065154.518014550@vergenet.net>
Date: Wed, 27 Feb 2008 15:51:58 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [patch 4/5] kexec-tools: merge segments
Content-Disposition: inline; filename=merge-segments.patch
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

A list of segments is passed into the kernel at kexec_load time
and these are subsequently passed to purgatory which uses
them to mangle the EFI memory table.

Each of these segments represents a PT_LOAD segment in the
elf image to be booted after purgatory. They are already
aligned 64k by this code,

The problem with the code as it stands is that it creates
a separate segment for each PT_LOAD segment. Which in the
end results in separate EFI memory regions for each
PT_LOAD segment. And when linux or xen goes to insert
its kernel/hypervisor regions into /proc/iomem
or /proc/iomem_mashine, they don't fit because those regions
actually span several of the new EFI regions created.

So it makes sense to merge these segments if they are adjacent
after alignment - which they always seem to be. This results
in one EFI region that can contain the relevent kernel/hypervisor
iomem region. Problem solved.

This merging could be done in purgatory. But its easier
and cleaner to do it here (IMHO).

The test for this code is to kexec a machine running kexec it
into linux and then inspect /proc/iomem to see of the kernel
code, text and bss regions are present. Without this fix,
they won't be. With it they should be.

This patch is part of the solution to the same problem for
the hypervisor, though it requires an additional change
to split the code from the heap as the later resides in
convential memory rather than the load segment created
by purgatory's mangling.

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

 kexec/arch/ia64/crashdump-ia64.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

Index: kexec-tools-testing-ia64-xen/kexec/arch/ia64/crashdump-ia64.c
===================================================================
--- kexec-tools-testing-ia64-xen.orig/kexec/arch/ia64/crashdump-ia64.c	2008-02-22 17:27:49.000000000 +0900
+++ kexec-tools-testing-ia64-xen/kexec/arch/ia64/crashdump-ia64.c	2008-02-22 18:09:54.000000000 +0900
@@ -76,18 +76,29 @@ static void add_loaded_segments_info(str
 {
 	 int i;
          for(i = 0; i < ehdr->e_phnum; i++) {
-                unsigned long start, end;
                 struct mem_phdr *phdr;
                 phdr = &ehdr->e_phdr[i];
                 if (phdr->p_type != PT_LOAD)
                         continue;
-                start = phdr->p_paddr;
-                end = phdr->p_paddr + phdr->p_memsz;
 
 		loaded_segments[loaded_segments_num].start =
-                        start&~(ELF_PAGE_SIZE-1);
+			phdr->p_paddr & ~(ELF_PAGE_SIZE-1);
                 loaded_segments[loaded_segments_num].end =
-                        (end + ELF_PAGE_SIZE - 1)&~(ELF_PAGE_SIZE - 1);
+			loaded_segments[loaded_segments_num].start;
+
+		while (i < ehdr->e_phnum) {
+			phdr = &ehdr->e_phdr[i];
+	                if (phdr->p_type != PT_LOAD)
+	                        break;
+			if (loaded_segments[loaded_segments_num].end !=
+				phdr->p_paddr & ~(ELF_PAGE_SIZE-1))
+				break;
+			loaded_segments[loaded_segments_num].end +=
+				(phdr->p_memsz + ELF_PAGE_SIZE - 1) &
+				~(ELF_PAGE_SIZE - 1);
+			i++;
+		}
+
 		loaded_segments_num++;
 	}
 }

-- 

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
