Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC54CAC597
	for <kexec@archiver.kernel.org>; Thu, 18 Sep 2025 22:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T1dFsvQMxvcjtQz197QK9xl+/t1w6WalvHTZ6lHd38A=; b=OXFWEQrMMLxGs8JDtJ0aHA70EJ
	9LcFcwNBLHFIgn54wu0F68jFwAvvrBs8ako+CmITZbu+LdbCiIg/F9pvBMXF4Rr/+Y76d5FX/S4kz
	Ng3if2fUkhNFqPwyxYYqJXnzrCBfJU+6Nfg3E1vpt2GcBfshn8o+qSXp/fNou0UxE/c8oVFRWiGjs
	P0qnsiMMdYQSuS6Jr957+XnSU+Q/7vDBnATbL4CSnjloIGdgFLBv4RnhkgzVSM/Oyy93qf8mmdHjB
	cT7SJ8VRNO03OwV5UaF+nnf93sbWKXUtoxCUbg0d4X0PIqfBLfqjs2YaAifxJlm3BLOrhUD0cEv7d
	Qtw466uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzN57-00000001KGd-2QmG;
	Thu, 18 Sep 2025 22:26:25 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzN54-00000001KFX-3mYL
	for kexec@lists.infradead.org;
	Thu, 18 Sep 2025 22:26:24 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-77b91ed5546so1370124b3a.2
        for <kexec@lists.infradead.org>; Thu, 18 Sep 2025 15:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758234382; x=1758839182; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1dFsvQMxvcjtQz197QK9xl+/t1w6WalvHTZ6lHd38A=;
        b=CJOlEt10FCq2g3IAHsEbuGi2WwCxkjGOT5X3yaRsIrPRIJVOn/cRiBFVwLL+5oKWHS
         WH+dd2VSz/skc8mZhwetihC32vHIcZQIVK/3GlrMo/4qJ3Alf30B8OEy/Adm5XT6xydV
         EN7MXf12xRVyIqnWQcdzTqfnheda85IuJwS0g2I3K1l9kaFFXoeoUsDtOPIByBQacE39
         69Xtx2O2lnZQuvIzQdnVZFQkEIq/f3MAr2eKGufzfhdGU0U0v3LWHyF+tlrldpqdiFyf
         2YIG/n3VzrRGcsyYlAQqoA7I+3Iq7hdxrNxI4+9nixChE3T60/DVjC4qWSi1kWNsg2PK
         1JqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758234382; x=1758839182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1dFsvQMxvcjtQz197QK9xl+/t1w6WalvHTZ6lHd38A=;
        b=g59Lqhv59hTBfv7Iien6GwBFSp7OEHZuXDLn4patXHZy1aF+C8ezEs0jZyaIJnopHj
         WNqZmiZQcgK0K+aUtzMb77+XssOYAp3X4x84yMvGLZxoY6wOSz3Wkw4PoXPk32jxIcTV
         js6wpq2LlFgGGll6csq52+de6/DCK8BPAI8ggnH2vL1Cd3BPzjD7sZ3nKSovfA2L3TLc
         wNeIgxXoXmmAY6gRu/BaezovZDoNNCUZiHMlb2iBHI2/0BCRTJIZ6P1/A6mNcPbcv3Sz
         ASUjlIKMk9nutJdtWhNryTgq2k2PfzVTKK0NM+ThKETMbuF6Jt9PXfS5JtS118JuevGB
         M11w==
X-Forwarded-Encrypted: i=1; AJvYcCXw5i2m8eZYTnElBBuNMvbDew7mWMqKkJCTf7S6Ry9YfUTPjHd9lZ93FjYPAz1W3G1jjHD5Bw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyZPe3aoEQ/BGpkP9Dgp/vG60dx0V0ajgvCA+f3CnYVSY9QwYVF
	Mqkn65tUcdNn/MQHQGPqV0coZCMKllQWgiF/TRKI113LG1gscqwMAYvv
