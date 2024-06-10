Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6426C27C55
	for <kexec@archiver.kernel.org>; Mon, 10 Jun 2024 10:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dMGYzhS17BAVe8uNvWMAaVaV+wtCeEooimrkBiPwyqo=; b=w3DLlQ4FDvP3Qq
	fQFhoYWtC7nWyfRNToENfegOdwpMm7ptLjPUsUuxv8bjUntDMErnjIhEBU0urfHc1tqyyiZtLWtVh
	gIrinDrMC+pgLLqy/uhTh6zMDyxewSVtKeZhSRqCUiIlF/9OBKw1zeM/4wWeyeCj+8idfRGLzsNfL
	6OTC0E89GKaX0XdKjowNdXB5FDS+5Sse91z7OPPjovmuZ9Zax4+8BUHLp8vjd+VZk8LU0EDz78Dou
	TaHWZ4bqdWhpTQwFLgWsxeKKS6CQUew40A7J/c1jlSj9N+E8Wn7oqizU3UlS5dJrvDETQXR9YoHd5
	bIehP+PBu4u0T1mGG6ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGc9i-00000004cM1-0Una;
	Mon, 10 Jun 2024 10:21:38 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGc9b-00000004cEg-0Edj
	for kexec@lists.infradead.org;
	Mon, 10 Jun 2024 10:21:34 +0000
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a6f09eaf420so173671266b.3
        for <kexec@lists.infradead.org>; Mon, 10 Jun 2024 03:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718014887; x=1718619687; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCL4Vo5CEvbB78AJfWlszJwJfM4IkhVBnCtECteN90M=;
        b=GLBhEqxYEak9jI14j5RqSFZ5/zg4ynTjqKPeeWq16hNlUaQ+SWE17kpG+q9bytALJA
         XHeYWS1mBd/d9eg6OAozfFytBD7zZoice8ne9oGTJYW0tAmpsys/tZO4RmW0UHvP0L/U
         UR37GExibL3h4MoDJYbdaLimHxOFN5C+J1Z/vdbH7CIrEszRV3zMNtNInMcrUi2nJBCW
         df8NaYhriKEFDug/qFTW1mfyxqxBhpbb0Om3+T/riucV8qkQ2U4+P5Bi6Tlw+SyX5ZVd
         H42mQLg84Jzximn/SvQYUApiGNlFAXUJIZhZce/tCFgEvyWLnmGM0gyqMBDj/bFoXuBQ
         Pvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718014887; x=1718619687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCL4Vo5CEvbB78AJfWlszJwJfM4IkhVBnCtECteN90M=;
        b=re709vBV9eM03LCeq9EWOZ6VefglcDV0h9C/H+fsXOsq1j7xKGhLRkCvkderALE+OI
         N9HVfvwj2iKdtZU+bsh3tJz6J3ToVJZWQOx9NlwwjKgRX2Cs/v7z2X13i2+uj+K0IQQ+
         9vktb3eBT6Wjz5ES1TaxvA6M6JpTmWxTehebyAaSC+JvwRdn4SSfIuvbrSetZt34cRMT
         PbL91YAICIf6hU5VV1T2Q5JxWIq65MN+FpOTiVZ8YrVeOnbmvnh8Rf/8XdP2KO/D+LNR
         j+yKP9aWZOI2F3gF/n964n5/i3y/d9wrG7hMsninYNgM5YiN+4jWww24HbQ8sBEeJ7UQ
         vsuw==
X-Forwarded-Encrypted: i=1; AJvYcCVwktEEI9mVbhbofXTfXr/aVacrr2jQ6XzyWOOYfZiITAwa28JVrSWPHa+CJ3Bv0wgBW9OOCs4uFhOKh0cmjoRW9i1tTmNJEB5p
X-Gm-Message-State: AOJu0YxPp5jnxGxoFsVjsUbIxk708vXHPx9FI2yglJ2dxt6ZeYSfntEs
	yOALRuLYt6jl89os7XyJuLgAn0s4zYsXtNAZXj0O6J0q/n0iJQdU
