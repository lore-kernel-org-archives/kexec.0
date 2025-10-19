Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E14CCD1A5
	for <kexec@archiver.kernel.org>; Sun, 19 Oct 2025 06:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=prNKwNoW/o7QdDt+USGhOL8192M663R67x3ATS043tI=; b=YrTqwcxLde1v03Q5w+qrcI8+Al
	TCby4xlAwS1Z3nSfn2SVxTgNTe/MeonWfCLNRzzL1m8/xNkQnYmKEHKQF7hMLpF2yzKjxhUsVgsSM
	nEpTvh9CR9FG8Cj3Xg9kI6Fru0tM5qnN5iSqmsqgyC/yT/DkqLiLB6On179Pn2CYaGmleaPrM80iB
	lwXCIWQY8Q1Gj6YiLxbFsGxzbjybyHYPYuO6UZelCuZV4N7140M+HGOTkvTDV5UM49SwzPmsMx4f5
	uKuEhXrt1n1cnjEIpn6Lxe3QVku5k9hixS0EyWYyllqrYi3ZFcjmjHF7/8lN+T82yALhIhzjP1Gzs
	BeDPgppw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMiu-0000000Aj0C-0VmQ;
	Sun, 19 Oct 2025 06:16:56 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMir-0000000Aiyr-3Gaz
	for kexec@lists.infradead.org;
	Sun, 19 Oct 2025 06:16:55 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so2713848b3a.2
        for <kexec@lists.infradead.org>; Sat, 18 Oct 2025 23:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854613; x=1761459413; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prNKwNoW/o7QdDt+USGhOL8192M663R67x3ATS043tI=;
        b=R8WywvWCis5DE/AOrY0EG9SJgNKMf0g0AorQzeKcY/ULM8Mo1bTgc3PFO9+c1twXwR
         x1oyH17dNdHI3gdZrG124VQ9K4oG2YIHqcrjZmPPyeSAK9VOw1E5zp1MaWrNTma75Gky
         GlFDZHLwmbAa2hLXYbdwrmvXI0Vt4q5ukuAx3AcD98KfrhdhmkRWZcJVIeqplW9Wb7Qb
         CX2RL05bZAfsrWnuYNzVu+91/s+j4uSMGrDUELDR26fvr1ZlQddXhvAAo6X44HcF1IlO
         Xsmnp6Mvs+phggFwF7rfmYaX+PWkeNCcUQA6ltQZ9Et4KBHDydsF3bbCkzBLJKBA//p8
         yIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854613; x=1761459413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prNKwNoW/o7QdDt+USGhOL8192M663R67x3ATS043tI=;
        b=IBkJO1g541VB8zo+Rqws1CnDzIJfPdfrKMo1yHdbhRaO51W+9ugE6J42ZLITWL/gYX
         RIjDo/UALwPYv0eFSysZy7tr5JOVtIA/ZqE2zyYEEe6oTxbGx38LIaA3K8otdVvDzufK
         m6H6RdyH4cyBDsBatPFjDtD/GNjTxSLRobnwAWy8NIhtbsFU9/5kTnbjuj8sIrodmAG1
         VlcQ8ZB7etLOS/LO1X+35gJYlmKyBR7w3JwnT36/6XpFTxwtShYINcHSzP6HhDCizeLx
         Q6naVzhhCcj1xas0Md+Rsl+s8cgTszuE2rIXx+9F/c0pbSQqpOOtwlNEYpDzTq4mftP3
         b0Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUHuzOeLpj5RkdiuisJBvRx+w6sJaut8sEfhgt109lE9WdREbH2fCiYaCRgME/L8d+PVfksTg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzHdP1aCEUcxgOaPA5FgQx5OBJkYkh3Mnm5PqWqXFFxYq1QpbMT
	C2CWBMxfZzSqMC6PQTcNK3N5aYMzNykkADlh4mNZQ1dDo6kTpS3UKoXt
