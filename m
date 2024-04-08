Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539E3CD1292
	for <kexec@archiver.kernel.org>; Mon,  8 Apr 2024 07:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y3uzlL41xSLKGg7vwWsZSiPOEKsaJl+8DkgnFn2wGgQ=; b=yog8+CMrV8GtS+
	hVhMnN3ERbNZ8EJ4bDnggcIONiNHkNoIDSAW5t2xs2Cnn9BOpsWdIg1qFelLbN22bNzfj5V5jxZnN
	16a5+Sz73vzFvdHaLhn9b/4DOYrhYxeLxKmBqbGmvujAdlkv8DBFMqaSJeJ9ETyNtpR5wFfpUhIZ5
	Nj1uxKqyW7k5sTSTXxhj6f+9JgQwczHbYtP6kTFphkk29/xhgory75sZy5ky52WmyB9vve1LKyj4V
	S/MtBRgo61AjVug1Wkdp6GPr+Rilr5gd1oB7jt5Syvg5CVQco69TzacgFEVeQrweWphUEaVN4jE8j
	POSwcjMUMtmpgeDwD0OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjdW-0000000Ehr7-2GnJ;
	Mon, 08 Apr 2024 07:41:50 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjcy-0000000EhXn-21L0
	for kexec@lists.infradead.org;
	Mon, 08 Apr 2024 07:41:20 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4163de295f9so6053095e9.2
        for <kexec@lists.infradead.org>; Mon, 08 Apr 2024 00:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712562073; x=1713166873; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJpD29/pv52tcSTFE56JNh7gpAMmLYs2U80V4FBahpg=;
        b=Fad1Q13oM1A6ZoVvjWdDBs/ccZWGDiOQRH9SjqEbtNqNVtwUMPQhC9ojEhZ6h8XxRd
         LqM5CDOHnF+CI5GIunfLNqyDUeKRsVCihZ+J53Ay54Msu2xWKe1jdIVCATeJPTcBC8w2
         INH/+tScRHm/L3N1NB7de6Jqwsf5JmdI3+DSeROgGpnhCmZ6DOcC7NgCtOxJU6hsakVh
         L6OZJzG+FpwVVHxFPPDrvPuOqIiOmsZvwwYU2bjXeI1JG73gMDKW3LStWaqlIUxtNpdS
         f/NVfJje+g7rm5hZyCdnpxi1UU5oGjQq8VgJ8rGz7dTaJvW1aR2hIFRImfaOt22VoHpt
         ScJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562073; x=1713166873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJpD29/pv52tcSTFE56JNh7gpAMmLYs2U80V4FBahpg=;
        b=YEF/FuhkgzH92w/4j1mkQQGvvOimR+uSEmYHRSs5I1hv63pnk3jYpJMTHQsiPKU+jx
         UgEuw9DLvIYK3PUpPB3pQvGCB3EkZcbEE424+4SCZ4N+rzNdQ4lpfQHq8AorKY9TBB9i
         RvA6lAS8dtbzVPoy0WH/RV3B49BW/rYsEIRUqlnrPJaArlt5N2w4pkKs2I6CyePBEKGR
         CMpeb9gvyY30LYyqccYBz7ELxl4MPHUlTVjaRfw1fQ9uEp6Gxhhue5IQilJetZ3kEQtf
         Hy+8AVNt7UXNG2RMakKTitR82auSUh6MrFkutlyc0T4Cqx94RZ2yA/mNFK+qGh3aR1gK
         zvXw==
X-Forwarded-Encrypted: i=1; AJvYcCXwYtOnMBb45hE31oifaZyPvCg4Ldk3BjcWwDtZjO2/HyTGjx56TJt2uWlCiERqyRlyvNNJ8d6oemnOAFfwhFtrmLb3zTFJkTkq
X-Gm-Message-State: AOJu0YzjOjd+kdQrsAkseTlgq2Eow4kKC7DyL6m+kPCOF5gFOfhkx5Dq
	7XjhlEW68ndzP/BZ1oKW40wz9gNVqudUsTU6Y5kqeLF56zeVM6xB
X-Google-Smtp-Source: AGHT+IE8QCaOWgeggvX3bzfdgpzjd9AKZpVWk5t3o1rNmV0yg4I7I6xr4BI4sOPOf3U8/XIcokRopQ==
X-Received: by 2002:a05:600c:350f:b0:416:7071:6eff with SMTP id h15-20020a05600c350f00b0041670716effmr1229085wmq.41.1712562073135;
        Mon, 08 Apr 2024 00:41:13 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab70:9c00:7f0b:c18e:56a6:4f2])
        by smtp.gmail.com with ESMTPSA id j3-20020adfff83000000b00341e2146b53sm8271413wrr.106.2024.04.08.00.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:41:12 -0700 (PDT)
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
Subject: [PATCH v5 06/10] x86/sev: Use AP Jump Table blob to stop CPU
Date: Mon,  8 Apr 2024 09:40:45 +0200
Message-Id: <20240408074049.7049-7-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408074049.7049-1-vsntk18@gmail.com>
References: <20240408074049.7049-1-vsntk18@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_004117_294258_80F363F5 
X-CRM114-Status: GOOD (  16.90  )
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
index 829650bdd455..dba6cad1f7d3 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -233,6 +233,7 @@ u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void kdump_sev_callback(void);
 void sev_show_status(void);
+void sev_es_stop_this_cpu(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -263,6 +264,7 @@ static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void kdump_sev_callback(void) { }
 static inline void sev_show_status(void) { }
+static inline void sev_es_stop_this_cpu(void) { }
 #endif
 
 #ifdef CONFIG_KVM_AMD_SEV
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b8441147eb5e..0bc615d69c0e 100644
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
index 4c235e310487..17e4263cc7d7 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1357,7 +1357,6 @@ void setup_ghcb(void)
 		snp_register_ghcb_early(__pa(&boot_ghcb_page));
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 void __noreturn sev_jumptable_ap_park(void)
 {
 	local_irq_disable();
@@ -1390,6 +1389,20 @@ void __noreturn sev_jumptable_ap_park(void)
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
