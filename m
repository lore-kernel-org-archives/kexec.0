Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC729C79F99
	for <kexec@archiver.kernel.org>; Tue,  8 Sep 2026 18:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X96+zYCvaN6SOrdHaZFaRkSOvwWaLyxQvweykkN1/zc=; b=ZTtvCtNFNviL8oIBh1iFWJMiX8
	IimWmv47DrkpK9PcPhavnj2dG1myMh6L3/zwKJSb7rzK8Qi759CdYkLjOxOBew+42k19sYQB+5P8H
	LQfyZ3wFnUYBxoK+2AgqoJUpmJF+zNHl5rx5yCvCLjA8b3sao8SaVrJa96jAn/9RroYF2VRdfpFZg
	HVoApvSttWQn72u3IL1eQI064SZ9g9JjEzO9eJH/ZZks9yKuMgbLMrFH/ii5HGeLOUtipNKDzPFwM
	MmZDKvVwrouF7k4nKZ2ELvUmUCtAaibBfGIxOIs6cWGKR8m57VR5meshh6bfUlxFmdDx63efyxr8m
	ZedxVZ/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x40kP-00000009zfC-3V4M;
	Tue, 08 Sep 2026 18:40:45 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x40kN-00000009zei-0QTN
	for kexec@bombadil.infradead.org;
	Tue, 08 Sep 2026 18:40:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=X96+zYCvaN6SOrdHaZFaRkSOvwWaLyxQvweykkN1/zc=; b=a/1oOaiD4CXs2wF3Ibx5TR8fEW
	GrtjzfhTR+dPOstOvY99x/DpnhZkb37aDrNozcQcveUGaOiN7emjnl7dkp6B47bawoYtGhiS3xKzL
	CznYDJAUzRrem4re76ur6Yx9PDV0ycI1rGNh5JNPEkEKtksY/kSyg4KGl2z/1RpFrEzI/xwojvcAA
	iB6Ciscvfp9yviTqKfjKSqOrNUg2ak4V+BjHIrV7XosskDQMLYj87GD493+TlUbwGRTwJnO9H94ya
	/z1OcGc1DTE+wjjb+gdJlq0vslBoy3y/rPeL6PmUNy48MGdxaDm0QsR8mWo0jFPk8t+hGJdL0DUXJ
	8xf2Owfg==;
Received: from mail-pj1-x1061.google.com ([2607:f8b0:4864:20::1061])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x40kJ-00000000ELm-38ps
	for kexec@lists.infradead.org;
	Tue, 08 Sep 2026 18:40:41 +0000
Received: by mail-pj1-x1061.google.com with SMTP id 98e67ed59e1d1-395cf2535acso4964930a91.1
        for <kexec@lists.infradead.org>; Tue, 08 Sep 2026 11:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788892836; x=1789497636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X96+zYCvaN6SOrdHaZFaRkSOvwWaLyxQvweykkN1/zc=;
        b=PvLhi4j6BmrnepvNURL6Zm8OdsjiMxg524V5EF6+W01V4DQtkrla7aWIS5H8PQqvsU
         hS9/R42GbTN5n0UafqLssdbmY/ponFJ2/xQZZPoPgzPFX24afOsFfwvmnG8SHz8hDClg
         bssTeiR1aXjUaRkCfqv6niBiFRA8hvDI1g8dmC0vmnsNIlicBDoZfgdxu5UZvgUFdGNQ
         u6LN/WgdjaIPLaUKjxk5WfMJnRTHtHZ6GsxSBXAAGxbfyU99xARd3VaCRNIvywZ8Nx0P
         uz9/H7VEWDyjYdiKyTa8hG4i5lEKq6Cp7k4TNXKv/kbqG2+q/Dje1zpKh4R++PgoLa6J
         Jw7Q==