X-Gm-Gg: ASbGncu03ibzuxa1yLkSEcpfUH087aNyWc111xZf9MT0ViKvqY8zsuIfpNwcLVrRmZZ
	b6uxsqW+g+uDYtJGk3MGhnib8CctWZgV/w68AXlFcaqtK9Dtf12oy+V7fEL/+mSFaUBvpC31n84
	04EBNui/JVY9zfEkLSuEmJdQQOqpfHWRIKaxEicPSMaPH4iOXxdsfouAPk8JPTj431a8tooje9u
	Sk4uZasdB6Wpb5wjq5jmmZj8yg0OSnoZBotmyz/LA8cimxBAQP4Djn2jIDfi86wDGL6LKa5WmQz
	uq2N7hDDKOs9Qv52l3CnfzoU3EUH+GrdvcDfgmUP6AZsr0PCZ420yFfLYgVFU/7c0K12hT+rkcu
	TItn+ZCc4kUDOidwqpqZYN04cECTA0kJlk/XERyDXwebw+yI=
X-Google-Smtp-Source: AGHT+IHiSRMLDAqLw/Cik8QC7OKyXdyrkBpwegYIn++ScY0FjSln61N27eWeZhvArH7Hx9TmCQ0oyw==
X-Received: by 2002:a05:6a00:1bcd:b0:77e:87ea:ecac with SMTP id d2e1a72fcca58-77e87eaef9dmr281236b3a.24.1758234381924;
        Thu, 18 Sep 2025 15:26:21 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:c5c1:2e33:6cf2:beed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e5fe6de75sm407542b3a.19.2025.09.18.15.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 15:26:21 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch 1/7] kexec: Introduce multikernel support via kexec
Date: Thu, 18 Sep 2025 15:26:00 -0700
Message-Id: <20250918222607.186488-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_152622_969661_C765EE22 
X-CRM114-Status: GOOD (  34.75  )
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

This patch extends the kexec subsystem to support multikernel
functionality, allowing different kernel instances to be loaded and
executed on specific CPUs. The implementation introduces:

- New KEXEC_TYPE_MULTIKERNEL type and KEXEC_MULTIKERNEL flag

- multikernel_kick_ap() function for CPU-specific kernel booting

- LINUX_REBOOT_CMD_MULTIKERNEL reboot command with CPU parameter

- Specialized segment loading for multikernel images using memremap

- Integration with existing kexec infrastructure while bypassing
  standard machine_kexec_prepare() for avoiding resets

The multikernel_kexec() function validates CPU availability and uses
the existing kexec image start address to boot the target CPU with
a different kernel instance. This enables heterogeneous computing
scenarios where different CPUs can run specialized kernel variants.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/x86/include/asm/smp.h  |   1 +
 arch/x86/kernel/smpboot.c   | 104 +++++++++++++++++++++++++++
 include/linux/kexec.h       |   6 +-
 include/uapi/linux/kexec.h  |   1 +
 include/uapi/linux/reboot.h |   2 +-
 kernel/kexec.c              |  41 ++++++++++-
 kernel/kexec_core.c         | 135 ++++++++++++++++++++++++++++++++++++
 kernel/reboot.c             |  10 +++
 8 files changed, 294 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 22bfebe6776d..1a59fd0de759 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -107,6 +107,7 @@ void native_smp_prepare_cpus(unsigned int max_cpus);
 void native_smp_cpus_done(unsigned int max_cpus);
 int common_cpu_up(unsigned int cpunum, struct task_struct *tidle);
 int native_kick_ap(unsigned int cpu, struct task_struct *tidle);
+int multikernel_kick_ap(unsigned int cpu, unsigned long kernel_start_address);
 int native_cpu_disable(void);
 void __noreturn hlt_play_dead(void);
 void native_play_dead(void);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 33e166f6ab12..c2844a493ebf 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -833,6 +833,72 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
