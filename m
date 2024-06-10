Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5987C27C55
	for <kexec@archiver.kernel.org>; Mon, 10 Jun 2024 10:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q5cfdhWuR2/iWFhQBz/LMneTm5/KHHFLAk3ndRd5i7E=; b=Z6bGjLkPZP8alt
	igB3yES0aCCMRI4AvIFKmIOG8bATV9IOhVks5iUlWTiuFItrFpucPKXVCYg/E70UvcqQW88msiO+a
	IvklQ51f/SmQ61+vqxpYVIbp+Hvi8b1SIFo2HePcnlAYi53eB7ZIjeiY4L0k1T8rhuuvJbGSTk/4v
	hjH/s/RYGT8l96+hvDt7QhqpYVW1uU2Dppa4yF68UmDI3NskEHCu5ooGej5OwyoiTHmBDipQc61dY
	k3a1FfW3Qi05BD7i9wzrrFlqDqBaAVdQ9J2aCOtdceVpdl1LRhkSZ8RVDxnCf9IZd72QKYSJ0m2yG
	drVNsdbX2hILjXgC+28A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGc9t-00000004cVF-0KTq;
	Mon, 10 Jun 2024 10:21:49 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGc9h-00000004cKA-02b6
	for kexec@lists.infradead.org;
	Mon, 10 Jun 2024 10:21:42 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a6e349c0f2bso339382966b.2
        for <kexec@lists.infradead.org>; Mon, 10 Jun 2024 03:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718014895; x=1718619695; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoHFRW4tBY00Dbn8PrHJW1+pduEfvLupGWHJaJBOf7w=;
        b=FKFuv4FrVqhvJ1AwurXXpu1EZCMKbrb285CmFw+9VnTAGsE1iKvrXxj9dccAeti7iK
         La0BbOE+kgRe6P3V08xD+bnMCdDcRrfawJzXHdHNSaZ+LJLOWl3sTnSVMcUXehRgtVK2
         MUcdDuc19/N4iuZFLglI6NF0e+X9tNVkxaDKA/vCOsJDfbZ5+n3y/IMxNpCYulOw7ORi
         eJ4kcwD6VXtDGserJ7y23N/ld6ODuPtFhftcq+tqp0FiT+lS8Z2V5goT7DVu6KE/R8AJ
         DAYrO0BSZDCYsViPEi/hKsQXoHJ7qpl0bZUkzzUZXBDuyc04XjN22bN62FJUEWWoPGeC
         UWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718014895; x=1718619695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aoHFRW4tBY00Dbn8PrHJW1+pduEfvLupGWHJaJBOf7w=;
        b=o/MpmjpGxvy/YXlsGqTus6+eT5ofEw9JbyqwJ3AKGrko4JSfTfT2QqQPz+d5W9U+dv
         PpafLqquR9UNGG2JHm5yQTne2SzTtvpoOnafJeM3JDn3wz3tc3uFcqm0f3Rc/IG9M8IG
         rVnV9GEk52d44aaKC+6Dfms8XwWVZZnttlgpnW6VBh3X1zgAsJw4msdpZKbS1hBxXe68
         rtzw+RHBcHHDnbbcXKclIidBlZOK5U2IjNb4psDv0Wi3uv5nOpIYy4rfZ43KD1d2R/QG
         e+BFvpSK9elnRMZj/dYtV6dhuBDeE1aEWnBhw7b2W9osK5WFRbowq6DoN5+TpJ7Ex8xE
         Gt/A==
X-Forwarded-Encrypted: i=1; AJvYcCX1vwqqU+GNX123Frhkl4tYFOXHtrJ5Ihq7JZdz2Zreh6O4SXdVBJ9G8ApNDJtdNCwJKp/m5qzeVn4GN/J/jRCn4EB7u5Qc4rjt
X-Gm-Message-State: AOJu0YwdC5Xb8HpY+PF8BQ2iIXb/7Adpdd8uU15/AjUlEX1FEjgCHPYv
	DJIMFsk8l8wQ6DXER0Rhht1DKzX1OHvk7Rhn5mHE0QxdvlRbe7P4
X-Google-Smtp-Source: AGHT+IESMzVFf+AerzXltPGxT0c2xQkXFKXDrzd1HTo0VAZxc9MRROEt3iL3xUr1my5F1e40MBIekw==
X-Received: by 2002:a17:907:7e9d:b0:a6f:17a9:947a with SMTP id a640c23a62f3a-a6f17a9f1bemr225645366b.71.1718014895432;
        Mon, 10 Jun 2024 03:21:35 -0700 (PDT)
Received: from vasant-suse.fritz.box ([2001:9e8:ab68:af00:6f43:17ee:43bd:e0a9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0d7b35d5sm290887766b.192.2024.06.10.03.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:21:35 -0700 (PDT)
From: vsntk18@gmail.com
To: vsntk18@gmail.com
Cc: x86@kernel.org,
	Borislav.Petkov@amd.com,
	Dhaval.Giani@amd.com,
	ashish.kalra@amd.com,
	cfir@google.com,
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
	michael.roth@amd.com,
	mstunes@vmware.com,
	nivedita@alum.mit.edu,
	peterz@infradead.org,
	rientjes@google.com,
	seanjc@google.com,
	stable@vger.kernel.org,
	thomas.lendacky@amd.com,
	virtualization@lists.linux-foundation.org,
	vkarasulli@suse.de
Subject: [PATCH v6 06/10] x86/sev: Use AP Jump Table blob to stop CPU
Date: Mon, 10 Jun 2024 12:21:09 +0200
Message-Id: <20240610102113.20969-7-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610102113.20969-1-vsntk18@gmail.com>
References: <20240610102113.20969-1-vsntk18@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_032137_251778_D29BD63D 
X-CRM114-Status: GOOD (  16.67  )
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
index 963d51dcf0e6..6f681ced6594 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -232,6 +232,7 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void sev_show_status(void);
+void sev_es_stop_this_cpu(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -261,6 +262,7 @@ static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
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
index 84b79630f065..8d3cc5cd7e11 100644
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
