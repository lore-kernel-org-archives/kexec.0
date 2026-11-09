Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E8D606A337
	for <kexec@archiver.kernel.org>; Mon,  9 Nov 2026 05:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zooF6i3y;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=e+oQ0CZX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gWw97lsSXhpRitO5f1gnEdnOwIiPfae0nOjP6jdEUEo=; b=zooF6i3y5CRw67mD/TZNQiDqv+
	HARTHmXHdtegkWe0z+6ma9zfysVGge5zOBq9y+neLWMM1sKMoG5+JGenfhvhwSyl+8LHp6XoxruGp
	MHu+0TeEVfRqQveWwhdAHl0fxGJGAH46lKM93E0L9UY0YZaIPKUevRfikoKybTuisCSC6DqB9InTM
	vwAI8ueVGIASuAVut5Rtx6xoKUC9fUu+5vYHeYqADLyUvycn+UUMfN3OL2zBp/O/MFsd/oCYqNPXV
	qF7r+VT4Vq4IELgcsEeqPt/smmoDf4tH38zA28faYidUIpgD4JK4wYZX7Vq5lDLafowWyAXqcRgNe
	FCpJiyZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQIEs-0000000HSDo-2Lae;
	Mon, 09 Nov 2026 05:48:18 +0000
Received: from mail-vs1-xe64.google.com ([2607:f8b0:4864:20::e64])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQIEo-0000000HSC1-0Xyv
	for kexec@lists.infradead.org;
	Mon, 09 Nov 2026 05:48:15 +0000
Received: by mail-vs1-xe64.google.com with SMTP id ada2fe7eead31-7d2ca055399so153499137.3
        for <kexec@lists.infradead.org>; Sun, 08 Nov 2026 21:48:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794203293; x=1794808093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gWw97lsSXhpRitO5f1gnEdnOwIiPfae0nOjP6jdEUEo=;
        b=aX8JNasZR29EBHBvkEGF6k68ZNpXhRitnG1iMZPQHHqzAm5iK9xPsvO7QiOvZbaS1K
         zS4T6PU/GucxIZaLyDNqNwEd4Ktvns8lEV48sPFiEnAwGbrZNITy7LoQoDWi08XhAOhl
         iHhoD9IEu/0uDa61qroFo0gHglJ2N2zZ84qYmQTUeeX0sglo80eJMjNuEDZ1PJISL/Iy
         76WYOdYayky/vxNxjq4tANQFfL00a5J/go9dVoOUsslvuqGmDzIzmw9dvXqafGOnneOf
         6LOh8RAyMgfdHTEHAuxBhtlzOCCe5oYU7L5emUco6ZMfJHwvgYxzlDWWQpteqWtExTB5
         ZgOA==
X-Forwarded-Encrypted: i=1; AL+hErHKmPzp5k5prozlnx0+NbwYgrEsP/KBUGJ092Uyj8fF+0Z8HJH/nfZMVEzjQG8cIi/PF8Gw+Q==@lists.infradead.org
X-Gm-Message-State: APuU4Z8CRzt/hWQ/JaKJxRCcZsowspRjzuO5VD58/twB7kMEgCLM578S
	ikCQBqHBr2S4x+aq5RZc8FNrPa5yMBa4GHnqg1eFcBgdWqcdewpO3J0bgIe96G621d1V6Z2lPBA
	y90PoTBaNNxabVpp7P64Zq0z4rIEzQJbWOyLmxJrGWKDD+AQagpMo2cKs8uHWXl+c5JYhf7N0ZV
	rymmtSpBNbRIdXMVavIwGrtZJL9zlc12a7BjWndWcxqfE6q3YGo79Jl6LYg1Xw2e+e1UJ+w6oLp
	DKBhntclpZO
X-Gm-Gg: AYBFou3PRuspXqAD/PPEFqaI+fMaJHi/VOVIXPEr1ddyw/CCQxlXlLDOCjRkhGJwbJY
	ENoxSnsoMaw9sULNmbkpINBZ71cGRjdHdR5KZVA0vOkqry6SrncoXIZQb/nIUGo5XDSduMpZGU6
	/36T2eBGWYtcwbPoINTC+nlx+gpMef2NooOGXqWWM7BQX/5kpktBHXAwnBW7qpKGN3nFTUhT6pQ
	oHV0GKlZNwy5A69yhKxr+CtI7pxkdCrNDs5Tnatnj9xywreaeU8x4QLOwVM7XI78EfzCF/UZp9/
	GMaQ+qLqd1Hd47+tn7rNwXEmZ8ttxP5SV/e1jhE03KZ3WBg64RFTh/udAnU4TR0cjitx8hbWocM
	+Q0l9y+7+pgzBDJQOJFdyukVx7gxQzPEeLSmx2TIG+CjcIYtHXgNAp4Yzd5LMk6DCOGb6kpWrb3
	nX3Ehgy8EYTONO+82gRf1HL1ZH070RY20n
X-Received: by 2002:a05:6102:5107:b0:7d2:b21f:ce1d with SMTP id ada2fe7eead31-7d2db11ec3cmr549026137.25.1794203292510;
        Sun, 08 Nov 2026 21:48:12 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-7d2db561eacsm28005137.6.2026.11.08.21.48.12
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2026 21:48:12 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-154e9d2d94fso414130c88.0
        for <kexec@lists.infradead.org>; Sun, 08 Nov 2026 21:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794203291; x=1794808091; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gWw97lsSXhpRitO5f1gnEdnOwIiPfae0nOjP6jdEUEo=;
        b=e+oQ0CZXpEtvq3WlCClU6XcrPaFpyjpxaAjDGV6fhEsGL9H7eMI8gdURbbO1tSXETv
         kIHKtORZ/NzPs5towNWRYxclUz5m/gJXoap0w/xpY4R/cnxYYisMd9nTAsn2i0/nAYyD
         8Dbk/XSsHMAuRIWlhWod+jWE6MW1CRA+BaZkA=
X-Forwarded-Encrypted: i=1; AL+hErEImLHYGd/YxPDfOXn6c7pRY7QGD77UW+Kh7B0K1vMc3jda09lLYABJoq3L+OiE1a0qgLSDwQ==@lists.infradead.org
X-Received: by 2002:a05:7022:b052:20b0:1ae:abd0:e2b6 with SMTP id a92af1059eb24-1b39ff033c5mr5293805c88.38.1794203291162;
        Sun, 08 Nov 2026 21:48:11 -0800 (PST)
X-Received: by 2002:a05:7022:b052:20b0:1ae:abd0:e2b6 with SMTP id a92af1059eb24-1b39ff033c5mr5293760c88.38.1794203290476;
        Sun, 08 Nov 2026 21:48:10 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314626dsm13745136c88.1.2026.11.08.21.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:48:09 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>
Subject: [PATCH v3 4/4] x86/vmware: Report guest crashes after kmsg dumpers
Date: Mon,  9 Nov 2026 00:47:40 -0500
Message-ID: <4dc02120a69e0d4b21f1ea3a12b4aedf6f22e706.1794201807.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794201807.git.zack.rusin@broadcom.com>
References: <cover.1794201807.git.zack.rusin@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_214814_190121_7DA920A6 
X-CRM114-Status: GOOD (  17.57  )
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
v3: Rebase. No code change from v2.

 arch/x86/include/asm/vmware.h |  1 +
 arch/x86/kernel/cpu/vmware.c  | 62 +++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

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

