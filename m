Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20353CD1292
	for <kexec@archiver.kernel.org>; Mon,  8 Apr 2024 07:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=36f/sII29uiPhY9e7UPIs6i48uoo7FKPDNpcdmJw1Rc=; b=daMFiCBuOFmuHZ
	NQxrwOKCv/d4PgmCqivJCUNgd1XI69zkqMaKUPF+ETE/yj430VIfRtqOnb2Fshxl1APgduU5lMG7x
	RVCNRXJqd+vrXezwy3zvtiUk+/w5f8w4jUhUo/fC9LosPcXkADCCZ3/IWVsm5bJX7zrilgTNWzYS1
	A9P/3xOkEGiXxn/rEhDTi9bsYkbTG7O7aBQQ5QEkMaUQmazex7tJT13qGvyS1DBsc1cpHmFfvW5K5
	+Q4lrh+OCk78oRdm2b9tlxlsK2o/zQ//qOcWVbjwkvsdG97k5uiHsxjKFGLqTOW7wYn99cJl9E3VV
	MV+ZwRJHQiEY1VkBFAEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjdc-0000000Ehw0-0u95;
	Mon, 08 Apr 2024 07:41:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjd8-0000000EhgS-2VS7
	for kexec@bombadil.infradead.org;
	Mon, 08 Apr 2024 07:41:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=qBz+6MoELVQnUMZa9n7w3A3evFvy0Fek5qi68qGryiU=; b=HCbrtA7DtI323MHDmUvwvRvaoY
	2GoK2srhiagJ5TGDxTNOmw7wb9ZvqCliRFowxehv+b43JrGxARD3NDb0Vb6vviCTbCqB+I5U9kHod
	9haU03PFXjR7e50t++e+a2PvYoMFnOXkwqeyGIdEtCPeFlvU5pUtOZdHavWd85gEZ+Rdl/mdx3gXq
	Yf7uvV0Gyouwn6T0y54wwrH+UeqgOKBsyF04kgWHlspcgj6BsdCddkB8vok4yCTaCkxDxuGbA2daP
	uBXiqLH8achCR+xuoxm4M0TOQZvpD4C9b7jFbg2cMcBH7RCiZahtnFptRWuzu+cuWDKo5EqiEQlOC
	GiaRch+Q==;
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjcu-000000071t3-2vnO
	for kexec@lists.infradead.org;
	Mon, 08 Apr 2024 07:41:15 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-416632343d0so5899225e9.0
        for <kexec@lists.infradead.org>; Mon, 08 Apr 2024 00:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712562069; x=1713166869; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBz+6MoELVQnUMZa9n7w3A3evFvy0Fek5qi68qGryiU=;
        b=QU8kDU41WfNt/df4A2sXMmeDk3F3epA0p4kc+62O0yk7+NUB45KaMQmFSPU2/GDjli
         YYHv/OM/mcyoT/IQCPAhupCBrSj4Nmu8v0sQSeZQq4PtUILyPCc5A+DYDkWVQpELKjjU
         yuokaFwhLEOCoeHCpyFW4HReLK+ZGfNzQgY5j99kjrIC67W+Vn6/YPuJjWSySzL7uAOM
         oK3yNMlCk9P0NbZSwT9tV3PEH5gxO8JLN9f13FYZcRia+8sysE+DC1RDIhR1keLQ2wgl
         tV/bWmTEwFiK1y/S4SDLX34m757CCw0IP9QFX07f6zV7N4Za1DWXVbcdvR6bBITuDZbR
         iRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562069; x=1713166869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBz+6MoELVQnUMZa9n7w3A3evFvy0Fek5qi68qGryiU=;
        b=blmeXjoeuxdKtn4+PgzPs/u29Ltx6+DXsJKHoxl0XEXd/uu6lPzyVZz5HVaRbyXBuU
         JShbVwWj/UM7mhJdYAS7yYGdtxQzJQL3sAgVZ8ygAgVEL3CLETFpxyWeaR7aE09voyqA
         +5bhgXtbNbkt1QLpG00t2KaJrfDDIEisoFnt82bJdyozRPo98HInma454ulTkVV1ZuZ5
         aFJYuctZq5Udx6AZ4cnhjAiHj9/X6l1iPxpc0SnWqAr/GgYU8g4VsjrSeCeCODdwjvGJ
         V7gKt3/dPfw1vcqI2HbPAMRh3NQSsTEbaN6UXFKF2szxveJLfQ2NmAP4T6+CZCW6j2bC
         D6iA==
