Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64161C27C55
	for <kexec@archiver.kernel.org>; Mon, 10 Jun 2024 10:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gn5DqhIE4xR5QBkxRRhpcOXObvREqd5D7yYTFup13CA=; b=wteQONHZGJnZQp
	zqEoR9p58xAxB679hhcBaN7w471mb8ESEyvp+DofYBRYzI27sAJAqSV6PckXf+1n3rmS4hmSDLh62
	4FuFRF/iHXol0CRLiV94CFGnrdU4/wset5IvthKlG9Nsr7+IUiIJ6eju6N/yxTnYtQUQgqBngjsfB
	UopLkl+Cd7LoXOs+Lc0BbAgC76Cs4HTOCqynK4NMTMxCZ09LuQy6urM9RP620juKWwzIK9v12qVsg
	c9E/diYd1c199Nw4xBElLBjoABrSoXd3k8DomE2UQDMrbdsZKno+gicj1ZqsvU6v0dg7cA5BgQ6CM
	OMkFousrrVfPejjZ6GMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGcA2-00000004ccL-0NiA;
	Mon, 10 Jun 2024 10:21:58 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGc9q-00000004cRy-0ciY
	for kexec@lists.infradead.org;
	Mon, 10 Jun 2024 10:21:49 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a63359aaacaso646533166b.1
        for <kexec@lists.infradead.org>; Mon, 10 Jun 2024 03:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718014904; x=1718619704; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdG6ACuG1uJUkfwp3EsaLBLMvj3TgqNuoQIAGjhnFXs=;
        b=Cp5ZTz0V1J0otRXx/jYjNrk/ZNDgwkayZjnpHnfpn4fuF1x7hgqfPu0vapbnZe1+GV
         oHORWKI0WdqxOdhI6KrvtMz8JuSJtLlKAcJBAFWg9UQWfi6fqNAvKL2JYOZIteEwKZ+y
         dHcQzcIsxsM7glkVPQQy9QZRz83iPT2S8D1XkKTo/9kQ4lIIlTVUFnLCLUniwTSVWbpU
         UChgGBjhaEJN6ixRTmp9fJZXW6rR5PXyKGgNYT7vHgC15FS8w6SYcv6LffyjM5BDvnJW
         hWTY2l2/oFSh1KodM1HWlkjuvIrlNp+gRAqijmSSrU1spfU2vlSkWu7MwgNYmRV6vnuj
         fOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718014904; x=1718619704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdG6ACuG1uJUkfwp3EsaLBLMvj3TgqNuoQIAGjhnFXs=;
        b=Q6O1lNYvqKIoe/Y7z6ai/T+Wt2Sqy4/vjK9B+rX8S7K59AGdfpbN1aGI115MyuOjX6
         FSEaYjToFxFKMcq6SdCDepr2rkuRAL7hO0E/SBK8o44cZEYnj1SjC/yMgtGxeaJY7xvA
         VZFXdZDpuIVNgOj8nPnzoDqFrY5NTJe2rzupiPzlr6pOay5gsakaeOFvf2TIzinZPX73
         EZnPDp2tVZx+E/UumTRV2kN9UUF/D7umQB9we9CA8tL/5MpD4DCum4Dji/xM1gpkn2SP
         i8E1MXmu3B4OPXjpsSfSF1IYcKnMX6rJLaDk3123B/itIMH6HI6ZbKDEABoOe9drHPHK
         5OsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXqOrc7JxNoDOdCCyHmbWv14eHWcyZ2247N6PincHfvnp+ASFrs+YS78Uf8qgx8/7vZ+tmcSAplQDReJRKHqFrn6YQ4Yc1LlxB
X-Gm-Message-State: AOJu0YyB3KBiT435aD5fQVt8eJc8lroqprI65giRKkoGDTdA4RW5ePUm
	s6U3tANTie+5Bu8/OWHXM8mJNn+FpXrdjBDx1UA03VWQ8PHzqWeB
X-Google-Smtp-Source: AGHT+IG+5xSdjmTwqQbKCwcV+YEwd87sFYBvU+bVS0NNITGRecW7wGay6Ao5a2CebEX1GwPUmPMrcw==
X-Received: by 2002:a17:907:9486:b0:a6f:1798:bf80 with SMTP id a640c23a62f3a-a6f1798bfabmr270645066b.52.1718014904098;
        Mon, 10 Jun 2024 03:21:44 -0700 (PDT)
Received: from vasant-suse.fritz.box ([2001:9e8:ab68:af00:6f43:17ee:43bd:e0a9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0d7b35d5sm290887766b.192.2024.06.10.03.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:21:43 -0700 (PDT)
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
Subject: [PATCH v6 10/10] x86/sev: Exclude AP jump table related code for SEV-SNP guests
Date: Mon, 10 Jun 2024 12:21:13 +0200
Message-Id: <20240610102113.20969-11-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610102113.20969-1-vsntk18@gmail.com>
References: <20240610102113.20969-1-vsntk18@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_032146_899601_B064DB24 
X-CRM114-Status: GOOD (  14.08  )
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

From: Vasant Karasulli <vkarasulli@suse.de>

Unlike SEV-ES, AP jump table technique is not used in SEV-SNP
when transitioning from one layer of code to another
(e.g. when going from UEFI to the OS).

Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
 arch/x86/kernel/sev.c    | 6 +++++-
 arch/x86/realmode/init.c | 5 +++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index e64320507da2..a9cf74512269 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1392,7 +1392,8 @@ STACK_FRAME_NON_STANDARD(sev_jumptable_ap_park);
 void sev_es_stop_this_cpu(void)
 {
 	if (!(cc_vendor == CC_VENDOR_AMD) ||
-	    !cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+	    !cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT) ||
+	     cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return;
 
 	/* Only park in the AP jump table when the code has been installed */
@@ -1468,6 +1469,9 @@ bool sev_kexec_supported(void)
 	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		return true;
 
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return false;
+
 	/*
 	 * KEXEC with SEV-ES and more than one CPU is only supported
 	 * when the AP jump table is installed.
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index f9bc444a3064..ed798939be5d 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -80,8 +80,9 @@ static void __init sme_sev_setup_real_mode(struct trampoline_header *th)
 		 */
 		th->start = (u64) secondary_startup_64_no_verify;
 
-		if (sev_es_setup_ap_jump_table(real_mode_header))
-			panic("Failed to get/update SEV-ES AP Jump Table");
+		if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+			if (sev_es_setup_ap_jump_table(real_mode_header))
+				panic("Failed to get/update SEV-ES AP Jump Table");
 	}
 #endif
 }
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
