Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46F2606A327
	for <kexec@archiver.kernel.org>; Sun, 25 Oct 2026 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ieSSghn3;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=hiqmziFH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=1V5FDGF/e6SVBVJsOb1x0mGzHREcuT+Gfnqc1J4W+DU=; b=ieSSghn3Ji++FB
	GywzRBZtI5ewIzeTOFw2Y3FjZ5xg+AixQ8FwPIX6hhABKZ+iPZVH7xPaz1QIR2AWb5RmL9ZV6N1Qu
	Lb2JkejkOTwbGv9ZvSPyzA47KwETtuTFrJ0qzpJIlRfz6h6dIClhIIAIWtsJcGPoPYgYu3DDUv8Ma
	b2nCCfISO8GfUE5Itdw8hjdGPacw8VfMFLjeowl9aLbPblZ0n4wbitxvl0WM9auZEAiFQQcDAKltI
	xJVsbI9K8GHUyA7B5ix5m7BX66vupE4zMpn/mk3uIfNK0SAJo2e2HsepCBiZyzXJt7/P1AazFNEgE
	uKF8DT39W5MNMM+je+cQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Cw-00000001F4v-1vhD;
	Sun, 25 Oct 2026 17:40:34 +0000
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Cr-00000001Evn-262p
	for kexec@lists.infradead.org;
	Sun, 25 Oct 2026 17:40:32 +0000
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-5eaabf28c06so2036282e0c.2
        for <kexec@lists.infradead.org>; Sun, 25 Oct 2026 10:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792950028; x=1793554828; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1V5FDGF/e6SVBVJsOb1x0mGzHREcuT+Gfnqc1J4W+DU=;
        b=hiqmziFHm3PdlsfOIi0R6945/MO4WNalvXN5nZTzzPYqtUTFuBq4edphbuDW9vnmFm
         oU/IVuoKpTSj9JjurNkWlNN4kQDxSvmZwNiRirJXt1OulqGVCY83LHyTUuzENMHxxoU/
         Dupznvjghl2ELybUJDRAT/YrGP+IqoX2/3wXGp+ndVzDDyMuQsIP33/47fqW3/V7Y2vk
         PiSUzuy9w3GvdlkY9BdcIlIBOl2FxtbzTAIoR3S4JdlIBY3NypZQQkzwdeL4eo5eI5Y4
         AgGSt0QJroQcTYQqTQvpvGfi9f6BMQ0LOsjL2/SkqRNmnyxOuQqIHkUPAZK0Dli2qOv0
         w1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792950028; x=1793554828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1V5FDGF/e6SVBVJsOb1x0mGzHREcuT+Gfnqc1J4W+DU=;
        b=mWRCYtvf/MYSZozURT1oZZcrySISbJhtiKJslecGObIKlfkuG+ITPhNiFMP5q+d3ah
         uQ75C0tsZtwOGFn/Sa6M4xeBIR5I2Ant/EEV8DU0r3laY3sK9mUBYnhLUYQGFIp0XvYv
         d46V5IzvAM05XsgRy9cSr335Oc1Erg0hjdRvIa7c2TYf+woWt2Aeg1TzJ05rgGBrFYAE
         Bzl/O4dzPd7yuFj+1uEHEob3pp60TwGLxNKLDwxpKOTjDRNbyL7mvJ40qMGjgJgR7ZOY
         lLOQ10uSB/1y8W9jXuuLesfksmmxRO9lVOkxpvbGaKdijDFEQimwN6W4aghX4BjLfPO6
         rO4A==
X-Forwarded-Encrypted: i=1; AKwUvBzCmqX+BGSSDZSg0P1ibQBEMzN6Ler1JycHK5fgM9WyqgQJPbfsgW9AY7Gh0f2nRj3LhyFbQQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYJyT08CXIUYUQFvZwhWL/c87fCU2gemIhMEAFmJFEecfpxDnFlF
	cHHs472FMU37BaJ1Ya0OvuqtqLw/3bzMmRCx29agfEnbmoIzumCiVjselsN/UQ1Q+8U=