X-Forwarded-Encrypted: i=1; AJvYcCUZiGCtg5ufl0hgr6DjP+ttXRMkTx7nfO0bl6HfJ5mJ8Gmr758BzK756s3kpunfqUrSSY/GX9jozVVs/gzjgFqk8zpUxpmw8M6D
X-Gm-Message-State: AOJu0YyFhUOe0AI4mjAU+z6aSTDxe40ithBaciH6yUEzGUpw4HO+rCe6
	OEhIlMwdYc+rvjXxvhCoEJ5gWqC5PQcqZDWHW0hZbTKNxctkG4FS
X-Google-Smtp-Source: AGHT+IHsUi45Aoz43ARNJjpf0g3ZQA1epXwxOoGi6oZcBnv+nq+Bwyv8I8u8eNRtwrpR5Xd5fHHZCQ==
X-Received: by 2002:a05:600c:1e18:b0:416:33d8:84ae with SMTP id ay24-20020a05600c1e1800b0041633d884aemr3878435wmb.24.1712562069340;
        Mon, 08 Apr 2024 00:41:09 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab70:9c00:7f0b:c18e:56a6:4f2])
        by smtp.gmail.com with ESMTPSA id j3-20020adfff83000000b00341e2146b53sm8271413wrr.106.2024.04.08.00.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:41:08 -0700 (PDT)
From: vsntk18@gmail.com
To: x86@kernel.org
Cc: cfir@google.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	ebiederm@xmission.com,
	erdemaktas@google.com,
	hpa@zytor.com,
	jgross@suse.com,
	jroedel@suse.de,
	jslaby@suse.cz,
	keescook@chromium.org,
	kexec@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	luto@kernel.org,
	martin.b.radev@gmail.com,
	mhiramat@kernel.org,
	mstunes@vmware.com,
	nivedita@alum.mit.edu,
	peterz@infradead.org,
	rientjes@google.com,
	seanjc@google.com,
	stable@vger.kernel.org,
	thomas.lendacky@amd.com,
	virtualization@lists.linux-foundation.org,
	vkarasulli@suse.de,
	ashish.kalra@amd.com,
	michael.roth@amd.com,
	Borislav.Petkov@amd.com,
	Dhaval.Giani@amd.com
Subject: [PATCH v5 04/10] x86/sev: Setup code to park APs in the AP Jump Table
Date: Mon,  8 Apr 2024 09:40:43 +0200
Message-Id: <20240408074049.7049-5-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408074049.7049-1-vsntk18@gmail.com>
References: <20240408074049.7049-1-vsntk18@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_084113_428129_0C0E04FE 
X-CRM114-Status: GOOD (  37.81  )
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

From: Joerg Roedel <jroedel@suse.de>

The AP jump table under SEV-ES contains the reset vector where non-boot
CPUs start executing when coming out of reset. This means that a CPU
coming out of the AP-reset-hold VMGEXIT also needs to start executing at
the reset vector stored in the AP jump table.

The problem is to find a safe place to put the real-mode code which
executes the VMGEXIT and jumps to the reset vector. The code can not be
in kernel memory, because after kexec that memory is owned by the new
kernel and the code might have been overwritten.

Fortunately the AP jump table itself is a safe place, because the
memory is not owned by the OS and will not be overwritten by a new
kernel started through kexec. The table is 4k in size and only the
first 4 bytes are used for the reset vector. This leaves enough space
for some 16-bit code to do the job and even a small stack.

The AP jump table must be 4K in size, in encrypted memory and it must
be 4K (page) aligned. There can only be one AP jump table and it
should reside in memory that has been marked as reserved by UEFI.

