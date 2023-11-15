Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DC9C47075
	for <kexec@archiver.kernel.org>; Wed, 15 Nov 2023 12:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7cs4g+wt0UhVcmA20pjWo/CMDZT/rq7AsFQw/qTmtyM=; b=3X5ogq6edHmEJ0
	uOBDJu3cVvkARIIl3VrXbvmTmEqy3qKxpN3CaZxKJgwnWP3M3QPup8xrQqgPAEJoR48K0wMJ5oK4S
	DoOlcyPj4P6fvG7hlIcfksrFMMNBJVGhH3g8fViy49pCkKw5UleEutB8mdyNVT7ePWVgl4iQgo1Z8
	Hvx802Bm3mZHhPSyHVPFBq+9hZb0LL0o4g3EHm1bii6qp75vqLJ7PrihI7Xul/JAWL6BcHl6sG60u
	KPR8Ekx79CokG9Xpm4V5papF8Hj7CRpjxhHdW5UNA1MsWFLJ/OVVGZ1728N6JXETgYg4gnLlNY2ey
	VXoCF68Y1s+mU+SuB90A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3EaN-000jXg-36;
	Wed, 15 Nov 2023 12:01:36 +0000
Received: from mgamail.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3EaH-000jND-1A
	for kexec@lists.infradead.org;
	Wed, 15 Nov 2023 12:01:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700049689; x=1731585689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SVI78euvAk0U701k4eLRPlkAOqug1C4uO3/cEzD2QNo=;
  b=h5/yq9QF4ydp5ZT65NWRcMr3dy1BDpScETF1GAM++MI6SK3lkqJE2s07
   lGWV2Yz3b/VzXkOELfQVkYlbkRDPjTehD4VUW+XIuyE7fbnNKdrSTuT0a
   S6X6YXxGhMiAKbRUx+s7jM8eOifjUR9k+FneXRVU3UzI0DFCUIolu1G38
   lcdA1MIwkNbZR+nmdIWPom0fTyC1K1XOtk1eRvxtdkK9+o6PUPAxWhKZY
   HqMuBam93R5YdIsaihP+/yaDnSQQGcWh1q26fS7WZ2Z7MvR1wZRLyv/zq
   oZL7F/92TL3Oy0P9VHschSyeDtV/69Gt9RVvqkfqd7eYOEgYgKXcT3VqP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="394780461"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="394780461"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 04:01:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="13160257"
Received: from mituomis-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.44.135])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 04:01:21 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 9D17410A31C; Wed, 15 Nov 2023 15:01:12 +0300 (+03)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 10/14] x86/tdx: Convert shared memory back to private on kexec
Date: Wed, 15 Nov 2023 15:00:40 +0300
Message-ID: <20231115120044.8034-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231115_040129_470374_C49B63B5 
X-CRM114-Status: GOOD (  27.20  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

TDX guests allocate shared buffers to perform I/O. It is done by
allocating pages normally from the buddy allocator and converting them
to shared with set_memory_decrypted().

The second kernel has no idea what memory is converted this way. It only
sees E820_TYPE_RAM.

Accessing shared memory via private mapping is fatal. It leads to
unrecoverable TD exit.

On kexec walk direct mapping and convert all shared memory back to
private. It makes all RAM private again and second kernel may use it
normally.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/kexec.c       |   0
 arch/x86/coco/tdx/tdx.c         | 120 +++++++++++++++++++++++++++++++-
 arch/x86/include/asm/x86_init.h |   1 +
 arch/x86/kernel/crash.c         |   4 ++
 arch/x86/kernel/reboot.c        |   5 ++
 5 files changed, 128 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/coco/tdx/kexec.c

diff --git a/arch/x86/coco/tdx/kexec.c b/arch/x86/coco/tdx/kexec.c
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 039f81b7c172..20e946c9a39d 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -6,14 +6,17 @@
 
 #include <linux/cpufeature.h>
 #include <linux/debugfs.h>
+#include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/kexec.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
+#include <asm/set_memory.h>
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -40,6 +43,9 @@
 
 static atomic_long_t nr_shared;
 
+static atomic_t conversions_in_progress;
+static bool conversion_allowed = true;
+
 static inline bool pte_decrypted(pte_t pte)
 {
 	return cc_mkdec(pte_val(pte)) == pte_val(pte);
@@ -725,6 +731,14 @@ static bool tdx_tlb_flush_required(bool private)
 
 static bool tdx_cache_flush_required(void)
 {
+	/*
+	 * Avoid issuing CLFLUSH on set_memory_decrypted() if conversions
+	 * stopped. Otherwise it can race with unshare_all_memory() and trigger
+	 * implicit conversion to shared.
+	 */
+	if (!conversion_allowed)
+		return false;
+
 	/*
 	 * AMD SME/SEV can avoid cache flushing if HW enforces cache coherence.
 	 * TDX doesn't have such capability.
@@ -808,12 +822,25 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 static int tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
 					 bool enc)
 {
+	atomic_inc(&conversions_in_progress);
+
+	/*
+	 * Check after bumping conversions_in_progress to serialize
+	 * against tdx_shutdown().
+	 */
+	if (!conversion_allowed) {
+		atomic_dec(&conversions_in_progress);
+		return -EBUSY;
+	}
+
 	/*
 	 * Only handle shared->private conversion here.
 	 * See the comment in tdx_early_init().
 	 */
-	if (enc && !tdx_enc_status_changed(vaddr, numpages, enc))
+	if (enc && !tdx_enc_status_changed(vaddr, numpages, enc)) {
+		atomic_dec(&conversions_in_progress);
 		return -EIO;
+	}
 
 	return 0;
 }
@@ -825,17 +852,104 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 	 * Only handle private->shared conversion here.
 	 * See the comment in tdx_early_init().
 	 */
-	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc))
+	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc)) {
+		atomic_dec(&conversions_in_progress);
 		return -EIO;
+	}
 
 	if (enc)
 		atomic_long_sub(numpages, &nr_shared);
 	else
 		atomic_long_add(numpages, &nr_shared);
 
