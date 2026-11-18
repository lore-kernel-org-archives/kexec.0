Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ACA606A32A
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Sy+fE8k7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=A3dh8F1j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=I0NMn6fHPSVKHVHVNpMiE+ggLiJC/6XmQS3TcCioiGQ=; b=Sy+fE8k7CyByxKz69pJIRpfu9k
	hBT2a0NPxOaTizZhtC4uKQ1dmrPpPsGb0d2N2xv5v6F0YGB5JuwLeyDRNt7cHPSpuo6z+He7OhTb8
	2pmqgnhpaKM3neQOcoYhn9wQzq5NEO12YA7K8PzipbgmRqd93ZsKS88iLrWNFDEKuhUK0mU6N+Irp
	/3TTgVtN0VUnDYqp5K/8BrJXTcpKUb+Oh38NOIWbrasz2vN7TsoDDUYbDuu9QpgT5wGk0CttF4SI9
	enuRrXm57V0y3vHJiG71PhShpSAYJRtkP624T1QvumbyyncIk/HJRkgU4giWj4LcPJoNSyu+1xczb
	3zn51SOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTYkN-00000007pSE-2jRC;
	Wed, 18 Nov 2026 06:02:19 +0000
Received: from mail-pj1-x1062.google.com ([2607:f8b0:4864:20::1062])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTYkK-00000007pRL-1pAa
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 06:02:18 +0000
Received: by mail-pj1-x1062.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so339399a91.1
        for <kexec@lists.infradead.org>; Tue, 17 Nov 2026 22:02:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794981735; x=1795586535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I0NMn6fHPSVKHVHVNpMiE+ggLiJC/6XmQS3TcCioiGQ=;
        b=npHq0rXVKZNZ6hY46RzwiGuQSH1tm3d0uACQwFK707GYTkAhZH+8n4kxV0MBxU236X
         P1DtpHaDth3d86a3FdZVODEWd1p/CJZOS34kWnapBaFX8sTk5ucuPV1MjP2UygRMHTMd
         XyRKCkOW8BpVRGYZ/cpBmgeHMaswKptCkPJWt0AdEg3nk5zQwXAFat8ZH3U1Tjx95Jov
         rJxg1xdawpMX2JBE9qBN9X/0Et4CH8mt/4YlDFLuUWfIva+9RcmDfhg+aZgDzgrjeqRM
         MPeUl4OzNSUkKjY7AGrCGvkxxbUT4oh3SUA0W5nOidbfiA8v4oURrx4VA/sFvcJeUbGN
         q8+w==
X-Forwarded-Encrypted: i=1; AL+hErErdHkRUunt7wr3OrmUjGKXvzV3OBtSL4q4MlTAHHv/AceT3Gwy8ggxxf2ZEOcV8+k0PbCJVw==@lists.infradead.org
X-Gm-Message-State: APuU4Z8rIvFzLacGJXNu8bRwnZOq4B4BffUfB8c0kPkuOaKqWC3iSwRZ
	Bj6kf68SBOtPD2nrRS0ze8WsIAyMVi+qMh1NeOiVf+BpFKWDJaspMUfzhOUnXZcDM+1Q8pzzqZw
	nS73vnUvTPkYOZFBl6wMzOtBlliLYJ8Umn7rBWj5ww9gGE7mcAxsZqT5i2qT7kgz3eYXTPrjXl9
	tzSZFqi2C8Y3HL+rCbHRToF5sfE+JabaZw+L7Ljm79tzRnQJWZPzaNUJwHMWwGAaGdwd/iLanMT
	h1ESReudDiI
X-Gm-Gg: AZFdTZc34QUCIunQBTUdZnXcqjfDMGq2Tz4a6jKb1HjnFtIE3XinhvEP7Oh/gYTu5yu
	IqhhQm180if3ic9NRUO1YhG8OWDYDHbaLUmG+xXHrh31HZFoFBl0C1INBhXdOhSKyporZgE58Cg
	hbx9YY6j/xgOxIJ3ya+VBdk2gn20aTQa3eoZnhASDLZThWNSwqY9L8mPGJo8qmhpmCNvg0KdJXp
	q6kDkBkewThHjHO5cLHkKngTvTc3oauywdeHchdMW0T13boil4cLFFcD+2Wtki0Xe2c/XUx5bAu
	6HRp5uJOiRNDWkmy7lnFL6uFbhstnGDcB276i6vkNSgLv0FX+DzsIXZrj7iT/Ay4U7XSDS9t/Pd
	dMrL8DQ6U9XBW8b2AoHYWWeshcKSGrLMA8KH99v+zB4hbUXCwTNHSAEct/MuxZbi8fZ8NVk88Ml
	SJBgCVSX3NOrjJ2CrsRIk7sKYeVrrHkcYI
