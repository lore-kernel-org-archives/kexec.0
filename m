Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C409C5475B
	for <kexec@archiver.kernel.org>; Mon, 11 Mar 2024 16:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RPwH/CAVAY+4pO6bDRTs167vLeGI632bllh+TPID8GE=; b=ETZ3pXbbANiG9f
	1ZfNIwl4dxknzCCtrmzL/IyBPzq3GzgYFnfO6pzHhBE6PQ+PGytk6gKUbfPCSWOzHTIjMJ9MhMAia
	N8cjAhctrqq4N2ObS8RRzRpIHTGXY5TiqJZ7Z3c48twOuq2xLG3O+FIaAA3rLFmyHUVe52whOZMAg
	WNYlQcHxGRgH60jFZmgwHNA7Uncg7QLZj4N6el3lY7hrNEUJm5Cixci0NSlPXGPNbrc7Euhcb6quK
	CPCfCUH4DyFoVgzoZQ3GOdxNrAeq6EkSIs9SYquJlPoy/3ldBw+NcS7ugOZwjW/RMniLfW9W74bFt
	lihOubo1xgKvVRCwERNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjiLi-00000002GuO-1qhk;
	Mon, 11 Mar 2024 16:18:02 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjiLY-00000002GmY-3e3H
	for kexec@bombadil.infradead.org;
	Mon, 11 Mar 2024 16:17:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ImRzpHgQ7+uutfuh8SJRk0DTE4K/6LtArW0nv9lfM+k=; b=fdBJAn6xbVYrFnCriKfvT4txyA
	UpycMpOdw9fqnBGTd/rwUguC2HTLgzZbTjH6Ill4GbSc5S1VlXXHsWxYEM2q3mxizq/Ek2owCseQ9
	oaivwPgrR/kJS7DcPrWlvMwkkDVSyN9LolDG2AbjOb1u/oKD+5cNVtHKlFaPV/wmZazVV2YNGXGAu
	XbI0RFMEnks9hbypJh6L0ZBFOsuMGgukp5EyZuv7tOSSFEInb0IK4YPjas7nUSGbLzoYe3i8ho9pw
	bPOU3eL9qY/lDNW611Iycul3w0uYZpHvs2Nur1yCyArMzHfgSP8V9hZnkEm38MWueSK8oujcq0bVl
	2bd/lxYQ==;
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjiLU-000000092wL-2bBE
	for kexec@lists.infradead.org;
	Mon, 11 Mar 2024 16:17:51 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-33e99b639e0so525173f8f.0
        for <kexec@lists.infradead.org>; Mon, 11 Mar 2024 09:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173866; x=1710778666; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImRzpHgQ7+uutfuh8SJRk0DTE4K/6LtArW0nv9lfM+k=;
        b=JgW7Lj0zCP4lWj1vjAGed12D0Y5G0uHvhwcll+G5CRpFTrqkEcYfyVpkvasoP34Zyw
         uQ6llPedAkLJvDpgCRdxV6RtfA7b9lju6VDK3sG6c7Hk8NKZViYbFCc3yuIoMrtwHXae
         UECL7Q+fK84xnMdKXgDKaOAtsdDIJ2oTIwXeY6uq4nUwTFP+qhi/wutf0IyIR0qyKEdq
         zpjMT2MZfuQNvSo4Uogkl7NK5bHmhbpaS1v0cpDjoWgBBitnYQEh7gzsRYU1Rf84mQtJ
         w6bZ40Agel5juJyd/OI/bY8D6Ql59B86QlhkMOgob2xNUKxJ29pqJyaksgeiIF5+QXYl
         Hcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173866; x=1710778666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImRzpHgQ7+uutfuh8SJRk0DTE4K/6LtArW0nv9lfM+k=;
        b=PG0sxN9Z3fGtP31UwL6+0qLRZ79FWuEPvDaQi6qAHqLjvjXIILF8TloX8w0oMYRCku
         U98C67SXJiZzENin+XFEGORs3i9gGW7Sv7kNL3Cbs/x48REColPAqdZuUNTWgsis8Nmb
         xqcOJMavS7WFzCTy/M9qAxMRqpZxt+ht84AXclF7gp/YLQhQcMV7pxuPyExa2/p/D3ww
         9BQ0gUkviEMy+34iEHO6WEGnlXvn9tyLwDR8qHPejKdreryK5Y7NCkxVp4OTdjl06aac
         pn5UQBMmNKlgKhgLsJwaT7z0CX6KyuuoYwQu7Hmv1NDnSpSW39KUOqlTiRGFQRtBOo/G
         NGbg==