X-Google-Smtp-Source: AGHT+IEU4Gid3qf0r8Bb4VtO+jH0s35ne9U0e+dRyHVRPwaSrjMvMMb+EUFXtRe7Fz4xmoBBOgq/kQ==
X-Received: by 2002:a17:906:150c:b0:a6f:eb8:801a with SMTP id a640c23a62f3a-a6f0eb884afmr308071366b.56.1718014887288;
        Mon, 10 Jun 2024 03:21:27 -0700 (PDT)
Received: from vasant-suse.fritz.box ([2001:9e8:ab68:af00:6f43:17ee:43bd:e0a9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0d7b35d5sm290887766b.192.2024.06.10.03.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:21:26 -0700 (PDT)
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
Subject: [PATCH v6 02/10] x86/sev: Save and print negotiated GHCB protocol version
Date: Mon, 10 Jun 2024 12:21:05 +0200
Message-Id: <20240610102113.20969-3-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610102113.20969-1-vsntk18@gmail.com>
References: <20240610102113.20969-1-vsntk18@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_032131_878879_8DD9641B 
X-CRM114-Status: GOOD (  17.91  )
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

Save the results of the GHCB protocol negotiation into a data structure
and print information about versions supported and used to the kernel
log.

This is useful for debugging kexec issues in SEV-ES guests down the
road to quickly spot whether kexec is supported on the given host.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
 arch/x86/kernel/sev-shared.c | 33 +++++++++++++++++++++++++++++++--
 arch/x86/kernel/sev.c        |  8 ++++++++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index b4f8fa0f722c..f5717eddf75b 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -23,6 +23,23 @@
 #define sev_printk_rtl(fmt, ...)
 #endif
 
+/*
+ * struct ghcb_info - Used to return GHCB protocol
+ *				   negotiation details.
+ *
+ * @hv_proto_min:	Minimum GHCB protocol version supported by Hypervisor
+ * @hv_proto_max:	Maximum GHCB protocol version supported by Hypervisor
+ * @vm_proto:		Protocol version the VM (this kernel) will use
+ */
+struct ghcb_info {
+	unsigned int hv_proto_min;
+	unsigned int hv_proto_max;
+	unsigned int vm_proto;
+};
+
+/* Negotiated GHCB protocol version */
+static struct ghcb_info ghcb_info __ro_after_init;
+
 /* I/O parameters for CPUID-related helpers */
 struct cpuid_leaf {
 	u32 fn;
@@ -159,12 +176,24 @@ static bool sev_es_negotiate_protocol(void)
 	if (GHCB_MSR_INFO(val) != GHCB_MSR_SEV_INFO_RESP)
 		return false;
 
-	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTOCOL_MIN ||
-	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTOCOL_MAX)
+	/* Sanity check untrusted input */
+	if (GHCB_MSR_PROTO_MIN(val) > GHCB_MSR_PROTO_MAX(val))
 		return false;
 
+	/* Use maximum supported protocol version */
 	ghcb_version = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
 
+	/*
+	 * Hypervisor does not support any protocol version required for this
+	 * kernel.
+	 */
+	if (ghcb_version < GHCB_MSR_PROTO_MIN(val))
+		return false;
+
+	ghcb_info.hv_proto_min = GHCB_MSR_PROTO_MIN(val);
+	ghcb_info.hv_proto_max = GHCB_MSR_PROTO_MAX(val);
+	ghcb_info.vm_proto     = ghcb_version;
+
 	return true;
 }
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 3342ed58e168..f0d87549b1e1 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1399,6 +1399,14 @@ void __init sev_es_init_vc_handling(void)
 
 	/* Secondary CPUs use the runtime #VC handler */
 	initial_vc_handler = (unsigned long)kernel_exc_vmm_communication;
+
+	/*
+	 * Print information about supported and negotiated GHCB protocol
+	 * versions.
+	 */
+	pr_info("Hypervisor GHCB protocol version support: min=%u max=%u\n",
+		ghcb_info.hv_proto_min, ghcb_info.hv_proto_max);
+	pr_info("Using GHCB protocol version %u\n", ghcb_info.vm_proto);
 }
 
 static void __init vc_early_forward_exception(struct es_em_ctxt *ctxt)
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
