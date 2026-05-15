Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72B7CD4851
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ER4IWQsMKw/HNZSo0sHiz6UgahZlpRSMvCUCrr/URAk=; b=mjJYLaWtmUO7ZcS3kBXQmW1J87
	x2sdhN6E9SAPEXX/SuMYuA48eHwFXR6/XMlcAiFO89cCSfBjLPmxhbuWMyLBW1fpmNF8R/DGUQspf
	iEPwOeUv66cIMtYQcbgtmJ+iXuCGiuHjBPdaI+RITg7ravrShN/bxPxWfVmRGUFK7TTsVsYzdl0CO
	MSA+3lP5Q8S8PbxNqbHLxYHXHuBqBCpZJ78lC5f331F5+W/zq1hjIuERoH9164v8KTTbhHlKwPUcQ
	f5r3MnW2y5JMrrRDh5FLW3sfmUNjvUz8G/DDo1caf6ZV7vM4PiQ1pz0f5wYi94yKDc23nhzH7FGbJ
	X2Rg7hrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzsV-00000009TwR-2YKd;
	Fri, 15 May 2026 21:15:27 +0000
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzsS-00000009Trl-211R
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:15:26 +0000
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-2f3c623322bso1045188eec.0
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879723; x=1779484523; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ER4IWQsMKw/HNZSo0sHiz6UgahZlpRSMvCUCrr/URAk=;
        b=fSyd2y/b3u6iHrCvkuFVPK8ViSNmW9BZM/c5VE3IknUI87hjkXW1MuTdGz4n4yA5r3
         bJdH8suWL3L3chGzEZpHODBGHSTQc2gbLN47qeN/Wo8HMNOXv6zpJHf5WfoHo2X1ywL7
         WlNH3Q5SkkhXt+teY1RheZF+dFwQRWrrGpBBRF/sO05huOLkUZWJy3Onf0C8r42YHhey
         +V6Yu944p09vulmCsf0Xcav6fiKpzDZIBsjPUJ/NMuTbYs6Aelnvbx3wxChPeLEXWiSF
         S+ycujGDraJvDATMJBTWJQgFRN9KQyUhDGC0Ahbr8Y87m4tLxR7HXVP11pFqa7P2h84m
         tGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879723; x=1779484523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ER4IWQsMKw/HNZSo0sHiz6UgahZlpRSMvCUCrr/URAk=;
        b=FWcRqnlF2BQKqL/Td926b28i1WXwV2MZtaB7Lhirzo3sogteYc5p9bj954E6MkMJjK
         4r61T5WZk2YdkuTNdA0PPJj4H/pkQ+i3mqCWms+DoPRIizl5xIQ5DS74fcunEPDNiUJG
         YBJUANJiqYLwKJwpY/Tl4xphFU0tSrQyNajE9fUIpsX84rwcyS81FGPkxyU1hhZIJy2j
         /Rx47xdO28wjtItjb50Nse8TQCRflulrs7Z2iqJN7BXsTuDDssWDtC0Av9PLUzUBFVg/
         37tp4nkljbnXvG2LCgVb7z7LZSNLMHs/blPNllzE0AK1362PA25ar0YBcRFLRGep0KSY
         +k3w==
X-Forwarded-Encrypted: i=1; AFNElJ9uLIRCL4+nExP9uirOlFFVcc57mrMsdxt7O87h5hijgzPoMWRJahfkXXQbRuqmEmf2OzKYhQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxeEkLdYOj7L5VBsRsxhUuvY1ziB3FDeywMURXPImaEO0Uq39g9
	9c9yytLVOd+ahuHzu2XO/Z2VS8ABnqq9t3E9AF/YbbgY+iZN1Zi/U6W7
X-Gm-Gg: Acq92OHVeIXCv8oKOJm6c0TDHT0y/ZhkOS+9q2aEYP8By3g2mRFEJuT2uXHr2g9Lgwa
	tppPf7EdCApv8VMf2Y16OkXyvZg42RZ6p/CKkCJuPJCxxl8qJtwqc1EEQKlFh59qGbFl1vYUljh
	k5eBBI5LJa+SxHk+cCHHcd37WcQasmLwitbqQRJlTtzsDaW3N73OYrxeaR6doC8k6qYJn/ij07A
	biSYNPL37hFZyaUHCOxj5pWfPE7SUnJB4Rve+3Rrf98xipMp7r52OsDuuqr6rtm6DqeVKWdXBnW
	Z/6P/BG812Gn0qhfBurKJJ4A1o5/zccc24GGMLqlTrO8NBt0yWfr3gQMHSt7pA+i8CvGDSQb0/x
	UcICNjEKo4bI3eZRvnFkrqEjGqezBVu0kI6ZbvJ35RdVV+dQB0p1bgeuEkfZt8+S5ucv+h7zj0a
	UTSsvcNh3hJAdjNknicn/cMlDYHs9FJQp8wr/fafxNaw==
X-Received: by 2002:a05:7301:4184:b0:2f4:3a9c:818c with SMTP id 5a478bee46e88-303986b1521mr2959973eec.29.1778879723496;
        Fri, 15 May 2026 14:15:23 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ef5sm10736508c88.2.2026.05.15.14.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:23 -0700 (PDT)
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
Subject: [PATCH v16 25/38] x86/boot: Slight refactor of the 5 level paging logic
Date: Fri, 15 May 2026 14:13:57 -0700
Message-ID: <20260515211410.31440-26-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141524_534368_62A786CE 
X-CRM114-Status: GOOD (  13.22  )
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

From: Ard Biesheuvel <ardb@kernel.org>

In preparation for adding Secure Launch support, which will require that
the number of paging levels remains untouched, tweak the logic slightly
so that the slaunch check can be inserted easily.

No functional change intended.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/boot/compressed/pgtable_64.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 0e89e197e112..3e9d651da73e 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -102,6 +102,7 @@ static unsigned long find_trampoline_placement(void)
 
 asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 {
+	bool l5_enabled = native_read_cr4() & X86_CR4_LA57;
 	void (*toggle_la57)(void *cr3);
 	bool l5_required = false;
 
@@ -118,10 +119,12 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 	 *     + CPUID leaf 7 is supported
 	 *     + the leaf has the feature bit set
 	 */
-	if (!cmdline_find_option_bool("no5lvl") &&
-	    native_cpuid_eax(0) >= 7 && (native_cpuid_ecx(7) & BIT(16))) {
-		l5_required = true;
+	if (native_cpuid_eax(0) < 7 || !(native_cpuid_ecx(7) & BIT(16)))
+		return;
+
+	l5_required = !cmdline_find_option_bool("no5lvl");
 
+	if (l5_required) {
 		/* Initialize variables for 5-level paging */
 		__pgtable_l5_enabled = 1;
 		pgdir_shift = 48;
@@ -132,7 +135,7 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 	 * The trampoline will not be used if the paging mode is already set to
 	 * the desired one.
 	 */
-	if (l5_required == !!(native_read_cr4() & X86_CR4_LA57))
+	if (l5_required == l5_enabled)
 		return;
 
 	trampoline_32bit = (unsigned long *)find_trampoline_placement();
-- 
2.47.3


