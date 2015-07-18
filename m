Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn1on0112.outbound.protection.outlook.com
 ([157.56.110.112] helo=na01-bn1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZGYF8-0004CG-Mx
 for kexec@lists.infradead.org; Sat, 18 Jul 2015 19:57:55 +0000
From: Scott Wood <scottwood@freescale.com>
Subject: [PATCH 2/2] ppc64: Add a flag to tell the kernel it's booting from
 kexec
Date: Sat, 18 Jul 2015 14:57:19 -0500
Message-ID: <1437249439-31496-2-git-send-email-scottwood@freescale.com>
In-Reply-To: <1437249439-31496-1-git-send-email-scottwood@freescale.com>
References: <1437249439-31496-1-git-send-email-scottwood@freescale.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org

It needs to know this because the SMP release mechanism for Freescale
book3e is different from when booting with normal hardware.  In theory
we could simulate the normal spin table mechanism, but not (easily) at
the addresses U-Boot put in the device tree -- so there'd need to be
even more communication between the kernel and kexec to set that up.
Since there's already a similar flag being set (for kdump only), this
seemed like a reasonable approach.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 kexec/arch/ppc64/kexec-elf-ppc64.c | 11 ++++++++++-
 kexec/arch/ppc64/kexec-ppc64.h     |  2 ++
 purgatory/arch/ppc64/v2wrap.S      | 11 +++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index adcee4c..ebd91b1 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -112,7 +112,7 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	unsigned int my_panic_kernel;
 	uint64_t my_stack, my_backup_start;
 	uint64_t toc_addr;
-	uint32_t my_run_at_load;
+	uint32_t my_run_at_load, my_booted_from_kexec;
 	unsigned int slave_code[256/sizeof (unsigned int)], master_entry;
 
 	/* See options.h -- add any more there, too. */
@@ -314,6 +314,15 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 				sizeof(my_run_at_load));
 	}
 
+	elf_rel_get_symbol(&info->rhdr, "booted_from_kexec",
+			&my_booted_from_kexec,
+			sizeof(my_booted_from_kexec));
+	if (my_booted_from_kexec == KERNEL_BOOTED_FROM_KEXEC_MAGIC)
+		my_booted_from_kexec = 1;
+	elf_rel_set_symbol(&info->rhdr, "booted_from_kexec",
+			&my_booted_from_kexec,
+			sizeof(my_booted_from_kexec));
+
 	/* Set stack address */
 	my_stack = locate_hole(info, 16*1024, 0, 0, max_addr, 1);
 	my_stack += 16*1024;
diff --git a/kexec/arch/ppc64/kexec-ppc64.h b/kexec/arch/ppc64/kexec-ppc64.h
index 89ee942..0e9f63d 100644
--- a/kexec/arch/ppc64/kexec-ppc64.h
+++ b/kexec/arch/ppc64/kexec-ppc64.h
@@ -14,6 +14,8 @@
 #define HAVE_DYNAMIC_MEMORY
 #define NEED_RESERVE_DTB
 
+#define KERNEL_BOOTED_FROM_KEXEC_MAGIC 0x6e6b7863 /* "nkxc" */
+
 int setup_memory_ranges(unsigned long kexec_flags);
 
 int elf_ppc64_probe(const char *buf, off_t len);
diff --git a/purgatory/arch/ppc64/v2wrap.S b/purgatory/arch/ppc64/v2wrap.S
index dc5034f..8ed9880 100644
--- a/purgatory/arch/ppc64/v2wrap.S
+++ b/purgatory/arch/ppc64/v2wrap.S
@@ -51,11 +51,19 @@
 	.align 8
 	.globl purgatory_start
 purgatory_start:	b	master
+
+	.org purgatory_start + 0x58     # ABI: possible booted_from_kexec flag
+	.globl booted_from_kexec
+booted_from_kexec:
+	.long 0
+	.size booted_from_kexec, . - booted_from_kexec
+
 	.org purgatory_start + 0x5c     # ABI: possible run_at_load flag at 0x5c
 	.globl run_at_load
 run_at_load:
 	.long 0
 	.size run_at_load, . - run_at_load
+
 	.org purgatory_start + 0x60     # ABI: slaves start at 60 with r3=phys
 slave:	b $
 	.org purgatory_start + 0x100    # ABI: end of copied region
@@ -111,6 +119,9 @@ master:
 	ld      9,0(6)          # load the OPAL entry address in r9
 	LOADADDR(6,kernel)
 	ld      4,0(6)          # load the kernel address
+	LOADADDR(6,booted_from_kexec)
+	lwz	7,0(6)		# possibly patched by kexec-elf-ppc64
+	stw	7,0x58(4)	# and patch it into the kernel
 	LOADADDR(6,run_at_load) # the load flag
 	lwz	7,0(6)		# possibly patched by kexec-elf-ppc64
 	stw	7,0x5c(4)	# and patch it into the kernel
-- 
2.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