Install 16-bit code into the AP jump table under SEV-ES.
The code will do an AP-reset-hold VMGEXIT and jump to the
reset vector after being woken up.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
 arch/x86/include/asm/realmode.h         |   2 +
 arch/x86/include/asm/sev-ap-jumptable.h |  30 ++++++
 arch/x86/kernel/sev.c                   |  94 ++++++++++++++---
 arch/x86/realmode/Makefile              |   9 +-
 arch/x86/realmode/rmpiggy.S             |   6 ++
 arch/x86/realmode/sev/Makefile          |  33 ++++++
 arch/x86/realmode/sev/ap_jump_table.S   | 131 ++++++++++++++++++++++++
 arch/x86/realmode/sev/ap_jump_table.lds |  24 +++++
 8 files changed, 316 insertions(+), 13 deletions(-)
 create mode 100644 arch/x86/include/asm/sev-ap-jumptable.h
 create mode 100644 arch/x86/realmode/sev/Makefile
 create mode 100644 arch/x86/realmode/sev/ap_jump_table.S
 create mode 100644 arch/x86/realmode/sev/ap_jump_table.lds

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 87e5482acd0d..bd54a48fe077 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -63,6 +63,8 @@ extern unsigned long initial_code;
 extern unsigned long initial_stack;
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern unsigned long initial_vc_handler;
+extern unsigned char rm_ap_jump_table_blob[];
+extern unsigned char rm_ap_jump_table_blob_end[];
 #endif
 
 extern u32 *trampoline_lock;
diff --git a/arch/x86/include/asm/sev-ap-jumptable.h b/arch/x86/include/asm/sev-ap-jumptable.h
new file mode 100644
index 000000000000..17b07fb19297
--- /dev/null
+++ b/arch/x86/include/asm/sev-ap-jumptable.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD Encrypted Register State Support
+ *
+ * Author: Joerg Roedel <jroedel@suse.de>
+ */
+#ifndef __ASM_SEV_AP_JUMPTABLE_H
+#define __ASM_SEV_AP_JUMPTABLE_H
+
+#define	SEV_APJT_CS16	0x8
+#define	SEV_APJT_DS16	0x10
+#define	SEV_RM_DS	0x18
+
+#define SEV_APJT_ENTRY	0x10
+
+#ifndef __ASSEMBLY__
+
+/*
+ * The reset_ip and reset_cs members are fixed and defined through the GHCB
+ * specification. Do not change or move them around.
+ */
+struct sev_ap_jump_table_header {
+	u16	reset_ip;
+	u16	reset_cs;
+	u16	ap_jumptable_gdt;
+} __packed;
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_SEV_AP_JUMPTABLE_H */
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 098f590f7bec..91f84b8bfa28 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -26,6 +26,7 @@
 #include <linux/dmi.h>
 #include <uapi/linux/sev-guest.h>
 
+#include <asm/sev-ap-jumptable.h>
 #include <asm/init.h>
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -92,6 +93,9 @@ static struct ghcb *boot_ghcb __section(".data");
 /* Bitmap of SEV features supported by the hypervisor */
 static u64 sev_hv_features __ro_after_init;
 
+/* Whether the AP jump table blob was successfully installed */
+static bool sev_ap_jumptable_blob_installed __ro_after_init;
+
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
@@ -670,12 +674,12 @@ static u64 __init get_snp_jump_table_addr(void)
 	return addr;
 }
 
-static u64 __init get_jump_table_addr(void)
+static phys_addr_t __init get_jump_table_addr(void)
 {
 	struct ghcb_state state;
 	unsigned long flags;
 	struct ghcb *ghcb;
-	u64 ret = 0;
+	phys_addr_t jump_table_pa;
 
 	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return get_snp_jump_table_addr();
@@ -694,13 +698,13 @@ static u64 __init get_jump_table_addr(void)
 
 	if (ghcb_sw_exit_info_1_is_valid(ghcb) &&
 	    ghcb_sw_exit_info_2_is_valid(ghcb))
-		ret = ghcb->save.sw_exit_info_2;
+		jump_table_pa = ghcb->save.sw_exit_info_2;
 
 	__sev_put_ghcb(&state);
 
 	local_irq_restore(flags);
 
-	return ret;
+	return jump_table_pa;
 }
 
 static void __head
@@ -1135,38 +1139,104 @@ void __init snp_set_wakeup_secondary_cpu(void)
 	apic_update_callback(wakeup_secondary_cpu, wakeup_cpu_via_vmgexit);
 }
 