+// must be locked by cpus_read_lock()
+static int do_multikernel_boot_cpu(u32 apicid, int cpu, unsigned long kernel_start_address)
+{
+	unsigned long start_ip = real_mode_header->trampoline_start;
+	int ret;
+
+	pr_info("do_multikernel_boot_cpu(apicid=%u, cpu=%u, kernel_start_address=%lx)\n", apicid, cpu, kernel_start_address);
+#ifdef CONFIG_X86_64
+	/* If 64-bit wakeup method exists, use the 64-bit mode trampoline IP */
+	if (apic->wakeup_secondary_cpu_64)
+		start_ip = real_mode_header->trampoline_start64;
+#endif
+	//initial_code = (unsigned long)start_secondary;
+	initial_code = (unsigned long)kernel_start_address;
+
+	if (IS_ENABLED(CONFIG_X86_32)) {
+		early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(cpu);
+		//initial_stack  = idle->thread.sp;
+	} else if (!(smpboot_control & STARTUP_PARALLEL_MASK)) {
+		smpboot_control = cpu;
+	}
+
+	/* Skip init_espfix_ap(cpu); */
+
+	/* Skip announce_cpu(cpu, apicid); */
+
+	/*
+	 * This grunge runs the startup process for
+	 * the targeted processor.
+	 */
+	if (x86_platform.legacy.warm_reset) {
+
+		pr_debug("Setting warm reset code and vector.\n");
+
+		smpboot_setup_warm_reset_vector(start_ip);
+		/*
+		 * Be paranoid about clearing APIC errors.
+		*/
+		if (APIC_INTEGRATED(boot_cpu_apic_version)) {
+			apic_write(APIC_ESR, 0);
+			apic_read(APIC_ESR);
+		}
+	}
+
+	smp_mb();
+
+	/*
+	 * Wake up a CPU in difference cases:
+	 * - Use a method from the APIC driver if one defined, with wakeup
+	 *   straight to 64-bit mode preferred over wakeup to RM.
+	 * Otherwise,
+	 * - Use an INIT boot APIC message
+	 */
+	if (apic->wakeup_secondary_cpu_64)
+		ret = apic->wakeup_secondary_cpu_64(apicid, start_ip, cpu);
+	else if (apic->wakeup_secondary_cpu)
+		ret = apic->wakeup_secondary_cpu(apicid, start_ip, cpu);
+	else
+		ret = wakeup_secondary_cpu_via_init(apicid, start_ip, cpu);
+
+	pr_info("do_multikernel_boot_cpu end\n");
+	/* If the wakeup mechanism failed, cleanup the warm reset vector */
+	if (ret)
+		arch_cpuhp_cleanup_kick_cpu(cpu);
+	return ret;
+}
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
  * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
@@ -905,6 +971,44 @@ static int do_boot_cpu(u32 apicid, unsigned int cpu, struct task_struct *idle)
 	return ret;
 }
 
