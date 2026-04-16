Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38138F8A157
	for <kexec@archiver.kernel.org>; Thu, 16 Apr 2026 11:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=83G/JFf5TbAu/dcy7wbV8ZkTGlvEgBosGu//G/NV30c=; b=GKc2SxNPvfRvMZ+j2enVRKetNe
	qV5+k98Bv7FN5QRUYN6ytnghb2qgv74IWow5Fpio6AldaRIrGdW+LSjE+xyzqsbmwEPF7WRU69QC9
	C8riElwLpPsTv5oUZZuEW6ky1lBoBNyvXqGhmdcNT7zcm7UadDHPEFEJ4W9T2zKy6rSaK3KaA9cec
	IiHk0OZucyyk7pfCsjiuDH8nrIe9Np+Yk8k9RSiZ1bcOBaTkO0G6dNI9+HCREIcBq579WOJSd/pDB
	B5YtpjCrFAIu3kpzZ6S76bREAXPLQ6yXppvMb41qeLgYoAtYYu521m20UBBEDXS+5iSbdUiBvymP4
	3x2WRE6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDKYy-00000002LWz-0nCE;
	Thu, 16 Apr 2026 11:07:12 +0000
Received: from mail-lf1-x14a.google.com ([2a00:1450:4864:20::14a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDKYw-00000002LVH-2Nbp
	for kexec@lists.infradead.org;
	Thu, 16 Apr 2026 11:07:11 +0000
Received: by mail-lf1-x14a.google.com with SMTP id 2adb3069b0e04-5a3fdf4491bso3426825e87.3
        for <kexec@lists.infradead.org>; Thu, 16 Apr 2026 04:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776337628; x=1776942428; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=83G/JFf5TbAu/dcy7wbV8ZkTGlvEgBosGu//G/NV30c=;
        b=EZ2sNsN4MpZo5VMpzkFMC7OUk9y2wnqV+CXrq7W1PMfrLztzyQOwWh4kIpTozR9WuY
         2u8cb8QHAM31rT75aCfHOJrR3XaVBfl037BL5swmMub5oHowgvOF/lVI5Un02yS2IA7I
         HyUp57wXSqjTx/+oZ2sfev2slO7MlAekkQ1A3tgwcTZ1nMF0xLPTT+vVIg9R93L9ilfG
         wCNRXTIGI89kQ60Vmg2xlZt+YGKgvY01ldCocI7BF6fStIVlpIOsXPFYtf1Bt4GyDIzR
         b5h1NI2CCwr8m3U6p0KOPE5g2v7/MQ84SBvO8T0sTa3lLoxoYR3hRFcgALAZHyDXhvxy
         FUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776337628; x=1776942428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83G/JFf5TbAu/dcy7wbV8ZkTGlvEgBosGu//G/NV30c=;
        b=h9vLNWvfwjJmtefAz/PpXSuORcr+VOWW0Qeb/XreDWap2+orqIg8M+snubekB5dlFR
         etyTD0hDi0ba6hiEuervou31HtkNSfI26BOBvJYTOqvjZrD7MBVZ6CErZUNTyRJd2QTN
         JqS5oKi+g89z2RbwVY7D7u2MP9e1lrt2WIPgRyaZMjjhS2n7H8QPmAd0d9gmSqcxx2B7
         7w0IVfWTaYM/lxZdKIdpgiephuJ+/vWaZzfZQ4Y+KccuRGpDQlGNz/5ckn4XAp4HMEKN
         6ijKPGVr/nPfzucTbh0sc6OLfie+62NLrhHv2qvNuzz6MV9gC79dOCL8mLSJ4pVoOpEY
         SRRg==
X-Forwarded-Encrypted: i=1; AFNElJ8k+LV5H1lrjgWxkQoI2WKjyRUqDEt6r1rJl6HT5tqBSFZMVryEAZShumIDpYooEsl6AVM96A==@lists.infradead.org
X-Gm-Message-State: AOJu0YxRrp0L8jouobMePcu92jHPgsmSB6/l8vXdx7xxcFZuZj/fji0w
	0hzp9dfq9jUc+5Lh0TQaOTEdDiXR2x/3Xo++3aSrYwI3PMi3MRnpCZNURU2QoC5kUbelNrpL9ly
	gf/r755w3N1XGZsHLFh51Dg==
X-Received: from lfaz26.prod.google.com ([2002:a05:6512:21fa:b0:5a4:5d2:9524])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6512:b99:b0:5a1:2332:68f with SMTP id 2adb3069b0e04-5a3ef6e2732mr7016523e87.0.1776337627236;
 Thu, 16 Apr 2026 04:07:07 -0700 (PDT)
Date: Thu, 16 Apr 2026 13:06:54 +0200
In-Reply-To: <20260416110654.247398-1-mclapinski@google.com>
Mime-Version: 1.0
References: <20260416110654.247398-1-mclapinski@google.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260416110654.247398-3-mclapinski@google.com>
Subject: [PATCH v8 2/2] kho: make preserved pages compatible with deferred
 struct page init
From: Michal Clapinski <mclapinski@google.com>
To: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_040710_630472_6C7DF70C 
X-CRM114-Status: GOOD (  16.80  )
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

From: Evangelos Petrongonas <epetron@amazon.de>

When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, struct page
initialization is deferred to parallel kthreads that run later
in the boot process.

During KHO restoration, kho_preserved_memory_reserve() writes metadata
for each preserved memory region. However, if the struct page has not
been initialized, this write targets uninitialized memory, potentially
leading to errors like:
BUG: unable to handle page fault for address: ...

Fix this by introducing kho_get_preserved_page(),  which ensures
all struct pages in a preserved region are initialized by calling
init_deferred_page() which is a no-op when the struct page is already
initialized.

Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
Co-developed-by: Michal Clapinski <mclapinski@google.com>
Signed-off-by: Michal Clapinski <mclapinski@google.com>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/liveupdate/Kconfig          |  2 --
 kernel/liveupdate/kexec_handover.c | 27 ++++++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index 1a8513f16ef7..c13af38ba23a 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -1,12 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 menu "Live Update and Kexec HandOver"
-	depends on !DEFERRED_STRUCT_PAGE_INIT
 
 config KEXEC_HANDOVER
 	bool "kexec handover"
 	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
-	depends on !DEFERRED_STRUCT_PAGE_INIT
 	select MEMBLOCK_KHO_SCRATCH
 	select KEXEC_FILE
 	select LIBFDT
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index a507366a2cf9..d5718bef6d4d 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -473,6 +473,31 @@ struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages)
 }
 EXPORT_SYMBOL_GPL(kho_restore_pages);
 
