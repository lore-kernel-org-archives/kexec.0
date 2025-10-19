Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E463CCD1AA
	for <kexec@archiver.kernel.org>; Sun, 19 Oct 2025 06:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ASOuu0vLLkYA4SCgQcRVW0CFmaVqIaRDuU0cccUVqmU=; b=uTW1jYNI2Qi2vqYnEItiqUhium
	3kJESBId8mqIq/UjZQl9MzSZdSq1FumXniDkkThrKvd1Y5fCeafY8edvSLQdvG8d3B6gOqHw1rTg9
	NxRniqx3fQ3LtAO/MSLat3l4r/PafQaqTTC02iR6mH3WRFO2IJ0H0xOwRWQtagkGW1Sg3u0p4O5I7
	4qpY7chDa6UCJKu0uFBNYkMuStnesHwnrlbD1kdS+D6SknJYa/yIJdpR4Gmf97gRY5e3jZSGDH3zF
	Y35ugDte+ZYOr+w8TwN4o4KmOyNvpXwa4wrtsn9pwNqjLHUeGS1jpz3q1VX6GX+b9uqL82rNjy2Cz
	sXe7lKYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMir-0000000Aiys-2ME2;
	Sun, 19 Oct 2025 06:16:53 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMip-0000000AiyG-1JsL
	for kexec@lists.infradead.org;
	Sun, 19 Oct 2025 06:16:52 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-782e93932ffso2877761b3a.3
        for <kexec@lists.infradead.org>; Sat, 18 Oct 2025 23:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854610; x=1761459410; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASOuu0vLLkYA4SCgQcRVW0CFmaVqIaRDuU0cccUVqmU=;
        b=SMXbm7vSlaVAmC2/0hiCY1zBj+mOOXQZrSUi4dWerwTfOM9CMVKeKHqksEjAlFXfvz
         yt3v1/CfZ0B2xk2+1arzpRY87V2jiAPiiKqXFWTM7U5Ax+fy09hm8EEYW+OWQbloVDEC
         shJ2vRoL2ONu8u9D05IdXbkiaHjpAsS0FXy/+qoQWsYMRe3JhpapP8UAPhTR5p9+Tuhx
         iN0fzgowHFnm6expcZEoEIemLbO1TN2gVXxJ0XIM0T7ISGMZtnS0HecktQGS9NM6gH0D
         24ZobuPiaCk3OL1YdWQ0U7IdIaQk2RozNbp3bm2/Ac+mEPCrJQW2Ga13yosVSRIMC3Aw
         pyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854610; x=1761459410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASOuu0vLLkYA4SCgQcRVW0CFmaVqIaRDuU0cccUVqmU=;
        b=RBgu/aoVv2TZKk3Qx4/XH0A93e8rNn7blpG/y+peLbACju6AnXMBUch0oRcRCs2ULz
         fu6kqwq9sWxL8pBXQfWK79MR2n0naqPplMmefDRNF/HVg1MRXTM+4dzys1OQvxDcsHms
         Lx4SuQhL+/Sm4blDgRncfyqEf4C41dywqGaKC7Nf66gmALIxxh3Y0c21c2MPwfq65XZy
         fXYi7PTyKQdhDFQ/hRkdK3+Yz0vVBIsD7GbthUTbyyKyonrBdfeTTlCnrOMRfMs9jqHq
         Suh0Esq3um/s18wOSod/OdttfpjfybshjE2co7VmKRIOiTvw0DyTfn0HTQ4bFzv0HWoB
         J3mA==
X-Forwarded-Encrypted: i=1; AJvYcCV3+Pf+RN3dB01HLXi/JW2vSk1B3yhr1P5THAezwIvXaZwN52BNgYhe+RTDHEK1aIofIi5QgA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwyAUfRus0LV2CrWr1JGc2hRgrd5qKz7eNx2dsJyj2y+Bbc8+2Y
	XZ43u7qgsr+YYJ5pfeHUXAS4JksZ8A8z6drIXIesG8UrS9jN5OfEnrW6