X-Gm-Gg: ASbGncuJJF1S0/rY8vtm3C9fk6Oz5cakmvpVSF4UIE5fqaa3xtsI9OY6v+vn4hkF4XZ
	2L9k1t455QuTuA2cz9qT9gA252NNkfKQ9QlFGXwwPCqdyv+6I8xFURwC0JW5amQ8WA5UIt/AUow
	0watwD0dM9xtB9FAmDx3HoFSnSYYVI4xBOkjc2afuH64HiWznXRQUmd9T2oL7UZIg38VjycI4af
	yDGMc0dr9AjkXHcKcW14Y0nAaHLbUeCBx7aGQO8b4/rg9Zyixf4A2s/r0DQTXHlFicTQE7OQgGq
	j0M2WXbmgg/j1nF8fxc3LfyifJHzugjx8xxpZik7QO+n96LWQcyqZ0YXwUYfcUT+/ZKH0TQGJfC
	cZol2Rxqlt2c6cqmDlXRqMNAcpYbs6oHm11BqH97PcYD/5Vv0WEkJ+6ej3H3DMrtLcg1mQyMVOw
	tRXbk5
X-Google-Smtp-Source: AGHT+IF3iJEpvfQRjbbiVSzFlW8Wp4NdWQUwUHN2mBuAd5E7S5xjZeCB+W391MmJtvpZ60a/UAkSrA==
X-Received: by 2002:a05:6a20:158a:b0:2ff:3752:8388 with SMTP id adf61e73a8af0-334a86108f0mr11968019637.32.1760854612860;
        Sat, 18 Oct 2025 23:16:52 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:16:52 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: jiri@resnulli.us,
	stefanha@redhat.com,
	multikernel@lists.linux.dev,
	pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch v2 02/16] x86: Introduce SMP INIT trampoline for multikernel CPU bootstrap
Date: Sat, 18 Oct 2025 23:16:16 -0700
Message-Id: <20251019061631.2235405-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
References: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251018_231653_857621_DF7ABD08 
X-CRM114-Status: GOOD (  34.32  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Cong Wang <cwang@multikernel.io>

This patch introduces a dedicated trampoline mechanism for booting
secondary CPUs with different kernel instances in multikernel mode.
The implementation provides:

- New trampoline_64_bsp.S assembly code for real-mode to long-mode
  transition when launching kernels on secondary CPUs
- Trampoline memory allocation and setup in low memory (<1MB) for
  real-mode execution compatibility
- Page table construction for identity mapping during CPU bootstrap
- Integration with existing multikernel kexec infrastructure

The trampoline handles the complete CPU initialization sequence from
16-bit real mode through 32-bit protected mode to 64-bit long mode,
setting up appropriate GDT, page tables, and control registers before
jumping to the target kernel entry point without resetting the whole
system or the running kernel.

Note: This implementation uses legacy assembly-based trampoline code
and should be migrated to C-based x86 trampoline in future updates.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/x86/kernel/Makefile            |   1 +
 arch/x86/kernel/head64.c            |   5 +
 arch/x86/kernel/setup.c             |   3 +
 arch/x86/kernel/smpboot.c           |  85 ++++++--
 arch/x86/kernel/trampoline_64_bsp.S | 288 ++++++++++++++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S       |   6 +
 6 files changed, 373 insertions(+), 15 deletions(-)
 create mode 100644 arch/x86/kernel/trampoline_64_bsp.S

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index bc184dd38d99..49ff8272c888 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -50,6 +50,7 @@ CFLAGS_irq.o := -I $(src)/../include/asm/trace
 
 obj-y			+= head_$(BITS).o
 obj-y			+= head$(BITS).o
+obj-y			+= trampoline_64_bsp.o
 obj-y			+= ebda.o
 obj-y			+= platform-quirks.o
 obj-y			+= process_$(BITS).o signal.o signal_$(BITS).o
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index fd28b53dbac5..60005472facb 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -219,6 +219,9 @@ static void __init copy_bootdata(char *real_mode_data)
 	sme_unmap_bootdata(real_mode_data);
 }
 
+unsigned long orig_boot_params;
+EXPORT_SYMBOL(orig_boot_params);
+
 asmlinkage __visible void __init __noreturn x86_64_start_kernel(char * real_mode_data)
 {
 	/*
@@ -288,6 +291,8 @@ asmlinkage __visible void __init __noreturn x86_64_start_kernel(char * real_mode
 	/* set init_top_pgt kernel high mapping*/
 	init_top_pgt[511] = early_top_pgt[511];
 
+	orig_boot_params = (unsigned long) real_mode_data;
+
 	x86_64_start_reservations(real_mode_data);
 }
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1b2edd07a3e1..8342c4e46bad 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -877,6 +877,8 @@ static void __init x86_report_nx(void)
  * Note: On x86_64, fixmaps are ready for use even before this is called.
  */
 
