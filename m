Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BB2C46CD2
	for <kexec@archiver.kernel.org>; Wed, 24 Jan 2024 05:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gOmsicRwS7aeo4xdb3oqXAhLVyEg3VDgGperwmgMEXU=; b=p1cObbT/Ad4t+y
	OXfON3+ks4ZCE88besj5SmOmwnT05qlEKYawXmDSOwRyhq5QuWzhlxR4lO9XIGx+OlnQMW7uLEscc
	KrraRuC8Px/HacNIhVCrN2WdZZXaQnMk1gi+TRcQZMWppz0PsU7Ip5i09eZtMT8Ppk4XBns+JQsRV
	3huVxGER7BF5/3+cBFywNoq/s71lWU8zJ5Vmt0oQ86FWpWXl+F6hbZNiG9FGnqlAU94dNwj8pQgPv
	aOzaovXRwanfpDc0riahlQXmVL1ffV/EMNGekC1Og6b/e9hyNMFEq8ZsGA/OrJ9YCqsFHf7jVAaJP
	K8KzFQKfrS8wwkbptEQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSVaW-001Wzp-1e;
	Wed, 24 Jan 2024 05:14:12 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSVaJ-001WoW-2V
	for kexec@bombadil.infradead.org;
	Wed, 24 Jan 2024 05:14:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-type
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=FFN/EE6fSgOxg2WRz1Lwt2Z6P21vAYaIGhzAxf9cqz8=; b=eHAK3LLUkwsl0FOomqyiiP0eph
	+rCh3ev+bw3vZ05eCjYQJO7DuM+d13fjaXbBlnI3nEOMjRPlrzKUT27m7PgkPG3eRwvYTlOGg163h
	UUeI0Eng/UiwNW0ISlF3sT8aSEisirP0mVf8HFLd+fGAMaaXAfm8XMtiPi6WGy4Zm/M4HSiu120p0
	yDUFj1uTeSuvHS9vZ4yNXMvmbVXBCKAB29z8oI6VsMEyJWDrWQkat9OED0NZupF/ZUg6klXSC41Nk
	xBOMlMFFcu0dJ20bLCoeFUAiV/hPxwRB0+s1ZthePBH1PMx/rQppKo7cWVgBDCES/o2Z6wZ9+gQf6
	Caypp6tw==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSVaE-00000004FEt-2Da6
	for kexec@lists.infradead.org;
	Wed, 24 Jan 2024 05:13:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706073232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFN/EE6fSgOxg2WRz1Lwt2Z6P21vAYaIGhzAxf9cqz8=;
	b=DDcYRzBNRnyvphkIjSJOlhAOIP0Cd0ShCkcQnMUhOlYIoiaVuzDrWol17X6iWi9vRFT4Ku
	DZrnYwKaz+dRZAQFD+IKpHrxtiiqzMH3iuvqFgCAX6qXzvT2z55JGJ9+gZOkgXJQtNHhI/
	JlQ7gGlYHKeRW2wBqrD5+gLFRCUxqU0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706073233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFN/EE6fSgOxg2WRz1Lwt2Z6P21vAYaIGhzAxf9cqz8=;
	b=RYoKUDqktMBp3CFHmAg0NK2+QNqXKOpWFEqNmDmosc5o45pDHANZRl+aixsWusU7pPep2j
	4aTdOUaAbfavhuyU2iI4KOhrfpYbTkNJ4tF7GqWskX0lwc1l1Na3KjfWm2vZsBZRNo8k/t
	xjeD4ss9BKbyfeZkd+L59RIIE3E4LI4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-WKyY6avVNPaClo8a68Hclg-1; Wed, 24 Jan 2024 00:13:49 -0500
X-MC-Unique: WKyY6avVNPaClo8a68Hclg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EC2F800074;
	Wed, 24 Jan 2024 05:13:48 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 491601C060AF;
	Wed, 24 Jan 2024 05:13:40 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev,
	akpm@linux-foundation.org,
	ebiederm@xmission.com,
	hbathini@linux.ibm.com,
	piliu@redhat.com,
	viro@zeniv.linux.org.uk,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH linux-next v3 06/14] x86, crash: wrap crash dumping code into crash related ifdefs
