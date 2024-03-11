Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E172C54E58
	for <kexec@archiver.kernel.org>; Mon, 11 Mar 2024 16:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pquMeKywAUOcT382xF66UoJxLsilIx6R0ZsmKBVNZSI=; b=4wbXmVrWlIrxSm
	rh2mYRhJDY8fLQOUoJLHJhQ7t53WjqxYHpVOgzrlla8cyGdEDup60zJP6csHM0pARPVxYXSeg5MSq
	3Piv2MN9UJlIZsOBbR0zwol9f/nqj7usMGABC/8PAyDNdaYfU2t1oJQ5CZlGVkBDugFjJFkg9HBeL
	MqVJ2s5QElenKUyh8ujpsbAZp4KFzUHW+h9eFYk7JypKXeog0VPONm26PNSuJJw5os91lWp/P+c3h
	LKPi3EgWYWTjrXWX9yC9z8SQZ49Blxjp767IUuCBrFB6pPSNFAbzk3qY5zM9paRQSsxe6GRA0/vEH
	pv5Pv6KA8w03cHQGh8xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjiLd-00000002GqV-30ad;
	Mon, 11 Mar 2024 16:17:57 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjiLP-00000002GeA-0vFS
	for kexec@lists.infradead.org;
	Mon, 11 Mar 2024 16:17:50 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4132600824bso8273475e9.2
        for <kexec@lists.infradead.org>; Mon, 11 Mar 2024 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173861; x=1710778661; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xZKnKV6vagYMs+CUwMzgN6IK8RsSRi3wmiW45NPZ9I=;
        b=L4TOFgCl9giDMEladDxL59Lp/+ji7XfQKgAA7b03u/UwmKvR6dIHE4MUychYXux2Zx
         YasTErX8l2iiUApgwAJX465eJTmBxDWb59itTlVOWn3zL9/AQUQAwDoJix+MoegTsN5I
         YB4oxTK/Lj38nJ7Qp81dhi776xoAQOGStmVz2fQv9s+8PrIT37uTHgZPUWqBNEpKWdbD
         ROun9RAsIAGVmWl7OO/z+hRyOurtisPwQB0zLjTKD1X2amdcxumN44df5yQ8aRb7G+xx
         8rXMDK+9t0AEVX4Gjvz5ICCXYlPi+Mujge74ne11CfhWq91tRU+RTJwL1pYRxdb17Yfd
         23eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173861; x=1710778661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xZKnKV6vagYMs+CUwMzgN6IK8RsSRi3wmiW45NPZ9I=;
        b=wX5+mOC74m7KpR+2HvAPH3XzakrlEEaTbKnC1xyh6cfrqGPkhLxL86cVujz8aHOYiG
         n4tbY++8m0mZX9T7FnSyN8cibxufwSUiRrpSNxJ8VzYrP7UIqfU952y9arBxK9dqmEdH
         gIPeumjeVWzfKYISNiXjZCYWVpR/a0v4y4FDrlCPLOLmFnHDLrcCRgo6E+TbJ1HEE562
         PxsCARBGYUOZlHPEd+4hSp4CBz5YzKTqASmVaVECDWKQ2K/DCcMGn+skpidjBi5/mE/R
         8bNntWGZW4PrTcvDmutIeU+F2WY3gs8Tu58lLkwuz0eXIZAJ0On969EiGR31fLJOFVs+
         gCKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWht17RhWzRY9hqgLQd/Y/ng3Csa3i+kXZn/+/GyeFsZpBUzRbGNGbk0EJjybe+qWK/ksQgbaenjDSdwrpS7SqQsQEeLo7NKlnA
X-Gm-Message-State: AOJu0Ywii4GUU9b2wUCUNj34kJjUuuEUUmfzNP11LfmiVqiQ56ex7nDa
	B7+2asjrV6SVGZhWQ3rpFOYFHbkQQGQt+bJK9TE3qbRSZC0SFusn