X-Received: by 2002:a17:90b:3b48:b0:3b3:b71e:b2f3 with SMTP id 98e67ed59e1d1-3b3d07d45e5mr1699163a91.45.1794981734384;
        Tue, 17 Nov 2026 22:02:14 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b3d0eac5f4sm1249699a91.1.2026.11.17.22.02.13
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2026 22:02:14 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-55d33f412b1so10406261cf.3
        for <kexec@lists.infradead.org>; Tue, 17 Nov 2026 22:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794981733; x=1795586533; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I0NMn6fHPSVKHVHVNpMiE+ggLiJC/6XmQS3TcCioiGQ=;
        b=A3dh8F1jLmKXkqkK7XedZpCphyRPaRmYOg5VJ8rHdGAH69pV0500fm0V52yFaf4IoQ
         8Y06aWfc4S02NesZKIwRmlJ55ku5xM8ZfluVTlpxMbNLFklxVrc6bOwRIl9CC6aCCugY
         gKaOCvoqcnAmsrUqHpkuZJDPPg30zumUDGdxA=
X-Forwarded-Encrypted: i=1; AL+hErHD41jV7rXIu06PbpUFWbHXs+h54DCvMx3FnGXL30StJt7+KOVbZrfBE/xIeS6WWo2/4pY1eg==@lists.infradead.org
X-Received: by 2002:a05:622a:551b:b0:55d:1944:a2b9 with SMTP id d75a77b69052e-55d5a5b7756mr24482391cf.51.1794981733060;
        Tue, 17 Nov 2026 22:02:13 -0800 (PST)
X-Received: by 2002:a05:622a:551b:b0:55d:1944:a2b9 with SMTP id d75a77b69052e-55d5a5b7756mr24481831cf.51.1794981732440;
        Tue, 17 Nov 2026 22:02:12 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d58ff0065sm14886841cf.5.2026.11.17.22.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:02:10 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>
Subject: [PATCH v4 4/4] x86/vmware: Report guest crashes after kmsg dumpers
Date: Wed, 18 Nov 2026 01:01:51 -0500
Message-ID: <d0f9c1188b5f78bb20bb43737b3cf80c5c0f94f4.1794980455.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794980455.git.zack.rusin@broadcom.com>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_220216_506689_CF2FD24F 
X-CRM114-Status: GOOD (  17.73  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, Bradley Morgan <brads@mainlining.org>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner <tglx@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VMware accepts a structured guest-crash event, but a host configured with
backdoor.coredumpOnCrash may terminate the VM before the hypercall
returns. Keep this event separate from the log sender, which runs
earlier in panic.

Register a panic-only kmsg dumper with late_initcall_sync(), after built-in
dumpers registered by then. Skip the event while a crash kernel is loaded
so the host cannot terminate the guest before kdump saves its vmcore.

Issue the event at most once. With CONFIG_PRINTK=n, use a late INT_MIN
panic notifier. An unexpected dumper registration failure with printk
enabled leaves reporting disabled rather than overtaking working dumpers.

Link: https://lore.kernel.org/r/20260309235250.2611115-4-alexey.makhalov@broadcom.com
Co-developed-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
Signed-off-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
v4: No change.

v3: Rebase. No code change from v2.

 arch/x86/include/asm/vmware.h |  1 +
 arch/x86/kernel/cpu/vmware.c  | 62 +++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index dc3cf8123914..6d3c9922c92b 100644
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
index 8c8b6dd7c3e8..ead9f50cf89e 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -22,9 +22,12 @@
  */
 
 #include <linux/dmi.h>
+#include <linux/atomic.h>
+#include <linux/crash_core.h>
 #include <linux/init.h>
 #include <linux/export.h>
 #include <linux/kmsg_dump.h>
+#include <linux/limits.h>
 #include <linux/mm.h>
 #include <linux/panic_notifier.h>
 #include <linux/clocksource.h>
@@ -330,6 +333,65 @@ static int __init vmware_panic_log_init(void)
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

