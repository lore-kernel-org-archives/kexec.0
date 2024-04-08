Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4839CD1292
	for <kexec@archiver.kernel.org>; Mon,  8 Apr 2024 08:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pp2TfFcw5QdBs+tXDhaZ22uWTpMvoTPzWzufPKUj+E0=; b=YhdkdIIFryqZIF
	w1ZeuKXYtYzgn2ZBWr2ELL4mNk5YuNl9fwM+16ZA/q/fS3LmzpnOFAJOmPtYlO3iHLmHAdCBzuvxo
	XBHeY3C9QgBfBwumCl1Pm6SfyyX6IGdio84NJ0DaDZF8rG1XT/177tk8lNww1bxG8Zh8XEIHGiAM/
	DilmEfAqlP8aenHGy0NNrfBb8NpdxxBeA5qTzj5rcfsbseIQ1tplg8It+3ZnycFvKjir1i6Z1X6yV
	9py4z2n6E6gY0wbOxjhZsrGq5JDQ5b0sxEICde/rn3WAjIs6t70cs7afPIRu7aMzZgjfkh+N1BLfe
	1P8XkgpYVIm6Qb8yLn7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtkdL-0000000Ex3j-2KlJ;
	Mon, 08 Apr 2024 08:45:43 +0000
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjcp-0000000EhSo-3NfB
	for kexec@lists.infradead.org;
	Mon, 08 Apr 2024 07:41:11 +0000
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-516d3776334so3746161e87.1
        for <kexec@lists.infradead.org>; Mon, 08 Apr 2024 00:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712562065; x=1713166865; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqnE+JA2AKP6TMVqtzdhtB8i3JdyW6VDhV209Iwbv/8=;
        b=g5pG/N3a+CK3dHA/w+ULh1rUIdJutFeN60u6rNHgxUeLFMxGRYH9GjZeDHeO4014LQ
         0OBcdF0a1B4QUVgRqRZD7hiHSRDqkyB9CzNmnNtSBoFH8aY8mmw6JAUIJ74eqLUrn0Ni
         mH3JxsOYQb9SnhpqCx0fpRKCcW/mqhodkwN8LRfimnkh6MwsLV8WHSQcEitWFHUUmqTR
         thIwsP7zZRRpUBuNyoAiqMRPmNTROPtFTppMdrWeZVH9D9mLX7LOFxAPgyI7eYEdbJXr
         XcFMsbQyNP9t7Tv+WHnbhRQ0taEXeUr/V9h/zDnllbzBn5YcaTyPHl9xBhzUibpM1AnH
         F2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562065; x=1713166865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqnE+JA2AKP6TMVqtzdhtB8i3JdyW6VDhV209Iwbv/8=;
        b=ph9boy2oGwVzarI8PTKzFTBl6tHx/zP4hvs9FMeR0eT+xi0/3N32H7Z4jC33LYm/QW
         E8W2nenwwagCng7HCp5N9xf9PtKUK0kervDOhZ5Rc4aURhP/0G/w8r6QMkv+8Oozy/IX
         KrH0MaXYAB0bVYeCqdH5BMJhYV2cdIgFsYBSnnl3oSblVDGvNBXIvte0JsXbrNHkLfLV
         40vBDioSvTr7DNJ0yw/lrZWRinFEOeY0eS6Y6kDPQLXcWi0qIpvVZeFCDNHaro7YEk2E
         /EoMh2cm6HHvqImstpROCDaELGW/ZuAkRzoDGO5b867l6tTwNt0bQE2699Khn0ilh0nO
         OJcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRqh1SgVfyrzz+b2iXDNG077mU4QocormrtAycIhk0RQE1O7KcHuKCBozePaHaCgTp0Ze6LI/hxrKCd7+Wwt/OqFwKW638XSKo
X-Gm-Message-State: AOJu0Yyo7aD5e0vkSv49xAKlnCRytqbBDphikSB6CjEnII4wTYgktPYi
	zKB8LnYuGNwf8aBfy+qe4sf1a8Mnfd1ZFA6B8HnU7vq6Kw8YzEC+
X-Google-Smtp-Source: AGHT+IH2pJfyzX54b/TYrms4jG+/yAMqvvcGc6GwZPjgH3mJKkcZm/KCxWXEZlTYThTHzthqKdB71Q==
X-Received: by 2002:ac2:4db2:0:b0:515:d31f:ce2b with SMTP id h18-20020ac24db2000000b00515d31fce2bmr5757819lfe.15.1712562065111;
        Mon, 08 Apr 2024 00:41:05 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab70:9c00:7f0b:c18e:56a6:4f2])
        by smtp.gmail.com with ESMTPSA id j3-20020adfff83000000b00341e2146b53sm8271413wrr.106.2024.04.08.00.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:41:04 -0700 (PDT)
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
Subject: [PATCH v5 02/10] x86/sev: Save and print negotiated GHCB protocol version
Date: Mon,  8 Apr 2024 09:40:41 +0200
Message-Id: <20240408074049.7049-3-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408074049.7049-1-vsntk18@gmail.com>
References: <20240408074049.7049-1-vsntk18@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_004108_371148_EFAF3414 
X-CRM114-Status: GOOD (  18.04  )
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
index 8b04958da5e7..ba51005ddde2 100644
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
index 7e1e63cc48e6..098f590f7bec 100644
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
