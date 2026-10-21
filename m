Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75781606A326
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 21:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ka94wfXl;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XlYkXzpJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ye8qF9ArKGBdPFIMK4xZwrbqVNgRvHSV8RgsR2NKKBQ=; b=Ka94wfXlpzUDVJ
	t+yn+7xU6DEQIPJS9K+w/P/Mu+0vu07t2mDPDmTxqdrOc1jjPXMEYgFoerSMQbfNiEaAKBV+sCHWM
	d7v0lN/VIUWO39hAFrnkhh4IygA0GDB6kvMxtt0QwB+cyOjhHnaHR1RUA4gdyVTwYqt7L6JA03Kjn
	5hk14QyptYC2XIXjygBTSC5TEylWvTqs+AulGq2N+DFIuwA7Q96O6RAgEDAm0WZnR1Dy6celk6Pxq
	qMRvWF09n0/9wdjv/Zo7EREnk8z8jMETedlBB1dadYq71WhhuHyzK8xmIXUHVRzcBdmLTKvkCkJKn
	0ILStpr5KqpCIWxIFrDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJdaf-0000000Cu71-3B9e;
	Wed, 21 Oct 2026 21:11:17 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJdac-0000000Cu5U-3wiG
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 21:11:16 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4a1d75f2f11so9080565e9.3
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 14:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792617073; x=1793221873; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ye8qF9ArKGBdPFIMK4xZwrbqVNgRvHSV8RgsR2NKKBQ=;
        b=XlYkXzpJxxofa/bbt/qykrS4aRLhEKWZFx2AK45Q4JBi/+XDx1tQHtxYSQsR8qqrFe
         lPr0p2PpUO3O/1B1Qq4mRGBoK0yJ2vnPgO6syOrQ9hV+wx5g2kR4H+uPNzbO1WcX4E6X
         gLkJRjQHITUAutjPaB3hhkPQj9YbdCEtNSzpKbtfupcrH35clbyx7DzK6ikJuvdvMpbf
         WVWqE3S71A4VV3EyTvpxo+NVUYTHPPFAnIi0YC0DEiPImTGLOBqb8a5iuUwBmfh/fl5c
         hec880EJqvaT/XXsmrAZYCBGkwJuMUkXqICDdrb7J0FUAOiT6eRAcDQdN8t3FhpNQnqz
         NhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792617073; x=1793221873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ye8qF9ArKGBdPFIMK4xZwrbqVNgRvHSV8RgsR2NKKBQ=;
        b=V0m46cZMru4QWS3QIUyxfkEHPKT1qKd8J8TokbakJEZJ3E/oyg1DuGs2Ps/qaIttBw
         v3xRhpirs9Zh2lP7S98NNDSVeUg01NzQgJIdzUul2YFemBvnvxxcRSplDQbxro3p70Kc
         BxxnnhDqChDWbMyf3kplzfcb2il6A1uhwQAbMlX++hbFnNnZ/b5yx4J2jKl5KUJc9ZVW
         6gvJQUnBIcJyERKjWn2Yl6cIwd/RdxsQYfIFjzSY1WfQpxqybySPJJhgtFa/npfUO1RX
         2CB798hfQ2vT3agh5ZHGUDhxV4LMD+zI3PIv+gwonG7riGuKGytmnzqMR0mF6bdOczRc
         lzpw==
X-Forwarded-Encrypted: i=1; AKwUvBzCR1arohBw46bUylBEk5OM9vqYGModlLeJkQrL1Px49mwyFg+Mmga1YQCLb8xzi3gr0kZhFA==@lists.infradead.org
X-Gm-Message-State: AFq9FYIwSDFu4zeJN2EM3kza2TLzfHwK3sRR7xED4TN6GWX3apm7wr95
	JFfrx/bV9vMNLIP2BZMCZMc9bvFbB4kOdLG9trTnD1/5DiECU4Jip2C4