+/*
+ * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, struct pages in higher memory regions
+ * may not be initialized yet at the time KHO deserializes preserved memory.
+ * KHO uses the struct page to store metadata and a later initialization would
+ * overwrite it.
+ * Ensure all the struct pages in the preservation are
+ * initialized. kho_preserved_memory_reserve() marks the reservation as noinit
+ * to make sure they don't get re-initialized later.
+ */
+static struct page *__init kho_get_preserved_page(phys_addr_t phys,
+						  unsigned int order)
+{
+	unsigned long pfn = PHYS_PFN(phys);
+	int nid;
+
+	if (!IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT))
+		return pfn_to_page(pfn);
+
+	nid = early_pfn_to_nid(pfn);
+	for (unsigned long i = 0; i < (1UL << order); i++)
+		init_deferred_page(pfn + i, nid);
+
+	return pfn_to_page(pfn);
+}
+
 static int __init kho_preserved_memory_reserve(phys_addr_t phys,
 					       unsigned int order)
 {
@@ -481,7 +506,7 @@ static int __init kho_preserved_memory_reserve(phys_addr_t phys,
 	u64 sz;
 
 	sz = 1 << (order + PAGE_SHIFT);
-	page = phys_to_page(phys);
+	page = kho_get_preserved_page(phys, order);
 
 	/* Reserve the memory preserved in KHO in memblock */
 	memblock_reserve(phys, sz);
-- 
2.54.0.rc1.555.g9c883467ad-goog