+// must be locked by cpus_read_lock()
+int multikernel_kick_ap(unsigned int cpu, unsigned long kernel_start_address)
+{
+	u32 apicid = apic->cpu_present_to_apicid(cpu);
+	int err;
+
+	lockdep_assert_irqs_enabled();
+
+	pr_info("++++++++++++++++++++=_---CPU UP  %u\n", cpu);
+
+	if (apicid == BAD_APICID || !apic_id_valid(apicid)) {
+		pr_err("CPU %u has invalid APIC ID %x. Aborting bringup\n", cpu, apicid);
+		return -EINVAL;
+	}
+
+	if (!test_bit(apicid, phys_cpu_present_map)) {
+		pr_err("CPU %u APIC ID %x is not present. Aborting bringup\n", cpu, apicid);
+		return -EINVAL;
+	}
+
+	/*
+	 * Save current MTRR state in case it was changed since early boot
+	 * (e.g. by the ACPI SMI) to initialize new CPUs with MTRRs in sync:
+	 */
+	mtrr_save_state();
+
+	/* the FPU context is blank, nobody can own it */
+	per_cpu(fpu_fpregs_owner_ctx, cpu) = NULL;
+	/* skip common_cpu_up(cpu, tidle); */
+
+	err = do_multikernel_boot_cpu(apicid, cpu, kernel_start_address);
+	if (err)
+		pr_err("do_multikernel_boot_cpu failed(%d) to wakeup CPU#%u\n", err, cpu);
+
+	return err;
+}
+
+
 int native_kick_ap(unsigned int cpu, struct task_struct *tidle)
 {
 	u32 apicid = apic->cpu_present_to_apicid(cpu);
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 39fe3e6cd282..a3ae3e561109 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -358,9 +358,10 @@ struct kimage {
 	unsigned long control_page;
 
 	/* Flags to indicate special processing */
-	unsigned int type : 1;
+	unsigned int type : 2;
 #define KEXEC_TYPE_DEFAULT 0
 #define KEXEC_TYPE_CRASH   1
+#define KEXEC_TYPE_MULTIKERNEL 2
 	unsigned int preserve_context : 1;
 	/* If set, we are using file mode kexec syscall */
 	unsigned int file_mode:1;
@@ -434,6 +435,7 @@ extern void machine_kexec(struct kimage *image);
 extern int machine_kexec_prepare(struct kimage *image);
 extern void machine_kexec_cleanup(struct kimage *image);
 extern int kernel_kexec(void);
+extern int multikernel_kexec(int cpu);
 extern struct page *kimage_alloc_control_pages(struct kimage *image,
 						unsigned int order);
 
@@ -455,7 +457,7 @@ bool kexec_load_permitted(int kexec_image_type);
 #define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR | KEXEC_CRASH_HOTPLUG_SUPPORT)
 #else
 #define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR | \
-			KEXEC_CRASH_HOTPLUG_SUPPORT)
+			KEXEC_CRASH_HOTPLUG_SUPPORT | KEXEC_MULTIKERNEL)
 #endif
 
 /* List of defined/legal kexec file flags */
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 8958ebfcff94..4ed8660ef95e 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -14,6 +14,7 @@
 #define KEXEC_PRESERVE_CONTEXT	0x00000002
 #define KEXEC_UPDATE_ELFCOREHDR	0x00000004
 #define KEXEC_CRASH_HOTPLUG_SUPPORT 0x00000008
+#define KEXEC_MULTIKERNEL	0x00000010
 #define KEXEC_ARCH_MASK		0xffff0000
 
 /*
diff --git a/include/uapi/linux/reboot.h b/include/uapi/linux/reboot.h
index 58e64398efc5..aac2f2f94a98 100644
--- a/include/uapi/linux/reboot.h
+++ b/include/uapi/linux/reboot.h
@@ -34,7 +34,7 @@
 #define	LINUX_REBOOT_CMD_RESTART2	0xA1B2C3D4
 #define	LINUX_REBOOT_CMD_SW_SUSPEND	0xD000FCE2
 #define	LINUX_REBOOT_CMD_KEXEC		0x45584543
-
+#define	LINUX_REBOOT_CMD_MULTIKERNEL	0x4D4B4C49
 
 
 #endif /* _UAPI_LINUX_REBOOT_H */
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 28008e3d462e..49e62f804674 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -16,6 +16,7 @@
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
+#include <linux/memblock.h>
 
 #include "kexec_internal.h"
 
@@ -27,6 +28,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 	int ret;
 	struct kimage *image;
 	bool kexec_on_panic = flags & KEXEC_ON_CRASH;
+	bool multikernel_load = flags & KEXEC_MULTIKERNEL;
 
 #ifdef CONFIG_CRASH_DUMP
 	if (kexec_on_panic) {
@@ -37,6 +39,30 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 	}
 #endif
 