+/*
+ * Make the necessary runtime changes to the AP jump table blob.  For now this
+ * only sets up the GDT used while the code executes. The GDT needs to contain
+ * 16-bit code and data segments with a base that points to AP jump table page.
+ */
+void __init sev_es_setup_ap_jump_table_data(void *base, u32 pa)
+{
+	struct sev_ap_jump_table_header *header;
+	struct desc_ptr *gdt_descr;
+	u64 *ap_jumptable_gdt;
+
+	header = base;
+
+	/*
+	 * Setup 16-bit protected mode code and data segments for AP jump table.
+	 * Set the segment limits to 0xffff to already be compatible with
+	 * real-mode.
+	 */
+	ap_jumptable_gdt = (u64 *)(base + header->ap_jumptable_gdt);
+	ap_jumptable_gdt[SEV_APJT_CS16 / 8] = GDT_ENTRY(0x9b, pa, 0xffff);
+	ap_jumptable_gdt[SEV_APJT_DS16 / 8] = GDT_ENTRY(0x93, pa, 0xffff);
+	ap_jumptable_gdt[SEV_RM_DS / 8] = GDT_ENTRY(0x93, 0, 0xffff);
+
+	/* Write correct GDT base address into GDT descriptor */
+	gdt_descr = (struct desc_ptr *)(base + header->ap_jumptable_gdt);
+	gdt_descr->address += pa;
+}
+
+/*
+ * Set up the AP jump table blob which contains code which runs in 16-bit
+ * protected mode to park an AP. After the AP is woken up again the code will
+ * disable protected mode and jump to the reset vector which is also stored in
+ * the AP jump table.
+ *
+ * The jump table is a safe place to park an AP, because it is owned by the
+ * BIOS and writable by the OS. Putting the code in kernel memory would break
+ * with kexec, because by the time the APs wake up the memory is owned by
+ * the new kernel, and possibly already overwritten.
+ *
+ * Kexec is also the reason this function is an init-call after SMP bringup.
+ * Only after all CPUs are up there is a guarantee that no AP is still parked in
+ * AP jump-table code.
+ */
 int __init sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
 {
 	u16 startup_cs, startup_ip;
-	phys_addr_t jump_table_pa;
-	u64 jump_table_addr;
 	u16 __iomem *jump_table;
+	phys_addr_t pa;
+	size_t blob_size = rm_ap_jump_table_blob_end - rm_ap_jump_table_blob;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+		return 0;
+
+	if (ghcb_info.vm_proto < 2) {
+		pr_warn("AP jump table parking requires at least GHCB protocol version 2\n");
+		return 0;
+	}
 
-	jump_table_addr = get_jump_table_addr();
+	pa = get_jump_table_addr();
 
 	/* On UP guests there is no jump table so this is not a failure */
-	if (!jump_table_addr)
+	if (!pa)
 		return 0;
 
-	/* Check if AP Jump Table is page-aligned */
-	if (jump_table_addr & ~PAGE_MASK)
+	/* Check if AP jump table is page-aligned */
+	if (pa & ~PAGE_MASK)
 		return -EINVAL;
 
-	jump_table_pa = jump_table_addr & PAGE_MASK;
+	/* Check overflow and size for untrusted jump table address */
+	if (pa + PAGE_SIZE < pa || pa + PAGE_SIZE > SZ_4G) {
+		pr_info("AP jump table is above 4GB or address overflow - not enabling AP jump table parking\n");
+		return -EINVAL;
+	}
 
 	startup_cs = (u16)(rmh->trampoline_start >> 4);
 	startup_ip = (u16)(rmh->sev_es_trampoline_start -
 			   rmh->trampoline_start);
 
-	jump_table = ioremap_encrypted(jump_table_pa, PAGE_SIZE);
+	jump_table = ioremap_encrypted(pa, PAGE_SIZE);
 	if (!jump_table)
 		return -EIO;
 
+	/* Install AP jump table Blob with real mode AP parking code */
+	memcpy_toio(jump_table, rm_ap_jump_table_blob, blob_size);
+
+	/* Setup AP jump table GDT */
+	sev_es_setup_ap_jump_table_data(jump_table, (u32)pa);
+
 	writew(startup_ip, &jump_table[0]);
 	writew(startup_cs, &jump_table[1]);
 
 	iounmap(jump_table);
 
+	pr_info("AP jump table Blob successfully set up\n");
+
+	/* Mark AP jump table blob as available */
+	sev_ap_jumptable_blob_installed = true;
+
 	return 0;
 }
 
diff --git a/arch/x86/realmode/Makefile b/arch/x86/realmode/Makefile
index a0b491ae2de8..00f3cceb9580 100644
--- a/arch/x86/realmode/Makefile
+++ b/arch/x86/realmode/Makefile
@@ -11,12 +11,19 @@
 KASAN_SANITIZE			:= n
 KCSAN_SANITIZE			:= n
 
