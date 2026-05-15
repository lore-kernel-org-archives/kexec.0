Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D049CD4851
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ermZy1JOQ3bL4uNXgDw9lpn60RTdyK+Y6D8PtSjZ40A=; b=ER1BDGaiztx9fyPn+Y+buo6hJj
	jIPVgzPWm9nPT8+Hni9x2BxELyKZqQQD7KLlhnVwAkue0AXS6M/bCe/8WEIITYt6ITyOzhQibg3XN
	Umj/eI1y65q2aPDp+U8OZIyzYywrbfJbuzxMDv8wihhkajIpbtWiDIvtIlLN2UHxdRA7PWomARUI0
	7rO/if4da/vM8nUyyZ3/PdfnDhXeR+noJlWJnhB0qS9jjUQtaYofbEPgzJe6wTTZD4IwqI/jHSlL8
	m/IARZ6azM+ogHNpqeKVoRhELVLp8tg3K7OpLxYxCLKnLIb8LtKpn4TrrYiJvRfiKDCO8ujQUNi4G
	2hyfPjrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzss-00000009UFu-1kc6;
	Fri, 15 May 2026 21:15:50 +0000
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzsp-00000009UDc-3Vfh
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:15:48 +0000
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so1355401eec.0
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879747; x=1779484547; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ermZy1JOQ3bL4uNXgDw9lpn60RTdyK+Y6D8PtSjZ40A=;
        b=XcOoWVUW/4Fa7++mf9J0cYTF1DsS+sAMZXTYG62AQ1VMr3NOd+dAHBagx7YmBVzEd9
         zwdW5haMEGfQFuDHAI4Zca01rkQFgGh57Q3HQ5jdkunBjWQ/d+0nOztAoVlXsG24fKWI
         Gqa1QFrKTFXTNB0BJ9xLSnd7hK6G0jmw3mAiH8a5ddsBW49MLdsadpsRTFKjN7TQzNqt
         4W+lo6YN6q7Q6yGJFDol8F9BZrWuY9x4DMh7rgsFe86YJll9FfEiwvKaDcREC6QUVTIj
         MoW1YMPIJyKUzPze87ydeNo9rd6Q1CCJhnKW9Mgh6nXrOtOfR+D5DFSdywXN9AOznE7i
         tBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879747; x=1779484547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ermZy1JOQ3bL4uNXgDw9lpn60RTdyK+Y6D8PtSjZ40A=;
        b=d+uRuy6yNyUNQkB4teiNpM0z+BNrxSG++huVBX5YfV/8Tyj45j9rxz6ZRj0FTfby6D
         FXBrcOgZFmDJFEKoHL7RKH8ofuIVgqY/krUhnj+RYqR2NBCPy0HQbeYVfg9bkNynA7Jo
         LflurM+yeC4VbE+OHTzJ6HJkaZ+SKbS7/jPN13EArKaUwBmZ7fbffFYJDS31AMiYAo2q
         63knvJKohJRr7iTxC9oDBDjMCvz+gbtN9iToJb5Jz8GqF72NsRMH2IG/3oS8IhChbC42
         8WQXA0PzZg2DLJ8U9OhPpvkoYbeWHLP0xPLXEzVtFbWKWKFmOabw9djzhUGDN2sopyHX
         WCoQ==
X-Forwarded-Encrypted: i=1; AFNElJ9wI8x67Hhd8pjcixNxkDSfLB5qdYJ/Tm/Bhg1xZWOoLDQF7OnaipSZBaTwPkRXENlvjkKuAw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyXK2CaB1w86B0oGwcjlUCpFm2epgFIFzebDC0FzMQKEyzNHLK4
	TEqi+8QCLwftavUS31xDtw4FZfsOyDy3xFtXCj4+ly0HvM5icco1Elgg
X-Gm-Gg: Acq92OFL7z7GphvqP9++SUvYZT8ez0YwiU+wYILtiYNvgfH6X1jhHq3V48gR9JDH4nb
	Fmw2YOV+T5MvGoghNSUXNnQQNZ6H2sQv5at/famCd9z8j/do3bW15o3FyI7l+IArllAzx3DTF7g
	0pZS53vqez5D7fsVvzU7n3VRcpXGPp+F5qzWuPT7rQZauiDMQKllLI/sy9sroOWTFfRJ4e4RLnr
	lJOl6T452ZkhGp+EMZzPq5JVyR4/NdMVCvEv+50X35ZwBZ4ZANCDNLGFF3Autb6zn01fz2j3e3N
	0GEparDAQHDvOipZ3mtH7NpH3V0O4QaDHc7iJ2POPh1jJ72CSqGW1/W8KSUBFJbr+K0RPP312kS
	AcS62smXqZVToa+lw33fuqXHZ3Qk4DVtOw2emFUVYeprqvf1S19p7/iwsYPUYhzXH1mivgGe0wG
	fo2qvJ9mqtaLbqaMowIuGCOxGIWXBbJGyZ2Fc8L2wipA==