+	atomic_dec(&conversions_in_progress);
+
 	return 0;
 }
 
+static void tdx_kexec_unshare_mem(bool crash)
+{
+	unsigned long addr, end;
+	long found = 0, shared;
+
+	/* Stop new private<->shared conversions */
+	conversion_allowed = false;
+
+	/*
+	 * Crash kernel reaches here with interrupts disabled: can't wait for
+	 * conversions to finish.
+	 *
+	 * If race happened, just report and proceed.
+	 */
+	if (!crash) {
+		unsigned long timeout;
+
+		/*
+		 * Wait for in-flight conversions to complete.
+		 *
+		 * Do not wait more than 30 seconds.
+		 */
+		timeout = 30 * USEC_PER_SEC;
+		while (atomic_read(&conversions_in_progress) && timeout--)
+			udelay(1);
+	}
+
+	if (atomic_read(&conversions_in_progress))
+		pr_warn("Failed to finish shared<->private conversions\n");
+
+	/*
+	 * Walk direct mapping and convert all shared memory back to private,
+	 */
+
+	addr = PAGE_OFFSET;
+	end  = PAGE_OFFSET + get_max_mapped();
+
+	while (addr < end) {
+		unsigned long size;
+		unsigned int level;
+		pte_t *pte;
+
+		pte = lookup_address(addr, &level);
+		size = page_level_size(level);
+
+		if (pte && pte_decrypted(*pte)) {
+			int pages = size / PAGE_SIZE;
+
+			/*
+			 * Touching memory with shared bit set triggers implicit
+			 * conversion to shared.
+			 *
+			 * Make sure nobody touches the shared range from
+			 * now on.
+			 *
+			 * Bypass unmapping for crash scenario. Unmapping
+			 * requires sleepable context, but in crash case kernel
+			 * hits the code path with interrupts disabled.
+			 * It shouldn't be a problem as all secondary CPUs are
+			 * down and kernel runs with interrupts disabled, so
+			 * there is no room for race.
+			 */
+			if (!crash)
+				set_memory_np(addr, pages);
+
+			if (!tdx_enc_status_changed(addr, pages, true)) {
+				pr_err("Failed to unshare range %#lx-%#lx\n",
+				       addr, addr + size);
+			}
+
+			found += pages;
+		}
+
+		addr += size;
+	}
+
+	shared = atomic_long_read(&nr_shared);
+	if (shared != found) {
+		pr_err("shared page accounting is off\n");
+		pr_err("nr_shared = %ld, nr_found = %ld\n", shared, found);
+	}
+}
+
 void __init tdx_early_init(void)
 {
 	struct tdx_module_args args = {
@@ -895,6 +1009,8 @@ void __init tdx_early_init(void)
 	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
 	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
 
+	x86_platform.guest.enc_kexec_unshare_mem     = tdx_kexec_unshare_mem;
+
 	/*
 	 * TDX intercepts the RDMSR to read the X2APIC ID in the parallel
 	 * bringup low level code. That raises #VE which cannot be handled
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index c9503fe2d13a..917358821a31 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -154,6 +154,7 @@ struct x86_guest {
 	int (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_tlb_flush_required)(bool enc);
 	bool (*enc_cache_flush_required)(void);
+	void (*enc_kexec_unshare_mem)(bool crash);
 };
 
 /**
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c92d88680dbf..1618224775f5 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -40,6 +40,7 @@
 #include <asm/intel_pt.h>
 #include <asm/crash.h>
 #include <asm/cmdline.h>
+#include <asm/tdx.h>
 
 /* Used while preparing memory map entries for second kernel */
 struct crash_memmap_data {
@@ -107,6 +108,9 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 
 	crash_smp_send_stop();
 
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		x86_platform.guest.enc_kexec_unshare_mem(true);
+
 	cpu_emergency_disable_virtualization();
 
 	/*
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 830425e6d38e..9fb302562bfd 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/objtool.h>
 #include <linux/pgtable.h>
+#include <linux/kexec.h>
 #include <acpi/reboot.h>
 #include <asm/io.h>
 #include <asm/apic.h>
@@ -31,6 +32,7 @@
 #include <asm/realmode.h>
 #include <asm/x86_init.h>
 #include <asm/efi.h>
+#include <asm/tdx.h>
 
 /*
  * Power off function, if any
@@ -716,6 +718,9 @@ static void native_machine_emergency_restart(void)
 
 void native_machine_shutdown(void)
 {
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) && kexec_in_progress)
+		x86_platform.guest.enc_kexec_unshare_mem(false);
+
 	/* Stop the cpus and apics */
 #ifdef CONFIG_X86_IO_APIC
 	/*
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
