Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UC3Sy-0006PV-E2
 for kexec@lists.infradead.org; Sun, 03 Mar 2013 07:36:17 +0000
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Sun, 3 Mar 2013 13:03:52 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 55663E002D
 for <kexec@lists.infradead.org>; Sun,  3 Mar 2013 13:07:16 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r237a0Kv35389644
 for <kexec@lists.infradead.org>; Sun, 3 Mar 2013 13:06:01 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r237a4mK002634
 for <kexec@lists.infradead.org>; Sun, 3 Mar 2013 18:36:04 +1100
Subject: [PATCH] kexec/ppc: Fix kernel program entry point while changing
 the load addr
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Date: Sun, 03 Mar 2013 13:06:00 +0530
Message-ID: <20130303073540.12040.16854.stgit@suzukikp>
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
To: kexec@lists.infradead.org
Cc: Matthew McClintock <msm@freescale.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

From: Suzuki K. Poulose <suzuki@in.ibm.com>

uImage probe fills the entry point (ep) based on the load_addr
from the uImage headers. If we change the load_addr, we should
accordingly update the entry point.

For ELF, calculate the offset of e_entry from the virtual start
address and add it to the physical start address to find the
physical address of kernel entry.

i.e,
  pa (e_entry) = pa(phdr[0].p_vaddr) + (e_entry - phdr[0].p_vaddr)
               = kernel_addr + (e_entry - phdr[0].p_vaddr)

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Matthew McClintock <msm@freescale.com>
---
 kexec/arch/ppc/kexec-elf-ppc.c    |   12 ++++++++----
 kexec/arch/ppc/kexec-uImage-ppc.c |    6 +++++-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index 8e408cc..5f63a64 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -397,10 +397,14 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 		die("Error device tree not loadded to address it was expecting to be loaded too!\n");
 	}
 
-	/* set various variables for the purgatory  ehdr.e_entry is a
-	 * virtual address, we can use kernel_addr which
-	 * should be the physical start address of the kernel */
-	addr = kernel_addr;
+	/* 
+	 * set various variables for the purgatory.
+	 * ehdr.e_entry is a virtual address. we know physical start
+	 * address of the kernel (kernel_addr). Find the offset of
+	 * e_entry from the virtual start address(e_phdr[0].p_vaddr)
+	 * and calculate the actual physical address of the 'kernel entry'.
+	 */
+	addr = kernel_addr + (ehdr.e_entry - ehdr.e_phdr[0].p_vaddr);
 	elf_rel_set_symbol(&info->rhdr, "kernel", &addr, sizeof(addr));
 
 	addr = dtb_addr;
diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index e0bc7bb..900cd16 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -159,15 +159,19 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 
 	/*
 	 * If the provided load_addr cannot be allocated, find a new
-	 * area.
+	 * area. Rebase the entry point based on the new load_addr.
 	 */
 	if (!valid_memory_range(info, load_addr, load_addr + (len + _1MiB))) {
+		int ep_offset = ep - load_addr;
+
 		load_addr = locate_hole(info, len + _1MiB, 0, 0, max_addr, 1);
 		if (load_addr == ULONG_MAX) {
 			printf("Can't allocate memory for kernel of len %ld\n",
 					len + _1MiB);
 			return -1;
 		}
+
+		ep = load_addr + ep_offset;
 	}
 
 	add_segment(info, buf, len, load_addr, len + _1MiB);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
