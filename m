Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rcsinet15.oracle.com ([148.87.113.117])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Sml0I-00039d-Rl
 for kexec@lists.infradead.org; Thu, 05 Jul 2012 12:17:52 +0000
Date: Thu, 5 Jul 2012 14:16:35 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH] kexec-tools: Read always one vmcoreinfo file
Message-ID: <20120705121635.GA2007@host-192-168-1-59.local.net-space.pl>
MIME-Version: 1.0
Content-Disposition: inline
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: konrad.wilk@oracle.com, horms@verge.net.au, olaf@aepfle.de, kexec@lists.infradead.org, xen-devel@lists.xensource.com

vmcoreinfo file could exists under /sys/kernel (valid on baremetal only)
and/or under /sys/hypervisor (valid when Xen dom0 is running).
Read only one of them. It means that only one PT_NOTE will be
always created. Remove extra code for second PT_NOTE creation.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 kexec/crashdump-elf.c |   33 +++++++--------------------------
 1 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/kexec/crashdump-elf.c b/kexec/crashdump-elf.c
index 8d82db9..ec66548 100644
--- a/kexec/crashdump-elf.c
+++ b/kexec/crashdump-elf.c
@@ -40,8 +40,6 @@ int FUNC(struct kexec_info *info,
 	uint64_t notes_addr, notes_len;
 	uint64_t vmcoreinfo_addr, vmcoreinfo_len;
 	int has_vmcoreinfo = 0;
-	uint64_t vmcoreinfo_addr_xen, vmcoreinfo_len_xen;
-	int has_vmcoreinfo_xen = 0;
 	int (*get_note_info)(int cpu, uint64_t *addr, uint64_t *len);
 
 	if (xen_present())
@@ -53,16 +51,14 @@ int FUNC(struct kexec_info *info,
 		return -1;
 	}
 
-	if (get_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len) == 0) {
-		has_vmcoreinfo = 1;
-	}
-
-	if (xen_present() &&
-	    get_xen_vmcoreinfo(&vmcoreinfo_addr_xen, &vmcoreinfo_len_xen) == 0) {
-		has_vmcoreinfo_xen = 1;
-	}
+	if (xen_present()) {
+		if (!get_xen_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len))
+			has_vmcoreinfo = 1;
+	} else
+		if (!get_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len))
+			has_vmcoreinfo = 1;
 
-	sz = sizeof(EHDR) + (nr_cpus + has_vmcoreinfo + has_vmcoreinfo_xen) * sizeof(PHDR) +
+	sz = sizeof(EHDR) + (nr_cpus + has_vmcoreinfo) * sizeof(PHDR) +
 	     ranges * sizeof(PHDR);
 
 	/*
@@ -179,21 +175,6 @@ int FUNC(struct kexec_info *info,
 		dbgprintf_phdr("vmcoreinfo header", phdr);
 	}
 
-	if (has_vmcoreinfo_xen) {
-		phdr = (PHDR *) bufp;
-		bufp += sizeof(PHDR);
-		phdr->p_type	= PT_NOTE;
-		phdr->p_flags	= 0;
-		phdr->p_offset  = phdr->p_paddr = vmcoreinfo_addr_xen;
-		phdr->p_vaddr   = 0;
-		phdr->p_filesz	= phdr->p_memsz	= vmcoreinfo_len_xen;
-		/* Do we need any alignment of segments? */
-		phdr->p_align	= 0;
-
-		(elf->e_phnum)++;
-		dbgprintf_phdr("vmcoreinfo_xen header", phdr);
-	}
-
 	/* Setup an PT_LOAD type program header for the region where
 	 * Kernel is mapped if elf_info->kern_size is non-zero.
 	 */
-- 
1.5.6.5

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