X-Received: by 2002:a05:7300:d706:b0:2d3:f43c:d684 with SMTP id 5a478bee46e88-30398191408mr2749976eec.2.1778879746758;
        Fri, 15 May 2026 14:15:46 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e69esm9916134eec.1.2026.05.15.14.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:46 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 33/38] x86/slaunch: Secure Launch SMP bringup support
Date: Fri, 15 May 2026 14:14:05 -0700
Message-ID: <20260515211410.31440-34-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141547_904278_BB469D5F 
X-CRM114-Status: GOOD (  28.92  )
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

On Intel, the APs are left in a well documented state after TXT
performs the secure launch. Specifically, they cannot have #INIT
asserted on them so a standard startup via INIT/SIPI/SIPI cannot
be performed. Instead the early SL stub code uses MONITOR and MWAIT
to park the APs. The realmode/init.c code updates the jump address
for the waiting APs with the location of the Secure Launch entry
point in the rmpiggy image.

The rmpiggy image is a payload contained in the kernel used to start
the APs (in 16b or 32b modes). It is loaded at runtime so its
location and entry point must be updated in the long jump for the
waiting APs by the running kernel.

As the APs are woken up by writing the monitor, the APs jump to the
Secure Launch entry point in the rmpiggy which mimics what the real
mode code would do then jumps to the standard rmpiggy protected mode
entry point.

Co-developed-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/include/asm/realmode.h      |  3 ++
 arch/x86/kernel/slaunch.c            | 26 +++++++++++++++
 arch/x86/kernel/smpboot.c            | 47 ++++++++++++++++++++++++++--
 arch/x86/realmode/init.c             |  8 +++++
 arch/x86/realmode/rm/header.S        |  3 ++
 arch/x86/realmode/rm/trampoline_64.S | 32 +++++++++++++++++++
 6 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index e406a1e92c63..e3336c49d26b 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -38,6 +38,9 @@ struct real_mode_header {
 #ifdef CONFIG_X86_64
 	u32	machine_real_restart_seg;
 #endif
+#ifdef CONFIG_SECURE_LAUNCH
+	u32	sl_trampoline_start32;
+#endif
 };
 
 /* This must match data at realmode/rm/trampoline_{32,64}.S */
diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
index 0179ff855b62..f6e6f1b7e18c 100644
--- a/arch/x86/kernel/slaunch.c
+++ b/arch/x86/kernel/slaunch.c
@@ -511,3 +511,29 @@ void __init slaunch_setup(void)
 	if (boot_cpu_has(X86_FEATURE_SMX))
 		slaunch_setup_txt();
 }
+
+/*
+ * After a launch, the APs are woken up, enter the DRTM and are left to
+ * wait for a wakeup call on a MONITOR address. The block where they are
+ * idle has a long jump to the AP startup code in the mainline kernel.
+ * This address has to be calculated at runtime and "fixed up" to point
+ * to the SL startup location in the rmpiggy SMP startup image. This image
+ * is loaded into separate memory at kernel start time.
+ */
+void __init slaunch_fixup_ap_wake_vector(void)
+{
+	struct sl_ap_wake_info *ap_wake_info;
+	u32 *ap_jmp_ptr;
+
+	if (!slaunch_is_txt_launch())
+		return;
+
+	ap_wake_info = slaunch_get_ap_wake_info();
+
+	ap_jmp_ptr = (u32 *)__va(ap_wake_info->ap_wake_block +
+				 ap_wake_info->ap_jmp_offset);
+
+	*ap_jmp_ptr = real_mode_header->sl_trampoline_start32;
+
+	pr_info("TXT AP startup vector address updated\n");
+}
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 294a8ea60298..16a0f2718a38 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -61,6 +61,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/mc146818rtc.h>
 #include <linux/acpi.h>
+#include <linux/slaunch.h>
 
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
@@ -989,6 +990,45 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
+#if (IS_ENABLED(CONFIG_SECURE_LAUNCH))
+
+/*
+ * TXT AP startup is quite different than normal. The APs cannot have #INIT
+ * asserted on them or receive SIPIs. The early Secure Launch code has parked
+ * the APs using MONITOR/MWAIT in the safe AP wake block area (details in
+ * sl_stub.S). The SMP boot will wake the APs by writing the MONITOR associated
+ * with the AP and have them jump to the protected mode code in the rmpiggy where
+ * the rest of the SMP boot of the AP will proceed normally.
+ *
+ * Intel Trusted Execution Technology (TXT) Software Development Guide
+ * Section 2.3 -  MLE Initialization
+ */
+static void slaunch_wakeup_cpu_from_txt(int cpu, int apicid)
+{
+	struct sl_ap_stack_and_monitor *stack_monitor;
+	struct sl_ap_wake_info *ap_wake_info;
+
+	ap_wake_info = slaunch_get_ap_wake_info();
+
+	stack_monitor = (struct sl_ap_stack_and_monitor *)__va(ap_wake_info->ap_wake_block +
+							       ap_wake_info->ap_stacks_offset);
+
+	for (unsigned int i = SL_MAX_CPUS - 1; i >= 0; i--) {
+		if (stack_monitor[i].apicid == apicid) {
+			stack_monitor[i].monitor = 1;
+			break;
+		}
+	}
+}
+
+#else
+
+static inline void slaunch_wakeup_cpu_from_txt(int cpu, int apicid)
+{
+}
+
+#endif  /* IS_ENABLED(CONFIG_SECURE_LAUNCH) */
+
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
  * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
