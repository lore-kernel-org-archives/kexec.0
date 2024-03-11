Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F22C5475B
	for <kexec@archiver.kernel.org>; Mon, 11 Mar 2024 16:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NUnIgDv0UVBdKX5Qc89qqJ+7XWG9moEGmTTkiIcPY0M=; b=MIzU1n1LXoojph
	N88ytViZcH9fMKma+ueO0VtT36YRLLmSOknzOjtEf/l00uv0mOJOjv5XNw87iQLjxFCmU+JWkUU46
	6MCch7dG61URd8vmZFp8x24UPRpTr6gk8wA6EVpR+59ZDG88+sW3d9ZfP4/3wVJeuB4bqc++NW5Jo
	jYvScqJr+BwMO5ig4oHeiRStLnayF19ZaGfJgK0M/jzjsymDTSlP/29Aw39/o0CguLau82HnaeVHH
	o/1Zo6WPQp1hwYKASAL5DbC7VCazl/MHMWvN12X5/CbZ0TxoWkCx6aBzxcfVoQKnS0jGvhf67rYCc
	r2fxdsCMj3d7W652ZQuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjiLX-00000002GlO-1uQ6;
	Mon, 11 Mar 2024 16:17:51 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjiLJ-00000002GZ6-2RvJ
	for kexec@lists.infradead.org;
	Mon, 11 Mar 2024 16:17:42 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4132a348546so6544355e9.1
        for <kexec@lists.infradead.org>; Mon, 11 Mar 2024 09:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173855; x=1710778655; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Nx+lR8M3d9xAl/7OW4v6MUggA0QirKWOFkex7liC38=;
        b=RmE2MvUEu6nLJkF4c25r6pzniCqrVYLjJCehMFVyBOTaHEGDJj4WwtaKJkAoDbPEHB
         G1uIvcFaF5XODzUfNP4hB8BJdj4dfsGU7QuLS4Jx9QbbhjZW8slxFxrfTxAteOJQEuuE
         dHVRuZ/s1hPG5A+7rOwlZ3oI8h1lMRMgNw6+5b/i4C4PboWtR5H3WIT2mgQxe/UrRpSf
         hvtx5CZZbs/P9/nqmKe8X7QQrc0/N4k6QWjG9NosmQVADn+3QvTOXzknQ+s0lmRhreMB
         wa0eI+vXcy3vpPZcOqteQcIroLL1iduwffyKkTpur3a9LJuZeWw/6L9vGHYRNzbg+5nk
         6G+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173855; x=1710778655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Nx+lR8M3d9xAl/7OW4v6MUggA0QirKWOFkex7liC38=;
        b=fmryytq21byNB2G5RD8h8AOEtjES5m7BA85Lr/WzQq6vWe+cS37Me1FeJmCfOTXvFm
         eq98n6Rq/o8m92/ll/F2MdIn37di43d6TpTxKw+4t0Dqsh7jL4z3FsaEJjuYAFYNMfbl
         dFNYGXC5QVJ34pjZgLanuKFkzOBkTND+A+ZgABP+1yj+/wJw4uKMUNy2dGU2enYjBK5B
         5/a0bv8mxZi4BgPZYoZDPpTVbaoIg1Nsh6eOGFlcWvOFm0x3JM4mtXRIXa39bVq0Bw8O
         pJ5EM3RWoqkxWhbxXdo+meKz58lYABooXe8T54W9JIXHKhOshXyQpq62CY3YCYf7tmV2
         bFiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjqYEzA4+xTRMetCjm+NIcIz5O23q3COlPR2ySXZDxos/DZo5BCtZZLiAt+tsYb7p/hXi4Ni3PTwtOL48rMEro0X7WUimXf+hs
X-Gm-Message-State: AOJu0Yyr8gmN4nx8GHyTrW8s/twWcK94tGbtsDHOpgH0wMgaFwzQvckt
	vIsvOnyt0aJjgnVEM7KTYgqCRRcb5Zu84S4WSMggMUN7FxceYyWF
X-Google-Smtp-Source: AGHT+IGUkQIfxvl6yLuTpdvx8nBMGwNueb7cOPWvFZGWKEwfp7qH2FFkNgyfYv3Q3y0mmeMCQSJfrA==
X-Received: by 2002:a05:600c:458c:b0:413:2c3e:c323 with SMTP id r12-20020a05600c458c00b004132c3ec323mr1492631wmo.38.1710173855159;
        Mon, 11 Mar 2024 09:17:35 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab47:8200:c3b9:43af:f8e1:76f9])
        by smtp.gmail.com with ESMTPSA id ba14-20020a0560001c0e00b0033e96fe9479sm2823815wrb.89.2024.03.11.09.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:17:34 -0700 (PDT)
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
Subject: [PATCH v4 2/9] x86/sev: Save and print negotiated GHCB protocol version
Date: Mon, 11 Mar 2024 17:17:20 +0100
Message-Id: <20240311161727.14916-3-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311161727.14916-1-vsntk18@gmail.com>
References: <20240311161727.14916-1-vsntk18@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240311_091737_805248_FB623048 
X-CRM114-Status: GOOD (  17.55  )
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
index 1d24ec679915..c02a087c7945 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -17,6 +17,23 @@
 #define WARN(condition, format...) (!!(condition))
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
@@ -152,12 +169,24 @@ static bool sev_es_negotiate_protocol(void)
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
index c67285824e82..179ab6eab0be 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1392,6 +1392,14 @@ void __init sev_es_init_vc_handling(void)

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