X-Forwarded-Encrypted: i=1; AJvYcCUuv+BKaK5nyVu0DNhFfVBV/X40vHCWCekFY9dZ5FabvM8WqtonV6lAVf3tSWYR0yS3mfwoRuwTvbBXwXmY/OgsBOGOrNZYjRSx
X-Gm-Message-State: AOJu0Yyos9Ddgebr2SYsrO4cUb4xUrDyTEXgCrOrZ750uZbvaE9wMw1g
	TAKLaJUBtmmVX05z//7+9epZhIMhe/gXMRP2B8WXO7qDY9cXP+VQ
X-Google-Smtp-Source: AGHT+IEG0QdNGOuIWSe9NXJvczTc8p7SlmtsuTs9Nh46GFsp/syoRmIiV9TumgTcGzwe4lIUdTQkcw==
X-Received: by 2002:a5d:6611:0:b0:33e:5a33:b169 with SMTP id n17-20020a5d6611000000b0033e5a33b169mr4250288wru.28.1710173865721;
        Mon, 11 Mar 2024 09:17:45 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab47:8200:c3b9:43af:f8e1:76f9])
        by smtp.gmail.com with ESMTPSA id ba14-20020a0560001c0e00b0033e96fe9479sm2823815wrb.89.2024.03.11.09.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:17:45 -0700 (PDT)
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
Subject: [PATCH v4 9/9] x86/kexec/64: Support kexec under SEV-ES with AP Jump Table Blob
Date: Mon, 11 Mar 2024 17:17:27 +0100
Message-Id: <20240311161727.14916-10-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311161727.14916-1-vsntk18@gmail.com>
References: <20240311161727.14916-1-vsntk18@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240311_161748_827061_404FEA58 
X-CRM114-Status: GOOD (  15.16  )
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

When the AP jump table blob is installed the kernel can hand over the
APs from the old to the new kernel. Enable kexec when the AP jump
table blob has been installed.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
 arch/x86/include/asm/sev.h         |  2 ++
 arch/x86/kernel/machine_kexec_64.c |  3 ++-
 arch/x86/kernel/sev.c              | 15 +++++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 2dbd2238325a..26027083a2a9 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -217,6 +217,7 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void sev_es_stop_this_cpu(void);
+bool sev_kexec_supported(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -246,6 +247,7 @@ static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void sev_es_stop_this_cpu(void) { }
+static inline bool sev_kexec_supported(void) { return true; }
 #endif

 #endif
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 3671ea1a5045..6013ba6fc16e 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 #include <asm/cpu.h>
+#include <asm/sev.h>

 #ifdef CONFIG_ACPI
 /*
@@ -269,7 +270,7 @@ static void load_segments(void)

 static bool machine_kexec_supported(void)
 {
-	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+	if (!sev_kexec_supported())
 		return false;

 	return true;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 73477eeb7de2..66e85b82d170 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1456,6 +1456,21 @@ static void __init sev_es_setup_play_dead(void)
 static inline void sev_es_setup_play_dead(void) { }
 #endif

+bool sev_kexec_supported(void)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+		return true;
+
+	/*
+	 * KEXEC with SEV-ES and more than one CPU is only supported
+	 * when the AP jump table is installed.
+	 */
+	if (num_possible_cpus() > 1)
+		return sev_ap_jumptable_blob_installed;
+	else
+		return true;
+}
+
 static void __init alloc_runtime_data(int cpu)
 {
 	struct sev_es_runtime_data *data;
--
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
