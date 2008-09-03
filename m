Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]
	helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KazUJ-0004HV-Tp
	for kexec@lists.infradead.org; Wed, 03 Sep 2008 21:02:04 +0000
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by netops-testserver-3.corp.sgi.com (Postfix) with ESMTP id EE97F9088C
	for <kexec@lists.infradead.org>; Wed,  3 Sep 2008 14:01:59 -0700 (PDT)
Received: from kluge.engr.sgi.com (kluge.engr.sgi.com [192.102.96.102])
	by cthulhu.engr.sgi.com (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP id
	m83L1xVw020832
	for <kexec@lists.infradead.org>; Wed, 3 Sep 2008 14:01:59 -0700
Message-ID: <48BEFB47.20004@sgi.com>
Date: Wed, 03 Sep 2008 14:01:59 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: [PATCH] IA64: kexec allocates too few memory for kdump kernel itself
Content-Type: multipart/mixed; boundary="------------010007030909090204060004"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This is a multi-part message in MIME format.
--------------010007030909090204060004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Sometimes the kexec would allocate not enough memory for kdump kernel
itself on IA64 and caused kdump kernel to panic at boot.

When it happens, the /proc/iomem would show a kernel RAM segment like
this:
3014000000-3015294fff : System RAM
  3014000000-3014823ccf : Kernel code
  3014823cd0-3014dee8ef : Kernel data
  3014dee8f0-301529448f : Kernel bss
3015295000-307bffdfff : System RAM
  3018000000-3037ffffff : Crash kernel

But kexec would allocate memory 3018000000-3019290000 for the kernel,
which is 0x5000 smaller than the regular kernel. In my cases, the
physical_node_map and kern_memmap of the kdump kernel overlaped and
caused data corruption.

This patch fixes the problem. The patch was generated against
kexec-tools 2.0.0 and tested in 2.6.27-rc4.

Signed-off-by: Jay Lan <jlan@sgi.com>


--------------010007030909090204060004
Content-Type: text/plain;
 name="bootmem-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bootmem-fix"

---
 kexec/arch/ia64/crashdump-ia64.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: kexec-tools/kexec/arch/ia64/crashdump-ia64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ia64/crashdump-ia64.c	2008-09-03 11:24:14.289758063 -0700
+++ kexec-tools/kexec/arch/ia64/crashdump-ia64.c	2008-09-03 11:29:34.095833316 -0700
@@ -90,15 +90,15 @@ static void add_loaded_segments_info(str
 			phdr = &ehdr->e_phdr[i];
 	                if (phdr->p_type != PT_LOAD)
 	                        break;
-			if (loaded_segments[loaded_segments_num].end !=
-				phdr->p_paddr & ~(ELF_PAGE_SIZE-1))
-				break;
+			if (loaded_segments[loaded_segments_num].end <
+			    (phdr->p_paddr & ~(ELF_PAGE_SIZE-1)) )
+				loaded_segments[loaded_segments_num].end
+				  = phdr->p_paddr & ~(ELF_PAGE_SIZE-1);
 			loaded_segments[loaded_segments_num].end +=
 				(phdr->p_memsz + ELF_PAGE_SIZE - 1) &
 				~(ELF_PAGE_SIZE - 1);
 			i++;
 		}
-
 		loaded_segments_num++;
 	}
 }

--------------010007030909090204060004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------010007030909090204060004--