@@ -998,7 +1038,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 static int do_boot_cpu(u32 apicid, unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long start_ip = real_mode_header->trampoline_start;
-	int ret;
+	int ret = 0;
 
 #ifdef CONFIG_X86_64
 	/* If 64-bit wakeup method exists, use the 64-bit mode trampoline IP */
@@ -1043,12 +1083,15 @@ static int do_boot_cpu(u32 apicid, unsigned int cpu, struct task_struct *idle)
 
 	/*
 	 * Wake up a CPU in difference cases:
+	 * - Intel TXT DRTM launch uses its own method to wake the APs
 	 * - Use a method from the APIC driver if one defined, with wakeup
 	 *   straight to 64-bit mode preferred over wakeup to RM.
 	 * Otherwise,
 	 * - Use an INIT boot APIC message
 	 */
-	if (apic->wakeup_secondary_cpu_64)
+	if (slaunch_is_txt_launch())
+		slaunch_wakeup_cpu_from_txt(cpu, apicid);
+	else if (apic->wakeup_secondary_cpu_64)
 		ret = apic->wakeup_secondary_cpu_64(apicid, start_ip, cpu);
 	else if (apic->wakeup_secondary_cpu)
 		ret = apic->wakeup_secondary_cpu(apicid, start_ip, cpu);
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 88be32026768..ded4dafc6a0a 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -4,6 +4,7 @@
 #include <linux/memblock.h>
 #include <linux/cc_platform.h>
 #include <linux/pgtable.h>
+#include <linux/slaunch.h>
 
 #include <asm/set_memory.h>
 #include <asm/realmode.h>
@@ -213,6 +214,13 @@ void __init init_real_mode(void)
 
 	setup_real_mode();
 	set_real_mode_permissions();
+
+	/*
+	 * If Secure Launch is active, it will use the rmpiggy to do the TXT AP
+	 * startup. Secure Launch has its own entry stub in the rmpiggy and this prepares
+	 * it for SMP boot.
+	 */
+	slaunch_fixup_ap_wake_vector();
 }
 
 static int __init do_init_real_mode(void)
diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.S
index 2eb62be6d256..3b5cbcbbfc90 100644
--- a/arch/x86/realmode/rm/header.S
+++ b/arch/x86/realmode/rm/header.S
@@ -37,6 +37,9 @@ SYM_DATA_START(real_mode_header)
 #ifdef CONFIG_X86_64
 	.long	__KERNEL32_CS
 #endif
+#ifdef CONFIG_SECURE_LAUNCH
+	.long	pa_sl_trampoline_start32
+#endif
 SYM_DATA_END(real_mode_header)
 
 	/* End signature, used to verify integrity */
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index 14d9c7daf90f..b0ce6205d7ea 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -122,6 +122,38 @@ SYM_CODE_END(sev_es_trampoline_start)
 
 	.section ".text32","ax"
 	.code32
+#ifdef CONFIG_SECURE_LAUNCH
+	.balign 4
+SYM_CODE_START(sl_trampoline_start32)
+	/*
+	 * The early secure launch stub AP wakeup code has taken care of all
+	 * the vagaries of launching out of TXT. This bit just mimics what the
+	 * 16b entry code does and jumps off to the real startup_32.
+	 */
+	cli
+	wbinvd
+
+	/*
+	 * The %ebx provided is not terribly useful since it is the physical
+	 * address of tb_trampoline_start and not the base of the image.
+	 * Use pa_real_mode_base, which is fixed up, to get a run time
+	 * base register to use for offsets to location that do not have
+	 * pa_ symbols.
+	 */
+	movl    $pa_real_mode_base, %ebx
+
+	LOCK_AND_LOAD_REALMODE_ESP lock_pa=1
+
+	lgdt    tr_gdt(%ebx)
+	lidt    tr_idt(%ebx)
+
+	movw	$__KERNEL_DS, %dx	# Data segment descriptor
+
+	/* Jump to where the 16b code would have jumped */
+	ljmpl	$__KERNEL32_CS, $pa_startup_32
+SYM_CODE_END(sl_trampoline_start32)
+#endif
+
 	.balign 4
 SYM_CODE_START(startup_32)
 	movl	%edx, %ss
-- 
2.47.3