Date: Wed, 24 Jan 2024 13:12:46 +0800
Message-ID: <20240124051254.67105-7-bhe@redhat.com>
In-Reply-To: <20240124051254.67105-1-bhe@redhat.com>
References: <20240124051254.67105-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_051354_845474_817A5784 
X-CRM114-Status: GOOD (  16.94  )
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

Now crash codes under kernel/ folder has been split out from kexec
code, crash dumping can be separated from kexec reboot in config
items on x86 with some adjustments.

Here, also change some ifdefs or IS_ENABLED() check to more appropriate
ones, e,g
 - #ifdef CONFIG_KEXEC_CORE -> #ifdef CONFIG_CRASH_DUMP
 - (!IS_ENABLED(CONFIG_KEXEC_CORE)) - > (!IS_ENABLED(CONFIG_CRASH_RESERVE))

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/Makefile           | 4 ++--
 arch/x86/kernel/cpu/mshyperv.c     | 4 ++++
 arch/x86/kernel/kexec-bzimage64.c  | 4 ++++
 arch/x86/kernel/kvm.c              | 4 ++--
 arch/x86/kernel/machine_kexec_64.c | 3 +++
 arch/x86/kernel/reboot.c           | 2 +-
 arch/x86/kernel/setup.c            | 2 +-
 arch/x86/kernel/smp.c              | 2 +-
 arch/x86/xen/enlighten_hvm.c       | 4 ++++
 9 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 913d4022131e..3668b1edef2d 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -100,9 +100,9 @@ obj-$(CONFIG_TRACING)		+= trace.o
 obj-$(CONFIG_RETHOOK)		+= rethook.o
 obj-$(CONFIG_VMCORE_INFO)	+= vmcore_info_$(BITS).o
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec_$(BITS).o
-obj-$(CONFIG_KEXEC_CORE)	+= relocate_kernel_$(BITS).o crash.o
+obj-$(CONFIG_KEXEC_CORE)	+= relocate_kernel_$(BITS).o
 obj-$(CONFIG_KEXEC_FILE)	+= kexec-bzimage64.o
-obj-$(CONFIG_CRASH_DUMP)	+= crash_dump_$(BITS).o
+obj-$(CONFIG_CRASH_DUMP)	+= crash_dump_$(BITS).o crash.o
 obj-y				+= kprobes/
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_X86_32)		+= doublefault_32.o
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 01fa06dd06b6..f8163a59026b 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -210,6 +210,7 @@ static void hv_machine_shutdown(void)
 		hyperv_cleanup();
 }
 
+#ifdef CONFIG_CRASH_DUMP
 static void hv_machine_crash_shutdown(struct pt_regs *regs)
 {
 	if (hv_crash_handler)
@@ -221,6 +222,7 @@ static void hv_machine_crash_shutdown(struct pt_regs *regs)
 	/* Disable the hypercall page when there is only 1 active CPU. */
 	hyperv_cleanup();
 }
+#endif
 #endif /* CONFIG_KEXEC_CORE */
 #endif /* CONFIG_HYPERV */
 
@@ -497,7 +499,9 @@ static void __init ms_hyperv_init_platform(void)
 
 #if IS_ENABLED(CONFIG_HYPERV) && defined(CONFIG_KEXEC_CORE)
 	machine_ops.shutdown = hv_machine_shutdown;
+#ifdef CONFIG_CRASH_DUMP
 	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
+#endif
 #endif
 	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
 		/*
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 2a422e00ed4b..b55737b83a84 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -263,11 +263,13 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 	memset(&params->hd0_info, 0, sizeof(params->hd0_info));
 	memset(&params->hd1_info, 0, sizeof(params->hd1_info));
 
+#ifdef CONFIG_CRASH_DUMP
 	if (image->type == KEXEC_TYPE_CRASH) {
 		ret = crash_setup_memmap_entries(image, params);
 		if (ret)
 			return ret;
 	} else
+#endif
 		setup_e820_entries(params);
 
 	nr_e820_entries = params->e820_entries;
@@ -433,12 +435,14 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		return ERR_PTR(-EINVAL);
 	}
 
+#ifdef CONFIG_CRASH_DUMP
 	/* Allocate and load backup region */
 	if (image->type == KEXEC_TYPE_CRASH) {
 		ret = crash_load_segments(image);
 		if (ret)
 			return ERR_PTR(ret);
 	}
