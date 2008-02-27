Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JUGBv-0003VO-Hu
	for kexec@lists.infradead.org; Wed, 27 Feb 2008 06:55:00 +0000
Received: from tabatha.lab.ultramonkey.org (vagw.valinux.co.jp [210.128.90.14])
	by koto.vergenet.net (Postfix) with ESMTP id 9EE2E341D6
	for <kexec@lists.infradead.org>; Wed, 27 Feb 2008 15:54:52 +0900 (JST)
Message-Id: <20080227065343.499608769@vergenet.net>
References: <20080227065154.518014550@vergenet.net>
Date: Wed, 27 Feb 2008 15:51:59 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [patch 5/5] kexec-tools: redivide efi memory in purgatory
Content-Disposition: inline; filename=super-region-split-3.patch
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

From my observations the way that the EFI_LOAD_DATA is provided
on the inital boot works like this:

There is a large EFI_CONVENTIONAL_MEMORY region.
The portion begining at the first load segment of
the image to be loading and ending with the last segment,
aligned to 64K, is turned into a separate region
of type EFI_LOAD_DATA.

A truncated example of this:

...
mem04: type= 7, attr=0x0000000000000008, range=[0x0000000000100000-0x0000000004000000) (  63MB)
mem05: type= 2, attr=0x0000000000000008, range=[0x0000000004000000-0x000000000481f000) (   8MB)
mem06: type= 7, attr=0x0000000000000008, range=[0x000000000481f000-0x000000003e876000) ( 928MB)
...

Where type 7 is EFI_CONVENTIONAL_MEMORY and
type 3 is EFI_LOAD_DATA.

There is a patch to the user-space portion of kexec-tools that merges the
segments supplied to this code if they are adjacent. This seems to always
result in a single segment being passed to this code, that should start
at the same address as the existing EFI_LOAD_DATA segment.

So all that should be left to do is to merge the existing
EFI_LOAD_DATA region with the following EFI_CONVENTIONAL_MEMORY region,
and then split it up to accommodate the segment passed from user-space.

The new EFI_LOAD_DATA region created with this code will always
start at the same address as the old EFI_LOAD_DATA region. If
this proves to be overly simplistic it should be easy to update.

This code also allows merging of multiple regions to accommodate
the new EFI_LOAD_DATA region. I strongly doubt this will ever
be used, but it is in line with the way the existing code works.


If the same image is used after kexec, then the
EFI regions in question will turn out the same as the original regions.

This is important, otherwise kernel / hypervisor regions will not be able
to be inserted into /proc/iomem / /proc/iomem_machine.

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

 purgatory/arch/ia64/purgatory-ia64.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: kexec-tools-testing-ia64-xen/purgatory/arch/ia64/purgatory-ia64.c
===================================================================
--- kexec-tools-testing-ia64-xen.orig/purgatory/arch/ia64/purgatory-ia64.c	2008-02-26 16:43:09.000000000 +0900
+++ kexec-tools-testing-ia64-xen/purgatory/arch/ia64/purgatory-ia64.c	2008-02-26 16:43:21.000000000 +0900
@@ -190,6 +190,22 @@ patch_efi_memmap(struct kexec_boot_param
 				mend = src_md->phys_addr +
 					(src_md->num_pages << EFI_PAGE_SHIFT);
 			}
+                        if (seg->end < mend && src < src_end) {
+                                void *src_next;
+                                efi_memory_desc_t *src_next_md;
+                                src_next = src + boot_param->efi_memdesc_size;
+                                src_next_md = src_next;
+                                if (src_next_md->type ==
+                                    EFI_CONVENTIONAL_MEMORY) {
+				        /* TODO check contig and attribute */
+                                        src += boot_param->efi_memdesc_size;
+                                        src_md = src;
+				        mend = src_md->phys_addr +
+					        (src_md->num_pages <<
+                                                 EFI_PAGE_SHIFT);
+                                }
+
+                        }
 			start_pages = (seg->start - mstart) >> EFI_PAGE_SHIFT;
 			mid_pages = (seg->end - seg->start) >> EFI_PAGE_SHIFT;
 			end_pages = (mend - seg->end) >> EFI_PAGE_SHIFT;

-- 

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