+RMPIGGY-y				 = $(obj)/rm/realmode.bin
+RMPIGGY-$(CONFIG_AMD_MEM_ENCRYPT)	+= $(obj)/sev/ap_jump_table.bin
+
 subdir- := rm
+subdir- := sev
 
 obj-y += init.o
 obj-y += rmpiggy.o
 
-$(obj)/rmpiggy.o: $(obj)/rm/realmode.bin
+$(obj)/rmpiggy.o: $(RMPIGGY-y)
 
 $(obj)/rm/realmode.bin: FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/rm $@
+
+$(obj)/sev/ap_jump_table.bin: FORCE
+	$(Q)$(MAKE) $(build)=$(obj)/sev $@
diff --git a/arch/x86/realmode/rmpiggy.S b/arch/x86/realmode/rmpiggy.S
index c8fef76743f6..a659f98617ff 100644
--- a/arch/x86/realmode/rmpiggy.S
+++ b/arch/x86/realmode/rmpiggy.S
@@ -17,3 +17,9 @@ SYM_DATA_END_LABEL(real_mode_blob, SYM_L_GLOBAL, real_mode_blob_end)
 SYM_DATA_START(real_mode_relocs)
 	.incbin	"arch/x86/realmode/rm/realmode.relocs"
 SYM_DATA_END(real_mode_relocs)
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+SYM_DATA_START(rm_ap_jump_table_blob)
+	.incbin "arch/x86/realmode/sev/ap_jump_table.bin"
+SYM_DATA_END_LABEL(rm_ap_jump_table_blob, SYM_L_GLOBAL, rm_ap_jump_table_blob_end)
+#endif
diff --git a/arch/x86/realmode/sev/Makefile b/arch/x86/realmode/sev/Makefile
new file mode 100644
index 000000000000..7cf5f31f6419
--- /dev/null
+++ b/arch/x86/realmode/sev/Makefile
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# Sanitizer runtimes are unavailable and cannot be linked here.
+KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
+OBJECT_FILES_NON_STANDARD	:= y
+
+# Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
+KCOV_INSTRUMENT		:= n
+
+always-y 	:= ap_jump_table.bin
+ap_jump_table-y	+= ap_jump_table.o
+targets		+= $(ap_jump_table-y)
+
+APJUMPTABLE_OBJS = $(addprefix $(obj)/,$(ap_jump_table-y))
+
+LDFLAGS_ap_jump_table.elf := -m elf_i386 -T
+
+targets 	+= ap_jump_table.elf
+$(obj)/ap_jump_table.elf: $(obj)/ap_jump_table.lds $(APJUMPTABLE_OBJS) FORCE
+	$(call if_changed,ld)
+
+OBJCOPYFLAGS_ap_jump_table.bin := -O binary
+
+targets 	+= ap_jump_table.bin
+$(obj)/ap_jump_table.bin: $(obj)/ap_jump_table.elf FORCE
+	$(call if_changed,objcopy)
+
+# ---------------------------------------------------------------------------
+
+KBUILD_AFLAGS	:= $(REALMODE_CFLAGS) -D__ASSEMBLY__
+GCOV_PROFILE := n
+UBSAN_SANITIZE := n
diff --git a/arch/x86/realmode/sev/ap_jump_table.S b/arch/x86/realmode/sev/ap_jump_table.S
new file mode 100644
index 000000000000..b3523612a9b0
--- /dev/null
+++ b/arch/x86/realmode/sev/ap_jump_table.S
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/linkage.h>
+#include <asm/msr-index.h>
+#include <asm/sev-ap-jumptable.h>
+
+/*
+ * This file contains the source code for the binary blob which gets copied to
+ * the SEV-ES AP jump table to park APs while offlining CPUs or booting a new
+ * kernel via KEXEC.
+ *
+ * The AP jump table is the only safe place to put this code, as any memory the
+ * kernel allocates will be owned (and possibly overwritten) by the new kernel
+ * once the APs are woken up.
+ *
+ * This code runs in 16-bit protected mode, the CS, DS, and SS segment bases are
+ * set to the beginning of the AP jump table page.
+ *
+ * Since the GDT will also be gone when the AP wakes up, this blob contains its
+ * own GDT, which is set up by the AP jump table setup code with the correct
+ * offsets.
+ *
+ * Author: Joerg Roedel <jroedel@suse.de>
+ */
+
+	.text
+	.org 0x0
+	.code16
+SYM_DATA_START(ap_jumptable_header)
+	.word	0			/* reset IP */
+	.word	0			/* reset CS */
+	.word	ap_jumptable_gdt	/* GDT Offset   */
+SYM_DATA_END(ap_jumptable_header)
+
+	.org	SEV_APJT_ENTRY
+SYM_CODE_START(ap_park)
+
+	/* Switch to AP jump table GDT first */
+	lgdtl	ap_jumptable_gdt
+
+	/* Reload CS */
+	ljmpw	$SEV_APJT_CS16, $1f
+1:
+
+	/* Reload DS and SS */
+	movl	$SEV_APJT_DS16, %ecx
+	movl	%ecx, %ds
+	movl	%ecx, %ss
+
+	/*
+	 * Setup a stack pointing to the end of the AP jump table page.
+	 * The stack is needed to reset EFLAGS after wakeup.
+	 */
+	movl	$0x1000, %esp
+
+	/* Execute AP reset hold VMGEXIT */
+2:	xorl	%edx, %edx
+	movl	$0x6, %eax
+	movl	$MSR_AMD64_SEV_ES_GHCB, %ecx
+	wrmsr
+	rep; vmmcall
+	rdmsr
+	movl	%eax, %ecx
+	andl	$0xfff, %ecx
+	cmpl	$0x7, %ecx
+	jne	2b
+	shrl	$12, %eax
+	jnz	3f
+	testl	%edx, %edx
+	jnz	3f
+	jmp	2b
+3:
+	/*
+	 * Successfully woken up - patch the correct target into the far jump at
+	 * the end. An indirect far jump does not work here, because at the time
+	 * the jump is executed DS is already loaded with real-mode values.
+	 */
+
+	/* Jump target is at address 0x0 - copy it to the far jump instruction */
+	movl	$0, %ecx
+	movl	(%ecx), %eax
+	movl	%eax, jump_target
+
+	/* Set EFLAGS to reset value (bit 1 is hard-wired to 1) */
+	pushl	$2
+	popfl
+
+	/* Setup DS and SS for real-mode */
+	movl	$0x18, %ecx
+	movl	%ecx, %ds
+	movl	%ecx, %ss
+
+	/* Reset remaining registers */
+	movl	$0, %esp
+	movl	$0, %eax
+	movl	$0, %ebx
+	movl	$0, %edx
+
+	/* Set CR0 to reset value to drop out of protected mode */
+	movl	$0x60000010, %ecx
+	movl	%ecx, %cr0
+
+	/*
+	 * The below sums up to a far-jump instruction which jumps to the reset
+	 * vector configured in the AP jump table and to real-mode. An indirect
+	 * jump would be cleaner, but requires a working DS base/limit. DS is
+	 * already loaded with real-mode values, therefore a direct far jump is
+	 * used which got the correct target patched in.
+	 */
+	.byte	0xea
+SYM_DATA_LOCAL(jump_target, .long 0)
+
+SYM_CODE_END(ap_park)
+	/* Here comes the GDT */
+	.balign	16
+SYM_DATA_START_LOCAL(ap_jumptable_gdt)
+	/* Offset zero used for GDT descriptor */
+	.word	ap_jumptable_gdt_end - ap_jumptable_gdt - 1
+	.long	ap_jumptable_gdt
+	.word	0
+
+	/* 16 bit code segment - setup at boot */
+	.quad 0
+
+	/* 16 bit data segment - setup at boot */
+	.quad 0
+
+	/* Offset 0x18 - real-mode data segment - setup at boot */
+	.long	0
+	.long	0
+SYM_DATA_END_LABEL(ap_jumptable_gdt, SYM_L_LOCAL, ap_jumptable_gdt_end)
diff --git a/arch/x86/realmode/sev/ap_jump_table.lds b/arch/x86/realmode/sev/ap_jump_table.lds
new file mode 100644
index 000000000000..4e47f1a6eb4e
--- /dev/null
+++ b/arch/x86/realmode/sev/ap_jump_table.lds
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * ap_jump_table.lds
+ *
+ * Linker script for the SEV-ES AP jump table code
+ */
+
+OUTPUT_FORMAT("elf32-i386")
+OUTPUT_ARCH(i386)
+ENTRY(ap_park)
+
+SECTIONS
+{
+	. = 0;
+	.text : {
+		*(.text)
+		*(.text.*)
+	}
+
+	/DISCARD/ : {
+		*(.note*)
+		*(.debug*)
+	}
+}
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