X-Gm-Gg: AYBFou18aX2OjCD9/iGiXhh5RV1mldHgI825v0rxHetDUStx0HB0D5z0eMnFHd/Q8gz
	4DLuDnlula68mFt3CAxJIKZtjBiwIBrTy4t5NetHNWpMttPzBhzcJgFugZ6xRXmSyiJpQFDFtwr
	qRjBCT4lCPAD16Sq1fKNcr9R6RsaV3ap1nn1j0s24h4to+mUNv/S1FXK0XjSFXw+IKE03yWuf/j
	Co2p16NGZxoUJPluYZ+PKtYVuDMpGQ/NLyfY+xHDWcRvayfDRiiPBQO/l85NBW4rTxPUQXhYAbM
	H7G3o0rBpYJlqP6IL5Jr2+uv0uphy9su/shHMgeSi6FNNZl9zkylLdMy/1R136gazLrTUR4JMsS
	Hs86nh//4gm7LkQoXyLozGkqoRDBMlbw2rAiXZAfhbLHAABl2vqsvTW/6d0OZQ5Vwwl5aWY1SOS
	4p9Goaw9OuVG/+LKhsO3TmJVQO12RcXMsG2TH9E4tHjWfoFOFEtQP9+yL30sYOjx3DhxkBzowof
	VTElihxdwB2aBmMRTU3JYe3Ep7B1e2ElHkK50uo0P2bUQvcBzZsdqSKauvHh00mEVct1wNnorDg
	jd2gYXTV/Sap515DYr7JrnVxA8TLs4Q354yBLiB3SQpHJw4NKWk+sCqZq9BhNDSr/X5bmVag5Ew
	hL2GGjtSmZVvqEjDEBjM59A==
X-Received: by 2002:a05:6122:50a:b0:5ea:be1b:1b66 with SMTP id 71dfb90a1353d-5ec22ecf5f6mr1525623e0c.0.1792950028135;
        Sun, 25 Oct 2026 10:40:28 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec234673ebsm5783333e0c.13.2026.10.25.10.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 10:40:27 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	kuba@kernel.org,
	enelsonmoore@gmail.com,
	bp@alien8.de,
	shuah@kernel.org,
	david@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mhocko@suse.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	vbabka@kernel.org,
	dapeng1.mi@linux.intel.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	surenb@google.com,
	pasha.tatashin@soleen.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	elver@google.com,
	graf@amazon.com,
	lirongqing@baidu.com,
	liam@infradead.org,
	jlayton@kernel.org
Subject: [PATCH v2 6/9] kho: support read-only KHO mode in KHO core
Date: Sun, 25 Oct 2026 13:40:13 -0400
Message-ID: <20261025174017.3870481-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
References: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261025_104029_548940_C22A403E 
X-CRM114-Status: GOOD (  11.20  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When booted with 'kho_ro=<pa>', skip standard KHO bootmem and FDT
ingestion in kho_populate() before early_param parsing runs, disable
standard KHO in kho_memory_init() once early parameters are parsed, and
use kho_ro_get_fdt() in kho_retrieve_subtree().

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c        | 8 ++++++++
 kernel/liveupdate/kexec_handover_common.c | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 67efbdd39439..cc56caeecba7 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1819,6 +1819,11 @@ void __init kho_memory_init_early(void)
 
 void __init kho_memory_init(void)
 {
+	if (kho_is_ro()) {
+		kho_enable = false;
+		return;
+	}
+
 	if (is_kdump_kernel()) {
 		kho_enable = false;
 		pr_info("disabled in the kdump kernel\n");
@@ -1841,6 +1846,9 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 	bool populated = false;
 	int err;
 
+	if (kho_ro_cmdline_enabled())
+		return;
+
 	/* Validate the input FDT */
 	fdt = early_memremap(fdt_phys, fdt_len);
 	if (!fdt) {
diff --git a/kernel/liveupdate/kexec_handover_common.c b/kernel/liveupdate/kexec_handover_common.c
index dc25cb4c08af..a9bc8d45d3ba 100644
--- a/kernel/liveupdate/kexec_handover_common.c
+++ b/kernel/liveupdate/kexec_handover_common.c
@@ -263,7 +263,7 @@ phys_addr_t __init kho_get_mem_map_phys(const void *fdt)
  */
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys, size_t *size)
 {
-	const void *fdt = kho_get_fdt();
+	const void *fdt = kho_is_ro() ? kho_ro_get_fdt() : kho_get_fdt();
 	const u64 *val;
 	int offset, len;
 
-- 
2.56.0.307.g5fe7bd680c-goog