X-Forwarded-Encrypted: i=1; AKwUvBzJfz3bP0k5P0pLFneH0/Lbx1ejTWq3m/iz04BGfGkWjSKTnvRyauGBiuNjXb+gBTmh8NASEg==@lists.infradead.org
X-Gm-Message-State: AFuF++mkaiqbIULoVAUbqDwgOF+w8Zu3Jb1ymjXELOZ8R8e1m3oliN6A
	EtCpTbtcoSHYs2TzKs2GCehc1sZg+WbgEJRtXyUqhOa9rUoFO9vUVVHQNszzNXqZsUtRbiEcy46
	L25YbN7I52RM+90BLn1TjqDTbaaUUdCp6Q3EIJMdy5TBdjHsUST1uLYZlJs7HNmL6NLWW7cj0Z3
	i9wg1TlvSS72R5tLghN1YxUwgF6hdua6G1IFNjJV2Fu3QYkf2fUDWutBKqUvbr92bgiwP5QdCGu
	YOu2aG+USGr
X-Gm-Gg: AYBFou2JAJ5iV0frO3LqaUk67/1SuY3hPHbuvx1vzL96hhRUZPWF41uTJXZSnZzMqZS
	cRDsQhv0O55+Kp4x5Y0GroVGqu87LnbTcTE3UUAso8DRfYeW7//cXX6v5zVFxpc/RZqmRrYHiTp
	oYoys4BCyNiQd15rLqItsuWU7iq+GUW6wDFAIdt8Zr9DlZywVTpgNDaLQEFAb2vq06W0MAErZzD
	oQY9D+Kxwy9AkRcLMO56tYYSyRpaHlukFYt4R1vM6eXqvVyx6ROagErPZZCzYJDw7WBoKCPxUeO
	bo0qKBARxu3l9Ny4tsJv5fho29cQ4f6D6QWGiiFawaTuhYBs6Waiuz3i2ptc+UO3OO4YZCLx5sL
	Kwd/TwlbTtz2E6IU1uQtGI7whbCuJwEsMsWjPvC3JBGXDVvEO6X8neh2P6zXgVhmNE45cFf190L
	sr7DoI10Ia8Z0Pbxb7Z4Iq782YAQuEkPNr
X-Received: by 2002:a17:90b:5743:b0:38e:c232:9d2c with SMTP id 98e67ed59e1d1-39b8bc9422emr6624845a91.2.1788892836106;
        Tue, 08 Sep 2026 11:40:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39b9972213fsm1606959a91.7.2026.09.08.11.40.35
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2026 11:40:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-45eb9967696so5128818fac.1
        for <kexec@lists.infradead.org>; Tue, 08 Sep 2026 11:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788892835; x=1789497635; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X96+zYCvaN6SOrdHaZFaRkSOvwWaLyxQvweykkN1/zc=;
        b=gLzNuSW1niuBCgNWIr6TQ1ZJPJ5lS1ngGSpCxc4BzFvAo/KohkXWqrv2w1anbIlIVg
         ig2nBurOXff3QxVRQdbGIVmsj/eirEYwyM+rnpnSMb1gq1rYtmRPIM2pCf3bTR8IR5l1
         S7Ds9WH3yBnGVmZS16ctPc7cjAKuFZ0Ml0eg8=
X-Forwarded-Encrypted: i=1; AKwUvBwYNacoYM5vzNGQaoRFzIayfJtMvMiAIXq+q1BspgndXCO4liMAr1UgTrATGMNjpuW9soJwWQ==@lists.infradead.org
X-Received: by 2002:a05:690e:418d:b0:671:4d2:804e with SMTP id 956f58d0204a3-67104d28276mr98611d50.36.1788890858312;
        Tue, 08 Sep 2026 11:07:38 -0700 (PDT)
X-Received: by 2002:a05:690e:418d:b0:671:4d2:804e with SMTP id 956f58d0204a3-67104d28276mr98573d50.36.1788890857670;
        Tue, 08 Sep 2026 11:07:37 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9106412e038sm27114866d6.20.2026.09.08.11.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 11:07:34 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Joel Granados <joel.granados@kernel.org>,
	Baoquan He <baoquan.he@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Bo Gan <bo.gan@broadcom.com>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v1 3/4] x86/vmware: Report guest crashes after kmsg dumpers
Date: Tue,  8 Sep 2026 14:07:15 -0400
Message-ID: <8243a70e3bc282e3fbc1b507f40b889cb7e74305.1788414671.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788414671.git.zack.rusin@broadcom.com>
References: <cover.1788414671.git.zack.rusin@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260908_194039_843868_A0020573 
X-CRM114-Status: GOOD (  18.53  )
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