+#if 0
+	if (multikernel_load) {
+		// Check if entry is in a reserved memory region
+		bool in_reserved_region = false;
+		phys_addr_t start, end;
+		u64 i;
+
+		for_each_reserved_mem_range(i, &start, &end) {
+			if (entry >= start && entry < end) {
+				in_reserved_region = true;
+				break;
+			}
+		}
+
+		if (!in_reserved_region) {
+			pr_err("Entry point 0x%lx is not in a reserved memory region\n", entry);
+			return -EADDRNOTAVAIL; // Return an error if not in a reserved region
+		}
+
+		pr_info("multikernel load: got to multikernel_load syscall, entry 0x%lx, nr_segments %lu, flags 0x%lx\n",
+			entry, nr_segments, flags);
+	}
+#endif
+
 	/* Allocate and initialize a controlling structure */
 	image = do_kimage_alloc_init();
 	if (!image)
@@ -54,10 +80,16 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 	}
 #endif
 
+	if (multikernel_load) {
+		image->type = KEXEC_TYPE_MULTIKERNEL;
+	}
+
 	ret = sanity_check_segment_list(image);
 	if (ret)
 		goto out_free_image;
 
+	if (multikernel_load)
+		goto done;
 	/*
 	 * Find a location for the control code buffer, and add it
 	 * the vector of segments so that it's pages will also be
@@ -79,6 +111,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 		}
 	}
 
+done:
 	*rimage = image;
 	return 0;
 out_free_control_pages:
@@ -139,9 +172,11 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 		image->hotplug_support = 1;
 #endif
 
-	ret = machine_kexec_prepare(image);
-	if (ret)
-		goto out;
+	if (!(flags & KEXEC_MULTIKERNEL)) {
+		ret = machine_kexec_prepare(image);
+		if (ret)
+			goto out;
+	}
 
 	/*
 	 * Some architecture(like S390) may touch the crash memory before
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 31203f0bacaf..35a66c8dd78b 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -41,6 +41,7 @@
 #include <linux/objtool.h>
 #include <linux/kmsg_dump.h>
 #include <linux/dma-map-ops.h>
+#include <linux/memblock.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -211,6 +212,32 @@ int sanity_check_segment_list(struct kimage *image)
 	}
 #endif
 
+#if 0
+	if (image->type == KEXEC_TYPE_MULTIKERNEL) {
+		for (i = 0; i < nr_segments; i++) {
+			unsigned long mstart, mend;
+			phys_addr_t start, end;
+			bool in_reserved_region = false;
+			u64 i;
+
+			mstart = image->segment[i].mem;
+			mend = mstart + image->segment[i].memsz - 1;
+			for_each_reserved_mem_range(i, &start, &end) {
+				if (mstart >= start && mend <= end) {
+					in_reserved_region = true;
+					break;
+				}
+			}
+
+			if (!in_reserved_region) {
+				pr_err("Segment 0x%lx-0x%lx is not in a reserved memory region\n",
+					mstart, mend);
+				return -EADDRNOTAVAIL;
+			}
+		}
+	}
+#endif
+
 	/*
 	 * The destination addresses are searched from system RAM rather than
 	 * being allocated from the buddy allocator, so they are not guaranteed
@@ -943,6 +970,84 @@ static int kimage_load_crash_segment(struct kimage *image, int idx)
 }
 #endif
 
+static int kimage_load_multikernel_segment(struct kimage *image, int idx)
+{
+	/* For multikernel we simply copy the data from
+	 * user space to it's destination.
+	 * We do things a page at a time for the sake of kmap.
+	 */
+	struct kexec_segment *segment = &image->segment[idx];
+	unsigned long maddr;
+	size_t ubytes, mbytes;
+	int result;
+	unsigned char __user *buf = NULL;
+	unsigned char *kbuf = NULL;
+
+	result = 0;
+	if (image->file_mode)
+		kbuf = segment->kbuf;
+	else
+		buf = segment->buf;
+	ubytes = segment->bufsz;
+	mbytes = segment->memsz;
+	maddr = segment->mem;
+	pr_info("Loading multikernel segment: mem=0x%lx, memsz=0x%zu, buf=0x%px, bufsz=0x%zu\n",
+		maddr, mbytes, buf, ubytes);
+	while (mbytes) {
+		char *ptr;
+		size_t uchunk, mchunk;
+		unsigned long page_addr = maddr & PAGE_MASK;
+		unsigned long page_offset = maddr & ~PAGE_MASK;
+
+		/* Use memremap to map the physical address */
+		ptr = memremap(page_addr, PAGE_SIZE, MEMREMAP_WB);
+		if (!ptr) {
+			pr_err("Failed to memremap memory at 0x%lx\n", page_addr);
+			result = -ENOMEM;
+			goto out;
+		}
+
+		/* Adjust pointer to the offset within the page */
+		ptr += page_offset;
+
+		/* Calculate chunk sizes */
+		mchunk = min_t(size_t, mbytes, PAGE_SIZE - page_offset);
+		uchunk = min(ubytes, mchunk);
+
+		/* Zero the trailing part of the page if needed */
+		if (mchunk > uchunk) {
+			/* Zero the trailing part of the page */
+			memset(ptr + uchunk, 0, mchunk - uchunk);
+		}
+
+		if (uchunk) {
+			/* For file based kexec, source pages are in kernel memory */
+			if (image->file_mode)
+				memcpy(ptr, kbuf, uchunk);
+			else
+				result = copy_from_user(ptr, buf, uchunk);
+			ubytes -= uchunk;
+			if (image->file_mode)
+				kbuf += uchunk;
+			else
+				buf += uchunk;
+		}
+
+		/* Clean up */
+		memunmap(ptr - page_offset);
+		if (result) {
+			result = -EFAULT;
+			goto out;
+		}
+		maddr  += mchunk;
+		mbytes -= mchunk;
+
+		cond_resched();
+	}
+out:
+	return result;
+}
+
 int kimage_load_segment(struct kimage *image, int idx)
 {
 	int result = -ENOMEM;
@@ -956,6 +1061,9 @@ int kimage_load_segment(struct kimage *image, int idx)
 		result = kimage_load_crash_segment(image, idx);
 		break;
 #endif
+	case KEXEC_TYPE_MULTIKERNEL:
+		result = kimage_load_multikernel_segment(image, idx);
+		break;
 	}
 
 	return result;