+extern void __init setup_trampolines_bsp(void);
+
 void __init setup_arch(char **cmdline_p)
 {
 #ifdef CONFIG_X86_32
@@ -1103,6 +1105,7 @@ void __init setup_arch(char **cmdline_p)
 			(max_pfn_mapped<<PAGE_SHIFT) - 1);
 #endif
 
+	setup_trampolines_bsp();
 	/*
 	 * Find free memory for the real mode trampoline and place it there. If
 	 * there is not enough free memory under 1M, on EFI-enabled systems
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 7b27fdc1d169..9dea0477fda6 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -833,27 +833,46 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
+extern void __init setup_trampolines_bsp(void);
+extern unsigned long orig_boot_params;
+
+unsigned char *x86_trampoline_bsp_base;
+
+extern const unsigned char trampoline_data_bsp[];
+extern const unsigned char trampoline_status_bsp[];
+extern const unsigned char x86_trampoline_bsp_start [];
+extern const unsigned char x86_trampoline_bsp_end   [];
+extern unsigned long kernel_phys_addr;
+extern unsigned long boot_params_phys_addr;
+
+#define TRAMPOLINE_SYM_BSP(x)                                           \
+        ((void *)(x86_trampoline_bsp_base +                                     \
+                  ((const unsigned char *)(x) - trampoline_data_bsp)))
+
+/* Address of the SMP trampoline */
+static inline unsigned long trampoline_bsp_address(void)
+{
+        return virt_to_phys(TRAMPOLINE_SYM_BSP(trampoline_data_bsp));
+}
+
 // must be locked by cpus_read_lock()
 static int do_multikernel_boot_cpu(u32 apicid, int cpu, unsigned long kernel_start_address)
 {
-	unsigned long start_ip = real_mode_header->trampoline_start;
+	unsigned long start_ip;
 	int ret;
 
-	pr_info("do_multikernel_boot_cpu(apicid=%u, cpu=%u, kernel_start_address=%lx)\n", apicid, cpu, kernel_start_address);
-#ifdef CONFIG_X86_64
-	/* If 64-bit wakeup method exists, use the 64-bit mode trampoline IP */
-	if (apic->wakeup_secondary_cpu_64)
-		start_ip = real_mode_header->trampoline_start64;
-#endif
-	//initial_code = (unsigned long)start_secondary;
-	initial_code = (unsigned long)kernel_start_address;
+	/* Multikernel -- set physical address where kernel has been copied.
+           Note that this needs to be written to the location where the
+           trampoline was copied, not to the location within the original
+           kernel itself. */
+        unsigned long *kernel_virt_addr = TRAMPOLINE_SYM_BSP(&kernel_phys_addr);
 
-	if (IS_ENABLED(CONFIG_X86_32)) {
-		early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(cpu);
-		//initial_stack  = idle->thread.sp;
-	} else if (!(smpboot_control & STARTUP_PARALLEL_MASK)) {
-		smpboot_control = cpu;
-	}
+        *kernel_virt_addr = kernel_start_address;
+
+        /* start_ip had better be page-aligned! */
+        start_ip = trampoline_bsp_address();
+
+	pr_info("do_multikernel_boot_cpu(apicid=%u, cpu=%u, kernel_start_address=%lx)\n", apicid, cpu, kernel_start_address);
 
 	/* Skip init_espfix_ap(cpu); */
 
@@ -897,6 +916,9 @@ static int do_multikernel_boot_cpu(u32 apicid, int cpu, unsigned long kernel_sta
 	/* If the wakeup mechanism failed, cleanup the warm reset vector */
 	if (ret)
 		arch_cpuhp_cleanup_kick_cpu(cpu);
+
+        /* mark "stuck" area as not stuck */
+        *(volatile u32 *)TRAMPOLINE_SYM_BSP(trampoline_status_bsp) = 0;
 	return ret;
 }
 /*
@@ -1008,6 +1030,39 @@ int multikernel_kick_ap(unsigned int cpu, unsigned long kernel_start_address)
 	return err;
 }
 
+void __init setup_trampolines_bsp(void)
+{
+        phys_addr_t mem;
+        size_t size = PAGE_ALIGN(x86_trampoline_bsp_end - x86_trampoline_bsp_start);
+
+        /* Has to be in very low memory so we can execute real-mode AP code. */
+        mem = memblock_phys_alloc_range(size, PAGE_SIZE, 0, 1<<20);
+        if (!mem)
+                panic("Cannot allocate trampoline\n");
+
+        x86_trampoline_bsp_base = __va(mem);
+        memblock_reserve(mem, mem + size);
+
+        printk(KERN_DEBUG "Base memory trampoline BSP at [%p] %llx size %zu\n",
+               x86_trampoline_bsp_base, (unsigned long long)mem, size);
+
+        //if (!mklinux_boot) {
+                memcpy(x86_trampoline_bsp_base, trampoline_data_bsp, size);
+
+        //} else {
+        //        printk("Multikernel boot: BSP trampoline will NOT be copied\n");
+        //}
+}
+
+static int __init configure_trampolines_bsp(void)
+{
+        size_t size = PAGE_ALIGN(x86_trampoline_bsp_end - x86_trampoline_bsp_start);
+
+        set_memory_x((unsigned long)x86_trampoline_bsp_base, size >> PAGE_SHIFT);
+        return 0;
+}
+
+arch_initcall(configure_trampolines_bsp);
 
 int native_kick_ap(unsigned int cpu, struct task_struct *tidle)
 {
diff --git a/arch/x86/kernel/trampoline_64_bsp.S b/arch/x86/kernel/trampoline_64_bsp.S
new file mode 100644
index 000000000000..0bd2a971a973
--- /dev/null
+++ b/arch/x86/kernel/trampoline_64_bsp.S
@@ -0,0 +1,288 @@
+/*
+ *
+ *	Derived from Setup.S by Linus Torvalds, then derived from Popcorn Linux
+ *
+ *	4 Jan 1997 Michael Chastain: changed to gnu as.
+ *	15 Sept 2005 Eric Biederman: 64bit PIC support
+ *
+ *	Entry: CS:IP point to the start of our code, we are 
+ *	in real mode with no stack, but the rest of the 
+ *	trampoline page to make our stack and everything else
+ *	is a mystery.
+ *
+ *	On entry to trampoline_data, the processor is in real mode
+ *	with 16-bit addressing and 16-bit data.  CS has some value
+ *	and IP is zero.  Thus, data addresses need to be absolute
+ *	(no relocation) and are taken with regard to r_base.
+ *
+ *	With the addition of trampoline_level4_pgt this code can
+ *	now enter a 64bit kernel that lives at arbitrary 64bit
+ *	physical addresses.
+ *
+ *	If you work on this file, check the object module with objdump
+ *	--full-contents --reloc to make sure there are no relocation
+ *	entries.
+ */
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+#include <asm/pgtable_types.h>
+#include <asm/page_types.h>
+#include <asm/msr.h>
+#include <asm/segment.h>
+#include <asm/processor-flags.h>
+
+	.section ".x86_trampoline_bsp","a"
+	.balign PAGE_SIZE
+	.code16
+
+SYM_CODE_START(trampoline_data_bsp)
+bsp_base = .
+	cli			# We should be safe anyway
+	wbinvd
+	mov	%cs, %ax	# Code and data in the same place
+	mov	%ax, %ds
+	mov	%ax, %es
+	mov	%ax, %ss
+
+
+	movl	$0xA5A5A5A5, trampoline_status_bsp - bsp_base
+				# write marker for master knows we're running
+
+					# Setup stack
+	movw	$(trampoline_stack_bsp_end - bsp_base), %sp
+
+	# call	verify_cpu		# Verify the cpu supports long mode
+	# testl   %eax, %eax		# Check for return code
+	# jnz	no_longmode_bsp
+
+	mov	%cs, %ax
+	movzx	%ax, %esi		# Find the 32bit trampoline location
+	shll	$4, %esi
+
+					# Fixup the absolute vectors
+	leal	(startup_32_bsp - bsp_base)(%esi), %eax
+	movl	%eax, startup_32_vector_bsp - bsp_base
+	leal	(startup_64_bsp - bsp_base)(%esi), %eax
+	movl	%eax, startup_64_vector_bsp - bsp_base
+	leal	(tgdt_bsp - bsp_base)(%esi), %eax
+	movl	%eax, (tgdt_bsp + 2 - bsp_base)
+
+	/*
+	 * GDT tables in non default location kernel can be beyond 16MB and
+	 * lgdt will not be able to load the address as in real mode default
+	 * operand size is 16bit. Use lgdtl instead to force operand size
+	 * to 32 bit.
+	 */
+
+	lidtl	tidt_bsp - bsp_base	# load idt with 0, 0
+	lgdtl	tgdt_bsp - bsp_base	# load gdt with whatever is appropriate
+
+	mov	$X86_CR0_PE, %ax	# protected mode (PE) bit
+	lmsw	%ax			# into protected mode
+
+	# flush prefetch and jump to startup_32
+	ljmpl	*(startup_32_vector_bsp - bsp_base)
+SYM_CODE_END(trampoline_data_bsp)
+
+	.code32
+	.balign 4
+startup_32_bsp:
+
+	cli
+        movl    $(__KERNEL_DS), %eax
+        movl    %eax, %ds
+        movl    %eax, %es
+        movl    %eax, %ss
+
+	/* Load new GDT with the 64bit segments using 32bit descriptor.
+	 * The new GDT labels the entire address space as 64-bit, so we
+	 * can switch into long mode later. */
+        leal    (gdt_bsp_64 - bsp_base)(%esi), %eax
+        movl    %eax, (gdt_bsp_64 - bsp_base + 2)(%esi)
+        lgdt    (gdt_bsp_64 - bsp_base)(%esi)
+
+	/* Enable PAE mode.  Note that this does not actually take effect
+	 * until paging is enabled */
+	movl	%cr4, %eax
+        orl     $(X86_CR4_PAE), %eax
+        movl    %eax, %cr4
+
+        /* Initialize Page tables to 0 */
+	leal    (pgtable_bsp - bsp_base)(%esi), %edi
+	xorl    %eax, %eax
+        movl    $((4096*6)/4), %ecx
+        rep     stosl
+
+        /* Build Level 4 */
+        leal    (pgtable_bsp - bsp_base)(%esi), %edi
+        leal    0x1007 (%edi), %eax
+        movl    %eax, 0(%edi)
+
+        /* Build Level 3 */
+        leal    (pgtable_bsp - bsp_base + 0x1000)(%esi), %edi
+        leal    0x1007(%edi), %eax
+        movl    $4, %ecx
+1:      movl    %eax, 0x00(%edi)
+        addl    $0x00001000, %eax
+        addl    $8, %edi
+        decl    %ecx
+        jnz     1b
+
+        /* Build Level 2 */
+        leal    (pgtable_bsp - bsp_base + 0x2000)(%esi), %edi
+        movl    $0x00000183, %eax
+        movl    $2048, %ecx
+1:      movl    %eax, 0(%edi)
+        addl    $0x00200000, %eax
+        addl    $8, %edi
+        decl    %ecx
+        jnz     1b
+
+        /* Enable the boot page tables */
+        leal    (pgtable_bsp - bsp_base)(%esi), %eax
+        movl    %eax, %cr3
+
+        /* Enable Long mode in EFER (Extended Feature Enable Register) */
+        movl    $MSR_EFER, %ecx
+        rdmsr
+        btsl    $_EFER_LME, %eax
+        wrmsr
+
+        /*
+         * Setup for the jump to 64bit mode
+         *
+         * When the jump is performend we will be in long mode but
+         * in 32bit compatibility mode with EFER.LME = 1, CS.L = 0, CS.D = 1
+         * (and in turn EFER.LMA = 1).  To jump into 64bit mode we use
+         * the new gdt/idt that has __KERNEL_CS with CS.L = 1.
+         * We place all of the values on our mini stack so lret can
+         * used to perform that far jump.
+         */
+        pushl   $__KERNEL_CS
+        leal    (startup_64_bsp - bsp_base)(%esi), %eax
+        pushl   %eax
+
+	/* Enter paged protected Mode, activating Long Mode */
+        movl    $(X86_CR0_PG | X86_CR0_PE), %eax /* Enable Paging and Protected mode */
+        movl    %eax, %cr0
+
+	/* Jump from 32bit compatibility mode into 64bit mode. */
+        lret
+
+	.code64
+	.balign 4
+startup_64_bsp:
+
+	/* Get physical address of boot_params structure */
+	movq    (boot_params_phys_addr - bsp_base)(%rsi), %r15
+
+	/* Load kernel address into register */
+	movq    (kernel_phys_addr - bsp_base)(%rsi), %r14
+
+	/* Check whether the kernel is in the 4 GB we mapped already,
+	 * and if not, add an additional mapping */
+	movq	$0xffffffff00000000, %r8
+	testq	%r8, %r14
+	je	2f
+
+	/* If we got here, we need to identity-map an additional 1 GB */
+	
+	/* Mask off to figure out what our directory pointer should be */
+	movq	%r14, %r13
+	movq	$0xffffffffc0000000, %r12
+	andq	%r12, %r13
+
+	/* Set our PDPTE */
+	movq	%r13, %r11
+	shrq	$(30-3), %r11
+	leaq    (pgtable_bsp - bsp_base + 0x1000)(%rsi), %rdi
+	addq	%r11, %rdi
+	leaq	(pgtable_extra_bsp - bsp_base + 0x7)(%rsi), %rax
+	movq	%rax, 0(%rdi)
+
+	/* Populate the page directory */
+	leaq    (pgtable_extra_bsp - bsp_base)(%rsi), %rdi
+	movq    $0x00000183, %rax
+	addq	%r13, %rax
+	movq    $512, %rcx
+1:      movq    %rax, 0(%rdi)
+	addq    $0x00200000, %rax
+	addq    $8, %rdi
+	decq    %rcx
+	jnz     1b
+
+	/* Set esi to point to the boot_params structure */
+2:	movq	%r15, %rsi
+	jmp	*%r14
+
+	.align 8
+SYM_DATA(boot_params_phys_addr, .quad  0)
+
+	.align 8
+SYM_DATA(kernel_phys_addr, .quad  0)
+
+	.code16
+	.balign 4
+	# Careful these need to be in the same 64K segment as the above;
+tidt_bsp:
+	.word	0			# idt limit = 0
+	.word	0, 0			# idt base = 0L
+
+	# Duplicate the global descriptor table
+	# so the kernel can live anywhere
+	.balign 4
+tgdt_bsp:
+	.short	tgdt_bsp_end - tgdt_bsp		# gdt limit
+	.long	tgdt_bsp - bsp_base
+	.short 0
+	.quad	0x00cf9b000000ffff	# __KERNEL32_CS
+	.quad	0x00af9b000000ffff	# __KERNEL_CS
+	.quad	0x00cf93000000ffff	# __KERNEL_DS
+tgdt_bsp_end:
+
+	.code64
+	.balign 4
+gdt_bsp_64:
+        .word   gdt_bsp_64_end - gdt_bsp_64
+        .long   gdt_bsp_64 - bsp_base
+        .word   0
+        .quad   0x0000000000000000      /* NULL descriptor */
+        .quad   0x00af9a000000ffff      /* __KERNEL_CS */
+        .quad   0x00cf92000000ffff      /* __KERNEL_DS */
+        .quad   0x0080890000000000      /* TS descriptor */
+        .quad   0x0000000000000000      /* TS continued */
+gdt_bsp_64_end:
+
+	.code16
+	.balign 4
+startup_32_vector_bsp:
+	.long	startup_32_bsp - bsp_base
+	.word	__KERNEL32_CS, 0
+
+	.balign 4
+startup_64_vector_bsp:
+	.long	startup_64_bsp - bsp_base
+	.word	__KERNEL_CS, 0
+
+	.balign 4
+SYM_DATA(trampoline_status_bsp, .long	0)
+
+	.balign 4
+SYM_DATA(trampoline_location, .quad   0)
+
+trampoline_stack_bsp:
+	.fill 512,8,0
+trampoline_stack_bsp_end:
+
+SYM_DATA(trampoline_bsp_end)
+
+/*
+ * Space for page tables (not in .bss so not zeroed)
+ */
+        .balign 4096
+pgtable_bsp:
+        .fill 6*4096, 1, 0
+pgtable_extra_bsp:
+	.fill 1*4096, 1, 0
+
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index d7af4a64c211..38e16ed2b3fb 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -228,6 +228,12 @@ SECTIONS
 
 	INIT_DATA_SECTION(16)
 
+         .x86_trampoline_bsp : AT(ADDR(.x86_trampoline_bsp) - LOAD_OFFSET) {
+                x86_trampoline_bsp_start = .;
+                *(.x86_trampoline_bsp)
+                x86_trampoline_bsp_end = .;
+        }
+
 	.x86_cpu_dev.init : AT(ADDR(.x86_cpu_dev.init) - LOAD_OFFSET) {
 		__x86_cpu_dev_start = .;
 		*(.x86_cpu_dev.init)
-- 
2.34.1