VMware accepts a structured guest-crash event, but a host configured with
backdoor.coredumpOnCrash may terminate the VM before the hypercall
returns. Sending the event from a panic notifier could prevent later kmsg
dumpers and a loaded crash kernel from running.

Register a second panic-only kmsg dumper with late_initcall_sync(). Kmsg
dumpers run in registration order, placing the report after the early
VMware logger and built-in dumpers registered by then. This leaves no
report before the late initcall, but avoids losing dump output to a
terminating host.

Skip the event when a crash kernel is loaded. The earlier logger can still
write panic text to vmware.log before __crash_kexec(). If kdump later
fails, no structured event is sent; issuing it first could prevent kdump
from running at all.

Issue the event at most once. With CONFIG_PRINTK=n, install a late
INT_MIN panic notifier. An unexpected dumper registration failure with
printk enabled leaves reporting disabled because a notifier fallback
would overtake working dumpers.

Link: https://lore.kernel.org/r/20260309235250.2611115-4-alexey.makhalov@broadcom.com
Co-developed-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
Signed-off-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 arch/x86/include/asm/vmware.h |  1 +
 arch/x86/kernel/cpu/vmware.c  | 63 +++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 598d4cd448ec..ea2ce5272a00 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -61,6 +61,7 @@
 #define VMWARE_CMD_GETHZ		45
 #define VMWARE_CMD_GETVCPU_INFO		68
 #define VMWARE_CMD_STEALCLOCK		91
+#define VMWARE_CMD_REPORTGUESTCRASH	102
 /*
  * Hypercall command mask:
  *   bits [6:0] command, range [0, 127]
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 3848811550e9..c21fc835537f 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -22,10 +22,14 @@
  */
 
 #include <linux/dmi.h>
+#include <linux/atomic.h>
+#include <linux/crash_core.h>
 #include <linux/init.h>
 #include <linux/export.h>
 #include <linux/kmsg_dump.h>
+#include <linux/limits.h>
 #include <linux/mm.h>
+#include <linux/panic_notifier.h>
 #include <linux/clocksource.h>
 #include <linux/cpu.h>
 #include <linux/efi.h>
@@ -323,6 +327,65 @@ static int __init vmware_panic_log_init(void)
 }
 early_initcall(vmware_panic_log_init);
 
+static atomic_t vmware_crash_reported = ATOMIC_INIT(0);
+
+static void vmware_report_guest_crash(void)
+{
+	if (kexec_crash_loaded())
+		return;
+	if (atomic_xchg(&vmware_crash_reported, 1))
+		return;
+
+	vmware_hypercall1(VMWARE_CMD_REPORTGUESTCRASH, 0);
+}
+
+static void vmware_crash_report_dump(struct kmsg_dumper *dumper,
+				     struct kmsg_dump_detail *detail)
+{
+	vmware_report_guest_crash();
+}
+
+static struct kmsg_dumper vmware_crash_report_dumper = {
+	.dump = vmware_crash_report_dump,
+	.max_reason = KMSG_DUMP_PANIC,
+};
+
+static int vmware_crash_report_notify(struct notifier_block *nb,
+				      unsigned long action, void *data)
+{
+	vmware_report_guest_crash();
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block vmware_crash_report_nb = {
+	.notifier_call = vmware_crash_report_notify,
+	.priority = INT_MIN,
+};
+
+static int __init vmware_crash_report_init(void)
+{
+	int ret;
+
+	if (!hypervisor_is_type(X86_HYPER_VMWARE))
+		return 0;
+
+	ret = kmsg_dump_register(&vmware_crash_report_dumper);
+	if (!ret)
+		return 0;
+	if (IS_ENABLED(CONFIG_PRINTK)) {
+		pr_err("failed to register crash report dumper: %d\n", ret);
+		return 0;
+	}
+
+	ret = atomic_notifier_chain_register(&panic_notifier_list,
+					     &vmware_crash_report_nb);
+	if (ret)
+		pr_err("failed to register crash report notifier: %d\n", ret);
+
+	return 0;
+}
+late_initcall_sync(vmware_crash_report_init);
+
 #ifdef CONFIG_PARAVIRT
 static struct cyc2ns_data vmware_cyc2ns __ro_after_init;
 static bool vmw_sched_clock __initdata = true;
-- 
2.53.0