X-Gm-Gg: AYBFou2PK2Lsi/CeCVL622CEH/F/WxynXJEctkb6UmxNTBp0VouTeJfkF0wS1KysXDJ
	HkwLboVMVY3obJWKZLfTm2hloUVNa4j9jy4RBz91pdiNyVjG69PPf8riQYChbGLpTR+mmeqlX+0
	absSHmy6jmtJvo92r4shTxmHGA8KJoCztm+NrJ3DQPrtPW3XG7m7NdX6S9Y7ydS+ravYbzZ6r9C
	ma8I9pB8b0hJdnJeigFo+3YasK7Ov12vYrCw8vi7xNJoUkXN1Rm9R9tVQkJHhx6ZfjsHyF8C4cJ
	jtB8o3rcxUqiGXZChMxW72qqxWCY7W0HCfwywpgQDiUn/CIJEgwzxyV96l/TYqCEeyqv/N6MOCM
	asN69OyuNz6S2X7L/thOsLGJCtODIiVJzJhTiuG2NIJBz70Kg/Ycoj+SfDSSrSPfIPhTvbofm5y
	zwnggM+xT7xQsAgtX2p34cxs2TfY/cRMjv3izcBMIPLcmm5Vc5c8t6dsLgghzCXI/UxUJyUl2xc
	Jx7o4g0ugPR14dNFL5djYpt1/2upv65b0QE3xsj
X-Received: by 2002:a05:600c:1d0f:b0:4a1:fbd5:26b0 with SMTP id 5b1f17b1804b1-4a1fdd15af8mr71632955e9.12.1792617072910;
        Wed, 21 Oct 2026 14:11:12 -0700 (PDT)
Received: from nobara ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203a25fb5sm22891525e9.6.2026.10.21.14.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 14:11:12 -0700 (PDT)
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>
Subject: [RFC PATCH 2/2] memblock: don't allocate reserve_mem regions from KHO bootmem
Date: Wed, 21 Oct 2026 23:10:46 +0200
Message-ID: <20261021211058.83483-3-azpijr@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021211058.83483-1-azpijr@gmail.com>
References: <20261021211058.83483-1-azpijr@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_141115_001292_08A415FE 
X-CRM114-Status: GOOD (  15.66  )
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
Cc: Tony Luck <tony.luck@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, Pratyush Yadav <pratyush@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On a KHO boot, a reserve_mem region that can't be revived is allocated
from KHO_NOPRSRV memory, which includes the bootmem the next kernel
boots out of. With CONFIG_KEXEC_HANDOVER_DEBUG, preserving the region
then fails:

  WARNING: kernel/liveupdate/kexec_handover.c:1245 at kho_preserve_pages+0x168/0x180
  failed to prepare memblock FDT for KHO: -22

Without it, the next kernel puts its memmap on top of the region and
the ramoops records in it are lost.

Use the search that keeps HugeTLB pages out of bootmem, and keep the
mirrored memory fallback of memblock_phys_alloc().

Fixes: f99230780211 ("memblock: add KHO support for reserve_mem")
Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
 mm/memblock.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index f43659688681..0fa9d6529285 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2761,6 +2761,33 @@ static bool __init reserve_mem_kho_revive(const char *name, phys_addr_t size,
 }
 #endif /* CONFIG_KEXEC_HANDOVER */
 
+/*
+ * The region gets preserved with KHO, so it can't be in KHO bootmem. On a KHO
+ * boot only KHO_NOPRSRV memory is used at this point, and that is more than
+ * just bootmem.
+ */
+static phys_addr_t __init reserve_mem_alloc(phys_addr_t size, phys_addr_t align)
+{
+	enum memblock_flags flags = choose_memblock_flags();
+	phys_addr_t start;
+
+	start = memblock_find_outside_kho_bootmem(size, align, NUMA_NO_NODE,
+						  flags);
+	if (!start && (flags & MEMBLOCK_MIRROR)) {
+		pr_warn("Could not allocate %pap bytes of mirrored memory\n",
+			&size);
+		start = memblock_find_outside_kho_bootmem(size, align,
+							  NUMA_NO_NODE,
+							  flags & ~MEMBLOCK_MIRROR);
+	}
+
+	if (!start || memblock_reserve_kern(start, size))
+		return 0;
+
+	memblock_prep_allocation(start, size, true);
+	return start;
+}
+
 /*
  * Parse reserve_mem=nn:align:name
  */
@@ -2829,8 +2856,7 @@ static int __init reserve_mem(char *p)
 	if (reserve_mem_kho_revive(name, size, align))
 		return 1;
 
-	/* TODO: Allocation must be outside of KHO_NOPRSRV region */
-	start = memblock_phys_alloc(size, align);
+	start = reserve_mem_alloc(size, align);
 	if (!start) {
 		pr_err("reserve_mem: memblock allocation failed\n");
 		return -ENOMEM;
-- 
2.55.0


