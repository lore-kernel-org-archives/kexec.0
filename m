Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA60C433FE
	for <kexec@archiver.kernel.org>; Mon, 28 Nov 2022 15:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/a3dC+rYT9lqdDG1evRuU4zdomosPw6bwQRJ0eT56ug=; b=E4YYkdLwGN68+p
	MX2LoA8ib7ZEF+0S0GEz0loubSCrQkaEVJGmeXL2ZF9BgZTRnV32eWB4D9Q6bgm2+Mz+nNOgmwiMZ
	cB0Uea/2CxH9/JEk9Xq1LkGFpPvQJhc5QngNmW8LmflXDl2k6jM7HLlA/Kl9IhXMkDfa9fzvYRAMb
	3tepIZcU0oBv/SBN46vnJx6wxwfNcW0SuaIfZHwap+rWVNVZKsLdVblY5Ql0YXBtLaiy7rCnPAHiX
	6gNyzf9s6wd9A/7Oylr0LjOuDH6R2d9cQnjQ2fLPC92BSs5lnm2JUOm0/I4bNVM8eDYat01hqbF9I
	K9INfBM+ChgtYc4HXtFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozg75-002Vz3-JY; Mon, 28 Nov 2022 15:32:07 +0000
Received: from mail-ed1-f48.google.com ([209.85.208.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozg71-002Vvb-BS
	for kexec@lists.infradead.org; Mon, 28 Nov 2022 15:32:05 +0000
Received: by mail-ed1-f48.google.com with SMTP id s5so15882434edc.12
        for <kexec@lists.infradead.org>; Mon, 28 Nov 2022 07:31:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOSg/B4UTmp4btrP74NZ2/GqvQw24Sg6iyetxuaSaXI=;
        b=yjiQMzEiEFm46K3C/CT+ZVqCaiBQQwms50yXfZLqlo6lq69lB8Yp1y0VbmrR1HA0Vh
         SwGh8jZGdizPs2uVFouQJaoEHTtWApPBwKW8FXMWIRWZyQV1uD8gKMIq+NLo08onBSy8
         5jnWucgQC1U9XJD/+MI4mEZJWWs/a201vWGuiN53+VPyqHu6fRSdqyXPoPyH2sAxsgdV
         prIsQNL6Ah95KquTMRGflz3mwnm8BB0ut46cuUG9JIyqiDRT4ZUEHFBZNi8WNA+tkfgM
         O7wx0Djhpxp5CAv0uygVqby6lP85KPkpI8gQg0UJRyHHNknu5Z3T9S1Wzp6Q9KsbhwxN
         CYjw==
X-Gm-Message-State: ANoB5pnYKOPGMfj/XhwySheJMpX7Uy58GmhfUdlb6kRjJJ8qm9XQPcBV
	j254JWe9D9l+kfdR9aZNK2o=
X-Google-Smtp-Source: AA0mqf41mPmyAcB6kVIXc9HRpogBe3v8wlDWWI+1QVvhDCgq2IB1HitMlL1Xfd+FXtv/hHKgAIyskA==
X-Received: by 2002:a05:6402:5406:b0:467:4b3d:f2ed with SMTP id ev6-20020a056402540600b004674b3df2edmr30871045edb.101.1669649518027;
        Mon, 28 Nov 2022 07:31:58 -0800 (PST)
Received: from localhost (fwdproxy-cln-120.fbsv.net. [2a03:2880:31ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id g9-20020a170906538900b0073de0506745sm4429682ejo.197.2022.11.28.07.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 07:31:57 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	jpoimboe@kernel.org,
	peterz@infradead.org
Cc: x86@kernel.org,
	cascardo@canonical.com,
	leit@meta.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH v3] x86/bugs: Explicitly clear speculative MSR bits
Date: Mon, 28 Nov 2022 07:31:48 -0800
Message-Id: <20221128153148.1129350-1-leitao@debian.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221128_073203_416702_743E946B 
X-CRM114-Status: GOOD (  17.45  )
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
the mitigations are disabled.

This is a problem when kexec-ing a kernel that has the mitigation
disabled, from a kernel that has the mitigation enabled. In this case,
the MSR bits are carried forward and not cleared at the boot of the new
kernel. This might have some performance degradation that is hard to
find.

This problem does not happen if the machine is (hard) rebooted, because
the bit will be cleared by default.

Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/include/asm/msr-index.h |  4 ++++
 arch/x86/kernel/cpu/bugs.c       | 10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 4a2af82553e4..22986a8f18bc 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -54,6 +54,10 @@
 #define SPEC_CTRL_RRSBA_DIS_S_SHIFT	6	   /* Disable RRSBA behavior */
 #define SPEC_CTRL_RRSBA_DIS_S		BIT(SPEC_CTRL_RRSBA_DIS_S_SHIFT)
 
+/* A mask for bits which the kernel toggles when controlling mitigations */
+#define SPEC_CTRL_MITIGATIONS_MASK	(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD \
+							| SPEC_CTRL_RRSBA_DIS_S)
+
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			BIT(0)	   /* Indirect Branch Prediction Barrier */
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 3e3230cccaa7..4030358216c8 100644
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
+		 * Previously running software, like kexec for example, may
+		 * have some controls turned ON.
+		 * Clear them and let the mitigations setup below set them
+		 * based on configuration.
+		 */
+		x86_spec_ctrl_base &= ~SPEC_CTRL_MITIGATIONS_MASK;
+	}
 
 	/* Select the proper CPU mitigations before patching alternatives: */
 	spectre_v1_select_mitigation();
-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