X-Gm-Gg: ASbGncsrVWy3zLevVsl1qmKdX5kUuJ62LgancVdfeWUQZoodCVLM+HIIn7gWXtsicP3
	aALCIORnd9oDy0ztC/cOj5IsTCn+DT+rKPy9N/KzUKu8Y0FHgr61irdihrMkvVYZRiLSZDu3MnN
	U/NXwviDYjw4lBJ0FF7pVfQr1rgoSERbPsnS3Bfye9smHo/I+oDDp0xbzISJznMdy1oLCcS4daq
	1rFcNPcEJhuJPXT+RcJk3nU3GbONei1c5/Uq74N0OBklrigcIBUMtiguz4NYN5GrqdBnP146pID
	kxk+cH69S+Laejhj2xOrb4FFyO1wFi2To3ErAv70elAz60jy/5ytK4IE5fpN9sjWdNClxlsBzbO
	B6UL8BGRdALFQr4Ab9Qu1qJKJa0HWJJPjHNgzdfIViPSWWM66fM2g4LLmQKQrJF9PgA6Q/ip6dD
	rf2dwm
X-Google-Smtp-Source: AGHT+IHcUYO9o6/V8YsIgbXToAumR6ZpDXIuRlYfIC0ZEiQ0uD3wnq9KGJNzH0DhGnF60uXtoY0gew==
X-Received: by 2002:a05:6a20:6a07:b0:334:9f87:17e8 with SMTP id adf61e73a8af0-334a8610a1emr11564376637.38.1760854610412;
        Sat, 18 Oct 2025 23:16:50 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:16:49 -0700 (PDT)
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
Subject: [RFC Patch v2 01/16] kexec: Introduce multikernel support via kexec
Date: Sat, 18 Oct 2025 23:16:15 -0700
Message-Id: <20251019061631.2235405-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
References: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251018_231651_376314_E112A4C2 
X-CRM114-Status: GOOD (  32.89  )
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
 arch/x86/kernel/smpboot.c   | 104 ++++++++++++++++++++++++++++++++++
 include/linux/kexec.h       |   6 +-
 include/uapi/linux/kexec.h  |   1 +
 include/uapi/linux/reboot.h |   2 +-
 kernel/kexec_core.c         | 109 ++++++++++++++++++++++++++++++++++++
 kernel/reboot.c             |  10 ++++
 7 files changed, 230 insertions(+), 3 deletions(-)

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
index eb289abece23..7b27fdc1d169 100644
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
index ff7e231b0485..edf64bc98ed5 100644
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
@@ -437,6 +438,7 @@ extern void machine_kexec(struct kimage *image);
 extern int machine_kexec_prepare(struct kimage *image);
 extern void machine_kexec_cleanup(struct kimage *image);
 extern int kernel_kexec(void);
+extern int multikernel_kexec(int cpu);
 extern struct page *kimage_alloc_control_pages(struct kimage *image,
 						unsigned int order);
 
@@ -458,7 +460,7 @@ bool kexec_load_permitted(int kexec_image_type);
 #define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR | KEXEC_CRASH_HOTPLUG_SUPPORT)
 #else
 #define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR | \
-			KEXEC_CRASH_HOTPLUG_SUPPORT)
+			KEXEC_CRASH_HOTPLUG_SUPPORT | KEXEC_MULTIKERNEL)
 #endif
 
 /* List of defined/legal kexec file flags */
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 55749cb0b81d..346e0ff4e663 100644
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
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index fa00b239c5d9..7d89d00e2cde 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -41,6 +41,7 @@
 #include <linux/objtool.h>
 #include <linux/kmsg_dump.h>
 #include <linux/dma-map-ops.h>
+#include <linux/memblock.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -942,6 +943,84 @@ static int kimage_load_crash_segment(struct kimage *image, int idx)
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
@@ -955,6 +1034,9 @@ int kimage_load_segment(struct kimage *image, int idx)
 		result = kimage_load_crash_segment(image, idx);
 		break;
 #endif
+	case KEXEC_TYPE_MULTIKERNEL:
+		result = kimage_load_multikernel_segment(image, idx);
+		break;
 	}
 
 	return result;
@@ -1229,3 +1311,30 @@ int kernel_kexec(void)
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