X-Google-Smtp-Source: AGHT+IHdxdRKuyogtANKix0xsfVIxJjqfkRL3xOpZ/E6JkPe6fFXU/lAH+e1wKvVax66n9KjcPMJqg==
X-Received: by 2002:a05:600c:5026:b0:413:d95:bb2c with SMTP id n38-20020a05600c502600b004130d95bb2cmr705386wmr.33.1710173860999;
        Mon, 11 Mar 2024 09:17:40 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab47:8200:c3b9:43af:f8e1:76f9])
        by smtp.gmail.com with ESMTPSA id ba14-20020a0560001c0e00b0033e96fe9479sm2823815wrb.89.2024.03.11.09.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:17:40 -0700 (PDT)
From: Vasant Karasulli <vsntk18@gmail.com>
To: x86@kernel.org
Cc: joro@8bytes.org,
	cfir@google.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	ebiederm@xmission.com,
	erdemaktas@google.com,
	hpa@zytor.com,
	jgross@suse.com,
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
	Joerg Roedel <jroedel@suse.de>,
	Vasant Karasulli <vkarasulli@suse.de>
Subject: [PATCH v4 6/9] x86/sev: Use AP Jump Table blob to stop CPU
Date: Mon, 11 Mar 2024 17:17:24 +0100
Message-Id: <20240311161727.14916-7-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311161727.14916-1-vsntk18@gmail.com>
References: <20240311161727.14916-1-vsntk18@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240311_091743_394211_4D9661C8 
X-CRM114-Status: GOOD (  16.81  )
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

To support kexec under SEV-ES the APs can't be parked with HLT. Upon
wakeup the AP needs to find its way to execute at the reset vector set
by the new kernel and in real-mode.

This is what the AP jump table blob provides, so stop the APs the
SEV-ES way by calling the AP-reset-hold VMGEXIT from the AP jump
table.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
 arch/x86/include/asm/sev.h |  2 ++
 arch/x86/kernel/process.c  |  8 ++++++++
 arch/x86/kernel/sev.c      | 15 ++++++++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index c48db0bfb707..2dbd2238325a 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -216,6 +216,7 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct sn
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
+void sev_es_stop_this_cpu(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -244,6 +245,7 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
 static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
+static inline void sev_es_stop_this_cpu(void) { }
 #endif

 #endif
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ab49ade31b0d..ddc3fa076f4d 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -52,6 +52,7 @@
 #include <asm/tdx.h>
 #include <asm/mmu_context.h>
 #include <asm/shstk.h>
+#include <asm/sev.h>

 #include "process.h"

@@ -836,6 +837,13 @@ void __noreturn stop_this_cpu(void *dummy)
 	cpumask_clear_cpu(cpu, &cpus_stop_mask);

 	for (;;) {
+		/*
+		 * SEV-ES guests need a special stop routine to support
+		 * kexec. Try this first, if it fails the function will
+		 * return and native_halt() is used.
+		 */
+		sev_es_stop_this_cpu();
+
 		/*
 		 * Use native_halt() so that memory contents don't change
 		 * (stack usage and variables) after possibly issuing the
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 08bf897361b9..10f4294904b4 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1350,7 +1350,6 @@ void setup_ghcb(void)
 		snp_register_ghcb_early(__pa(&boot_ghcb_page));
 }

-#ifdef CONFIG_HOTPLUG_CPU
 void __noreturn sev_jumptable_ap_park(void)
 {
 	local_irq_disable();
@@ -1383,6 +1382,20 @@ void __noreturn sev_jumptable_ap_park(void)
 }
 STACK_FRAME_NON_STANDARD(sev_jumptable_ap_park);

+void sev_es_stop_this_cpu(void)
+{
+	if (!(cc_vendor == CC_VENDOR_AMD) ||
+	    !cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+		return;
+
+	/* Only park in the AP jump table when the code has been installed */
+	if (!sev_ap_jumptable_blob_installed)
+		return;
+
+	sev_jumptable_ap_park();
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
 static void sev_es_ap_hlt_loop(void)
 {
 	struct ghcb_state state;
--
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
