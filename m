Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB61FCD4851
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bjgxy9jrMUn+tA5MZsUkk9qLfIPrTHgv6m9jj+0YWR4=; b=goFqKcjox16kMTPJFJbnh/epx1
	qLfx+vguzsBeb1jk6vruDzmrzV3/UyCI5T365lsCJlWGlpSR50mfRmgYxOXV+VkdXi4xjCzhHcwdT
	UvOKYrJLHUD6eJB9b9jnza6PD/61INJYFdMYSMcFh40ePxokMqh0BzQG8HjGiia5IWclC1th14QRn
	yo2ODhNql0bMZt9mqp6U04RSLGFeFHY0Qbs5nXx2sIUSglFKMUzr2ib/60QyNk2vroUlyTfxJ9jZ5
	YYhetxBPCpxne0YkoayisuQUu8kuWfak/niUBipWIqgtp08hkw/MucQaM+rqCUfrYNaCYqdN3/6BO
	+ZdU66Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzsS-00000009TsA-224Q;
	Fri, 15 May 2026 21:15:24 +0000
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzsP-00000009Tpt-19nk
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:15:22 +0000
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-2f00a567cfaso833250eec.0
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879721; x=1779484521; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjgxy9jrMUn+tA5MZsUkk9qLfIPrTHgv6m9jj+0YWR4=;
        b=EkbGc5XLVmCVxSawXLn8eC71lpm9NDbRXbiU7EbSuIkN3+d96lav20GSN7ELE8WmMR
         7deJkL/u7qkqEGUV5bkNJFCHVbZEIKF1zuggt6BsKbLD3HV4osCIlmWmwd1HoNQdgNEu
         gjKDob35Y0Z7Pc1xPU2ScN5C/ikt5CXVqzv2N0BF0QZQx+Wu8VCz5gGYs9Z/niCTn10N
         4bypGrpZSOMMAoNvG2nhFrBZiwlYbnI7Qi6bOaAKCPr969kZHXDgs5xKg6NUVsaOWJWR
         OfEtnDoQ+lIv9X0/dEX/pUreb7QEmAFsKQDKZyYH4JvJ271L8Ju84RKtVDSm7m1aJfj2
         RoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879721; x=1779484521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bjgxy9jrMUn+tA5MZsUkk9qLfIPrTHgv6m9jj+0YWR4=;
        b=arcSLIX49PvJXZMFdtEgh2FqulK4sEu2VZl1ZCESLF1HyoVb+777gcTcjUP7dEtTOr
         Sx9rayzECMjJ7JiO5HrCRU4UlG884CAxcppFwSLwRUPZsOKzAscPTn+V/Of0LFBQjR8p
         fOSr7VJ8IF7onwAWdh5S2lNpj+6G5sm3Je8FtSHe/+i9RNohi5LT0HtcumLCtxi5XyEW
         p6GCVA3+RSNd82m4PUt2eDLhmVtJeA5vZ6I2zZQqj+QuyMcZKOIatpNRHf3kimjQPZWv
         i3DEqsjxYfifcmB5IYyUurqA7//c/CiFfVIjG9EahIqO84SjOC4+x6Ftus8b3b19QP1X
         yb/w==
X-Forwarded-Encrypted: i=1; AFNElJ+Dvy5gVcJgXp2TRkHqIAK7zIIXVFj4m4rKHF9bZRdxOoCv49W7VIaPYFYRJE2cDKO+Sj/bkw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyq1RNgT2ca0FL3OODdfbff45FZwtxX1DmfGziu3gne3tlRFDvd
	JK7c82wQKDOD3icCNrBLpxdraVW3x/cYS/aGNBqxLQ1YXdAky48Od/k7
X-Gm-Gg: Acq92OEGiIrm5XLz7AGOqPMF8W7+ZQHw3CAEcv9QIfHMD9YXw0wTc10YOAq51cuILbw
	0HsYwg/NtLkXiQHIBDD6r9yYt1nsFbZKRvuLi9MB5s9Vwd9MtifV/L9MrYoPTRxlI7zBxgWOOUB
	qqXlnBe4ZezXQoumnPtaJ+tJC4JuR5lIWoCiYcdUooTBzYDjFGNkf9J3Bul3oK3TROY4v6nDTle
	rO8qBWWFWQ87ukNT92tQiYFynGrwO+7jp/j5t5Xw4P3zRZJ5Sj/Z/IdddhUTMl0VgwzI0y1dk8+
	l4mlfHtwOsL4+W0XkDbp1AeIP+mHR1oiRcC9N/cHqEBoKwaha3NvZFNOBuLRppildSZmI8B80xE
	v5kzkOZPyUFbbFVv78VCSlYrXizIjJBxJWHSDbIdzys11DzUuSM7VZ4j/0rdD1s8vcZWob+XS5A
	cD/n53rfUiH3wGSn3MqFs5f/Aejy8r7IA=
X-Received: by 2002:a05:7300:2316:b0:2f3:5d44:eeba with SMTP id 5a478bee46e88-3025fa54325mr4525827eec.6.1778879720563;
        Fri, 15 May 2026 14:15:20 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e3c0sm9975127eec.3.2026.05.15.14.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:20 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 24/38] x86/msr: Add variable MTRR base/mask and x2apic ID registers
Date: Fri, 15 May 2026 14:13:56 -0700
Message-ID: <20260515211410.31440-25-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141521_318935_09D7975E 
X-CRM114-Status: UNSURE (   7.01  )
X-CRM114-Notice: Please train this message.
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

Add the MSR values required by Secure Launch to locate particular CPU cores
during application processor (AP) startup, and restore the MTRR state after
an Intel TXT launch.

Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/include/asm/msr-index.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 6673601246b3..2a95e3389622 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -408,6 +408,9 @@
 #define MSR_IA32_RTIT_OUTPUT_BASE	0x00000560
 #define MSR_IA32_RTIT_OUTPUT_MASK	0x00000561
 
+#define MSR_MTRRphysBase0		0x00000200
+#define MSR_MTRRphysMask0		0x00000201
+
 #define MSR_MTRRfix64K_00000		0x00000250
 #define MSR_MTRRfix16K_80000		0x00000258
 #define MSR_MTRRfix16K_A0000		0x00000259
@@ -960,6 +963,8 @@
 #define MSR_IA32_APICBASE_ENABLE	(1<<11)
 #define MSR_IA32_APICBASE_BASE		(0xfffff<<12)
 
+#define MSR_IA32_X2APIC_APICID		0x00000802
+
 #define MSR_IA32_UCODE_WRITE		0x00000079
 
 #define MSR_IA32_MCU_ENUMERATION	0x0000007b
-- 
2.47.3


