Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ra.tuxdriver.com ([70.61.120.52])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JWBi2-00042a-Nm
	for kexec@lists.infradead.org; Mon, 03 Mar 2008 14:32:07 +0000
Date: Mon, 3 Mar 2008 09:30:26 -0500
From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH] reduce alignment constraint on ia64 elf core header
Message-ID: <20080303143026.GA15484@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, horms@verge.net.au
Cc: nhorman@tuxdriver.com

Hey all-
	Patch to reduce the alignment constraints on ia64 elf core headers.
From what I can see there is no need to align the elf core header structure to
the EFI_PAGE_SIZE (given that the EFI will never read this data, only the kernel
will when booting a kdump kernel).  And since this is going into our reserved
memory, it saves us 3K (4K vs 1K alignment).  Tested successfully by myself on
several ia64 boxes.

Thanks & Regards
Neil

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


 crashdump-ia64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)



diff --git a/kexec/arch/ia64/crashdump-ia64.c b/kexec/arch/ia64/crashdump-ia64.c
index e365b3e..2aa2b12 100644
--- a/kexec/arch/ia64/crashdump-ia64.c
+++ b/kexec/arch/ia64/crashdump-ia64.c
@@ -231,7 +231,7 @@ int load_crashdump_segments(struct kexec_info *info, struct mem_ehdr *ehdr,
 						       crash_memory_range,
 						       nr_ranges,
 						       &tmp, &sz,
-						       EFI_PAGE_SIZE) < 0)
+						       ELF_CORE_HEADER_ALIGN) < 0)
 				return -1;
 
 			elfcorehdr = add_buffer(info, tmp, sz, sz,
-- 
/****************************************************
 * Neil Horman <nhorman@tuxdriver.com>
 * Software Engineer, Red Hat
 ****************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
