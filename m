Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68942C433FE
	for <kexec@archiver.kernel.org>; Thu, 24 Nov 2022 10:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4c4tHIgzCBdG2zoUlHBpvLYBzAqfRa6Nwpv95zVukS0=; b=NTTecUhZJx6bRE
	fHw/RIuL8JaWt/EaQaL2njsbAh3xZpGzrqXz1vOpa3S85FpQ1rZW8B28vxuNr88xW3pCffhvZYaKu
	5+12EnxTIaeUtqJsxqBp7Yg7PB0IZa8BZVkO3GvAEy4tMQxL4uO8lKJTydunTKQsP+FxeLQ7stcvS
	EwbSeOsfqo61Q0LEpt3ULDHPRE6q/PNGzp9ma0DvbxDUTXoWecQP9DnapmQtI8MIxddPz5+BvC+ad
	6XX9sPFBkcahFaRw2kVRxrdLpz0d2GSbo874iexEAyk6NzxPfKgqrNwpXgFhodfrwHJRP+rPI1Wcq
	JjR2iBFZLcYOCzdgjJ/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oy9l6-007niA-TE; Thu, 24 Nov 2022 10:47:08 +0000
Received: from mail-ej1-f44.google.com ([209.85.218.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oy9l2-007nf9-HS
	for kexec@lists.infradead.org; Thu, 24 Nov 2022 10:47:07 +0000
Received: by mail-ej1-f44.google.com with SMTP id n20so3377916ejh.0
        for <kexec@lists.infradead.org>; Thu, 24 Nov 2022 02:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOCeRbpoEibDw8trfgXnocJq/MAqJBN4CTGMZxhpixQ=;
        b=AIgYU2ljZMV+S5H+vgFal2v+f0rxLRsbuJIUzg3ca1iDFXR0udTKoakiOh+2THoBLH
         bigh/Pqzry/pfqkjnm/uTrhS8MtokKegcnlUs/EJET2VFRJhnRupV2MdKPSp8dcwvTE0
         oj6EkeDfXLEzGGy3MpurcMkrTDgngROZW5h7Vqe0VpZ2BEJ8q7iKFQyZ1K7e6gMzelOP
         fb73zmq+NcojFGX0cWUYH9O5iqt6hJJBgePYuTjaiJwXwEU5XB7Ox5m2IpQ35sBnlOWm
         eqSfwEehUq+CbSzMNJqPYaBVH63XKe4QT1Ntijc0WhhiL18dUzhn+anII5xThRZKlVzh
         masw==
X-Gm-Message-State: ANoB5pnCVMY09ujtVsHPz7Kfe8Yo5XCKRLo8tOWKG3YXHOPWn57TUdyp
	5qUDbrIRYkyQnysgpgwr8L4=
X-Google-Smtp-Source: AA0mqf5bLmfxHjwrpYUSwp1q5H+TjWBAR+hJPToV2Q8wyT/E0SCsJfTpz0QDg31YJ4kC1m1A0dtfaQ==
X-Received: by 2002:a17:906:1b48:b0:78d:a136:732b with SMTP id p8-20020a1709061b4800b0078da136732bmr12033426ejg.135.1669286820516;
        Thu, 24 Nov 2022 02:47:00 -0800 (PST)
Received: from localhost (fwdproxy-cln-120.fbsv.net. [2a03:2880:31ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id o17-20020a17090637d100b007aece68483csm278722ejc.193.2022.11.24.02.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 02:46:59 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	pawan.kumar.gupta@linux.intel.com
Cc: x86@kernel.org,
	cascardo@canonical.com,
	leit@meta.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/bugs: Explicitly clear speculative MSR bits
Date: Thu, 24 Nov 2022 02:46:50 -0800
Message-Id: <20221124104650.533427-1-leitao@debian.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221124_024704_595952_3F0C9563 
X-CRM114-Status: GOOD (  18.03  )
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

This patch also defines a SPEC_CTRL_MASK macro, so, we can easily track
and clear if eventually some new mitigation shows up.

Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/include/asm/msr-index.h | 3 +++
 arch/x86/kernel/cpu/bugs.c       | 9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 4a2af82553e4..704f49580ee1 100644
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
index 3e3230cccaa7..88957da1029b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -137,8 +137,15 @@ void __init check_bugs(void)
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
 
 	/* Select the proper CPU mitigations before patching alternatives: */
 	spectre_v1_select_mitigation();
-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
