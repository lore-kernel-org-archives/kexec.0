Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB70C4332F
	for <kexec@archiver.kernel.org>; Sun, 20 Nov 2022 12:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mUaEFhYVk9v0WdxeXEwCwJos2LiEz/bFpgNaxOzojiw=; b=mWFR/ATs6VUU82
	d52L7PvQiAcqbBXQa6zaw5G0+j/IpQoBh2lAzZCib7la/bR4hsUKn3UHAb0DkoJo6/9tHedyK6Wi+
	xXYx2KTY8UgmuHetngRgsW6Zx7FozQwi7D5E03JG0yw2Ht5X7vUMjokQMn7jg2LhEzFZmLERDS3X4
	CULn1o6ScPMlu6RWo0poXlhzQDkiY8ntYW8qtR9gFdpuv9E+k7FfrQ9sTmwp4zD4QxRt57aqsThpz
	MI0+BV30UKIKXU5miUfUIv8q0IXo5pijWBUoGIf9ZwB8wnZCEFDsuRYDazz4ut4KeHJS7r38chP3S
	RC1KoAyTeRYnN5SmczSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1owj2Y-0049TW-3y; Sun, 20 Nov 2022 12:03:14 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1owj2K-0049Sd-QM
	for kexec@lists.infradead.org; Sun, 20 Nov 2022 12:03:02 +0000
Received: by mail-wr1-f44.google.com with SMTP id cl5so16049786wrb.9
        for <kexec@lists.infradead.org>; Sun, 20 Nov 2022 04:02:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eV1Oa0Nh6c9ac4bh/SaLTCNd0mYOTPlWSGUePJeqfO8=;
        b=2I4iMmKqa36yimJrFDMlhrbR0TUNe0Vr/IY/e7/EshCxl0iUsEb1hYPrCOtwFmmj/E
         s3rU57/pQQqeVIMsGg9jM7k+x8jI4VjmCWcGNQt+qBgEML49Erv7o3K3bfINpYg4LTPi
         XLkXElcIF88RcBiqNRf4CfKJ7oDaoOwRvuMSKkzzrQtMAa2YccvlP/Dp6de/FNZI2SnJ
         ZHM50eJnirNM1Va77dKjX+jf6bSjsVPLoO2iCXW/ElCrTJu2I0QlY+yxz2YEIE5BcxHF
         inF88heA8vclTJR5MdDDLLafR0vAyjkYZPII95MqPoFF04A2eIB17HlKqN4ZThLjG4Mv
         V7VQ==
X-Gm-Message-State: ANoB5plcr0UnWrjk5rp7We3UuI1zQozatbdc+y/iAnR0aOmi2Qa2tXy1
	NWPvpufsj/GGXiBpGSyw18U=
X-Google-Smtp-Source: AA0mqf53oeJRAwYbEa1QS3NFkwEcjQtV/KqcmNAUM9nbg9dGXf5V7IYKIW1WWpvaRAwRTEyBycRREQ==
X-Received: by 2002:adf:f601:0:b0:236:55a7:348f with SMTP id t1-20020adff601000000b0023655a7348fmr8761858wrp.331.1668945778206;
        Sun, 20 Nov 2022 04:02:58 -0800 (PST)
Received: from localhost ([2a00:23c8:6c0c:ff01:8fbf:89fd:a697:2959])
        by smtp.gmail.com with ESMTPSA id iv7-20020a05600c548700b003cf87623c16sm17169617wmb.4.2022.11.20.04.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 04:02:57 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	pawan.kumar.gupta@linux.intel.com
Cc: leit@meta.com,
	cascardo@canonical.com,
	hpa@zytor.com,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	x86@kernel.org,
	kexec@lists.infradead.org
Subject: [PATCH] x86/bugs: Explicitly clear speculative MSR bits
Date: Sun, 20 Nov 2022 12:02:55 +0000
Message-Id: <20221120120255.13054-1-leitao@debian.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118194602.vpo4xjm4s7knm7ja@desk>
References: <20221118194602.vpo4xjm4s7knm7ja@desk>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221120_040300_868886_492FE53E 
X-CRM114-Status: GOOD (  18.13  )
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

Currently x86_spec_ctrl_base is read at boot time, and speculative bits
are set if configs are enable, such as MSR[SPEC_CTRL_IBRS] is enabled if
CONFIG_CPU_IBRS_ENTRY is configured. These MSR bits are not cleared if
the CONFIGs are not set.

This is a problem when kexec-ing a kernel that has the mitigation
disabled, from a kernel that has the mitigation enabled. In this case,
the MSR bits are carried forward and not cleared at the boot of the new
kernel. This might have some performance degradation that is hard to
find.

This problem does not happen if the machine is (hard) rebooted, because
the bit will be cleared by default.

This patch also defines a SPEC_CTRL_MASK macro, so, we can easily track
and clear if eventually some new mitigation show up.

Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/include/asm/msr-index.h |  3 +++
 arch/x86/kernel/cpu/bugs.c       | 10 +++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 10ac52705892..672de926281e 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -54,6 +54,9 @@
 #define SPEC_CTRL_RRSBA_DIS_S_SHIFT	6	   /* Disable RRSBA behavior */
 #define SPEC_CTRL_RRSBA_DIS_S		BIT(SPEC_CTRL_RRSBA_DIS_S_SHIFT)
 
+#define SPEC_CTRL_MASK			(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD \
+							| SPEC_CTRL_RRSBA_DIS_S)
+
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			BIT(0)	   /* Indirect Branch Prediction Barrier */
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 3e3230cccaa7..970b277d02a6 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -137,8 +137,16 @@ void __init check_bugs(void)
 	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
 	 * init code as it is not enumerated and depends on the family.
 	 */
-	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
+	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
 		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+		/*
+		 * Previously running software may have some controls turned ON.
+		 * Clear them and let kernel decide which controls to use.
+		 */
+		x86_spec_ctrl_base &= ~SPEC_CTRL_MASK;
+		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+	}
+
 
 	/* Select the proper CPU mitigations before patching alternatives: */
 	spectre_v1_select_mitigation();
-- 
2.38.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