@@ -1230,3 +1338,30 @@ int kernel_kexec(void)
 	kexec_unlock();
 	return error;
 }
+
+int multikernel_kexec(int cpu)
+{
+	int rc;
+
+	pr_info("multikernel kexec: cpu %d\n", cpu);
+
+	if (cpu_online(cpu)) {
+		pr_err("The CPU is currently running with this kernel instance.");
+		return -EBUSY;
+	}
+
+	if (!kexec_trylock())
+		return -EBUSY;
+	if (!kexec_image) {
+		rc = -EINVAL;
+		goto unlock;
+	}
+
+	cpus_read_lock();
+	rc = multikernel_kick_ap(cpu, kexec_image->start);
+	cpus_read_unlock();
+
+unlock:
+	kexec_unlock();
+	return rc;
+}
diff --git a/kernel/reboot.c b/kernel/reboot.c
index ec087827c85c..f3ac703c4695 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -717,6 +717,10 @@ EXPORT_SYMBOL_GPL(kernel_power_off);
 
 DEFINE_MUTEX(system_transition_mutex);
 
+struct multikernel_boot_args {
+	int cpu;
+};
+
 /*
  * Reboot system call: for obvious reasons only root may call it,
  * and even root needs to set up some magic numbers in the registers
@@ -729,6 +733,7 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 		void __user *, arg)
 {
 	struct pid_namespace *pid_ns = task_active_pid_ns(current);
+	struct multikernel_boot_args boot_args;
 	char buffer[256];
 	int ret = 0;
 
@@ -799,6 +804,11 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 	case LINUX_REBOOT_CMD_KEXEC:
 		ret = kernel_kexec();
 		break;
+	case LINUX_REBOOT_CMD_MULTIKERNEL:
+		if (copy_from_user(&boot_args, arg, sizeof(boot_args)))
+			return -EFAULT;
+		ret = multikernel_kexec(boot_args.cpu);
+		break;
 #endif
 
 #ifdef CONFIG_HIBERNATION
-- 
2.34.1