+#endif
 
 	/*
 	 * Load purgatory. For 64bit entry point, purgatory  code can be
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index dfe9945b9bec..acfc2d3183bc 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -769,7 +769,7 @@ static struct notifier_block kvm_pv_reboot_nb = {
  * won't be valid. In cases like kexec, in which you install a new kernel, this
  * means a random memory location will be kept being written.
  */
-#ifdef CONFIG_KEXEC_CORE
+#ifdef CONFIG_CRASH_DUMP
 static void kvm_crash_shutdown(struct pt_regs *regs)
 {
 	kvm_guest_cpu_offline(true);
@@ -852,7 +852,7 @@ static void __init kvm_guest_init(void)
 	kvm_guest_cpu_init();
 #endif
 
-#ifdef CONFIG_KEXEC_CORE
+#ifdef CONFIG_CRASH_DUMP
 	machine_ops.crash_shutdown = kvm_crash_shutdown;
 #endif
 
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index bc0a5348b4a6..b180d8e497c3 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -508,6 +508,8 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 }
 #endif /* CONFIG_KEXEC_FILE */
 
+#ifdef CONFIG_CRASH_DUMP
+
 static int
 kexec_mark_range(unsigned long start, unsigned long end, bool protect)
 {
@@ -552,6 +554,7 @@ void arch_kexec_unprotect_crashkres(void)
 {
 	kexec_mark_crashkres(false);
 }
+#endif
 
 /*
  * During a traditional boot under SME, SME will encrypt the kernel,
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 830425e6d38e..1287b0d5962f 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -796,7 +796,7 @@ struct machine_ops machine_ops __ro_after_init = {
 	.emergency_restart = native_machine_emergency_restart,
 	.restart = native_machine_restart,
 	.halt = native_machine_halt,
-#ifdef CONFIG_KEXEC_CORE
+#ifdef CONFIG_CRASH_DUMP
 	.crash_shutdown = native_machine_crash_shutdown,
 #endif
 };
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 84201071dfac..899d839a2954 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -471,7 +471,7 @@ static void __init arch_reserve_crashkernel(void)
 	bool high = false;
 	int ret;
 
-	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
 		return;
 
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 2908e063d7d8..18266cc3d98c 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -286,7 +286,7 @@ struct smp_ops smp_ops = {
 	.smp_cpus_done		= native_smp_cpus_done,
 
 	.stop_other_cpus	= native_stop_other_cpus,
-#if defined(CONFIG_KEXEC_CORE)
+#if defined(CONFIG_CRASH_DUMP)
 	.crash_stop_other_cpus	= kdump_nmi_shootdown_cpus,
 #endif
 	.smp_send_reschedule	= native_smp_send_reschedule,
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 3f8c34707c50..09e3db7ff990 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -149,12 +149,14 @@ static void xen_hvm_shutdown(void)
 		xen_reboot(SHUTDOWN_soft_reset);
 }
 
+#ifdef CONFIG_CRASH_DUMP
 static void xen_hvm_crash_shutdown(struct pt_regs *regs)
 {
 	native_machine_crash_shutdown(regs);
 	xen_reboot(SHUTDOWN_soft_reset);
 }
 #endif
+#endif
 
 static int xen_cpu_up_prepare_hvm(unsigned int cpu)
 {
@@ -236,8 +238,10 @@ static void __init xen_hvm_guest_init(void)
 
 #ifdef CONFIG_KEXEC_CORE
 	machine_ops.shutdown = xen_hvm_shutdown;
+#ifdef CONFIG_CRASH_DUMP
 	machine_ops.crash_shutdown = xen_hvm_crash_shutdown;
 #endif
+#endif
 }
 
 static __init int xen_parse_nopv(char *arg)
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
