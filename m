Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C4CCCF2DB
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 02:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PhWkLfOOfteM1FeePp68BcqpwCgdE0YNcf9YXtfJq5A=; b=BTIUh4hBrrbcSHVa3VvQoHeuHO
	dxEXqW+SHEk0Elxu+T/scVkRLsYzQpFdy3dGkVGJ3vEDQNuaSWwHKZOruj116NyLL/Uri0OpXr5bK
	t5hqgcTyNQtxzkPh824lqux7dHfboOt/M1lY/ENwgD3QB3vaen+c7IMcAv4mkK2e1MCvOaEF1y7ll
	tL05yqzgZlRhftn+N2VkftrEfZtl9Xbbu9hXMTtRFRDHUp83+7NNIT0xVzYw4KZhoa2+EiEviV93W
	FkhSDprztM1nGl15r8xnU5FObUKy+Zyj0O4bD5ukz95SQO7Gla11gpw78+BcBg6kmPrnKzAiXNacg
	S2jUWQvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcqZ-00000006RXn-1cRm;
	Mon, 19 Oct 2026 02:11:31 +0000
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcqX-00000006RU4-2xbB
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 02:11:30 +0000
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-7cc365db987so947705137.0
        for <kexec@lists.infradead.org>; Sun, 18 Oct 2026 19:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792375888; x=1792980688; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PhWkLfOOfteM1FeePp68BcqpwCgdE0YNcf9YXtfJq5A=;
        b=hiRVKsBqoQnpLi5e1e21ZtrX3bR+RQkBzQ+UEzePHzC2VyxBenYV3Yfkt8BXYZboWy
         HddOhxAt4DAOTVK++/CeMe3UA0yT+SmjYSLssZBRBPpzUcrwDQhI0p8AJwNPd/yEnUdN
         OJf46TyThxzgaHsWLGR2HYL/6cqSVXaN66bIMjUSIgqawd9FlOZVhci/2qFnry+VeKKI
         oLVK/hrZEm6kMyg/bcLDmAmTa6WlCYwnQpf8TBrqdU3kEqe8+FhCWcR8FP/4XtYF99+a
         tk9LSY/NhGi6BJ6BTFyN6cSo+bS4bf7k3SeAv+KwHq8DtwjRbh1bI2NV7kQemHlxJ07b
         uYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792375888; x=1792980688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PhWkLfOOfteM1FeePp68BcqpwCgdE0YNcf9YXtfJq5A=;
        b=dnQy1y4EzWM7E5++f89QCtJBiAqQmUD4pxWstx/uPFAu8EQeZeVeQaFOD3mSF3lcHI
         YzU1xcLgpc7cqDtwHtBtgJIa0ne6+5QLMSf9jevwtI088g5YODKrAVogQ2uD2xSnu2/l
         fpZF6scOrcPlF5i9NPgpzH6xdWHr67FYCDsyol+OfCtHku7WbfltjxFFVi6D3eQaaHQL
         Cii8GPhdo7AaVQTYJytN+lz0WoEvmraD18iSIyJkbbgDxFwHROYpu/Fn8TynGQV3cdLD
         B1Mm5TLa5DeLCVXl6XtPmgN7FJY0qab89M5LpjhjSQF+/wal1xnueiMaJQvEq7p2kXMz
         6lwg==
X-Forwarded-Encrypted: i=1; AKwUvBxO4HG1UZ+L0LcLyuVBBSLRgRTF6RsO9OjHgzMw/E225WrxoxOjrr0O6JLrF29EoAam2Y4gvA==@lists.infradead.org
X-Gm-Message-State: AFq9FYJ7fygmMZuVxlxtgN9n+OnPqESMbGhSQaQ+Yn/e6XbJB9ELhDA8
	7J6mWBka9vzUuVeOqusmWTJOMhqNdmjh+RcKXwg5waE1d+FA4pSjocIXPuPRdAMdj3A=
X-Gm-Gg: AYBFou1YewMJk3f4yyLI5h41cJjMFL11vCGcD7GLOZCfhQ2088j9+y0VT3+KER9jdVY
	ysaqyFowvn8Gcz1Nnc+sEoo9CBSFT6hFG+Hams2RAk5IqVblZANHZgUYEiVWztoIe03Y4FBntKA
	2YnGxf+WDmZY0r5lG7F4KOUc+ZZ5F8OccbapcCSaPr3pLjMXebpamk8C/qUDMIzz7a0zGNp0+Ad
	54ncP0L//9fW2k1ZvTulB0Oy5rdE8GyqnK3J+Jcl5qYUTymcoHuhrBn2PQB0myKWOoLgEIWxwk9
	OcnWBGTMdCBxThR+CL5ARGAET6Qkyxt0+bv0ktonQCYQgNcYDFicaXG8e4eFdUBVvsQxzd7Ys8e
	L0fnE4c/xpwKU2lNyw9euj8m4/U+9Y97DERAMuDrJc4cQ5vGC8gXl0yn08gP8qIxsk9V2yE/+jH
	hyMYM1E/d/jbTOvGp3t6yMNXwLtx1/C3JZ13fgQy5rmW4Ao/7iMaUa2NVgWtgCILwa+/t3OrfeA
	VKmvw4Pn8ucB0lR4w10/4YhqLMIOf9poivojaJWeuX78egEsj0HLR1JiClKMo2+87H7LLQZtvAd
	Eu2sDUW9rCucLqVVzMWNXBFe/RYDyA==
X-Received: by 2002:a05:6102:849b:20b0:7cc:3eb0:6ef5 with SMTP id ada2fe7eead31-7cc3eb09b24mr1037299137.11.1792375888447;
        Sun, 18 Oct 2026 19:11:28 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eabbd9ea2bsm4271383e0c.2.2026.10.18.19.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 19:11:28 -0700 (PDT)
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
Subject: [PATCH v1 7/8] kho: test: support read-only KHO mode in test_kho
Date: Sun, 18 Oct 2026 22:11:10 -0400
Message-ID: <20261019021111.990394-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261019021111.990394-1-pasha.tatashin@soleen.com>
References: <20261019021111.990394-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_191129_768219_9799F790 
X-CRM114-Status: GOOD (  16.54  )
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

Allow CONFIG_TEST_KEXEC_HANDOVER to be enabled with
CONFIG_KEXEC_HANDOVER_READONLY and update test_kho to verify preserved
state when booted in read-only KHO mode.

In read-only mode, test_kho retrieves the test FDT subtree, maps the FDT
folio via kho_ro_map_folio(..., PAGE_KERNEL_RO), restores the preserved
vmalloc folio descriptor array via kho_restore_vmalloc(), verifies each
folio's preserved order in the KHO radix tree via
kho_ro_lookup_folio_order(), maps each folio via kho_ro_map_folio() (and
unmaps via kho_ro_unmap()), and verifies the checksum over all preserved
pages.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 lib/Kconfig.debug |  2 +-
 lib/test_kho.c    | 68 ++++++++++++++++++++++++++++++++++-------------
 2 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 134b15a44625..74223ef8bd1c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3381,7 +3381,7 @@ config TEST_OBJPOOL
 config TEST_KEXEC_HANDOVER
 	bool "Test for Kexec HandOver"
 	default n
-	depends on KEXEC_HANDOVER
+	depends on KEXEC_HANDOVER || KEXEC_HANDOVER_READONLY
 	help
 	  This option enables test for Kexec HandOver (KHO).
 	  The test consists of two parts: saving kernel data before kexec and
diff --git a/lib/test_kho.c b/lib/test_kho.c
index aa6a0956bb8b..1e0f257a5854 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -239,7 +239,7 @@ static int kho_test_restore_data(const void *fdt, int node)
 	phys_addr_t *folios_info;
 	const __wsum *old_csum;
 	__wsum csum = 0;
-	int len;
+	int len, i;
 
 	node = fdt_path_offset(fdt, "/data");
 
@@ -259,11 +259,28 @@ static int kho_test_restore_data(const void *fdt, int node)
 	if (!folios_info)
 		return -EINVAL;
 
-	for (int i = 0; i < *nr_folios; i++) {
+	for (i = 0; i < *nr_folios; i++) {
 		unsigned int order = folios_info[i] & ~PAGE_MASK;
 		phys_addr_t phys = folios_info[i] & PAGE_MASK;
-		unsigned int size = PAGE_SIZE << order;
 		struct folio *folio;
+		size_t size;
+
+		if (order > MAX_PAGE_ORDER)
+			break;
+		size = PAGE_SIZE << order;
+
+		if (kho_is_ro()) {
+			void *addr;
+
+			if (kho_ro_lookup_folio_order(phys) != order)
+				break;
+			addr = kho_ro_map_folio(phys, PAGE_KERNEL_RO);
+			if (!addr)
+				break;
+			csum = csum_partial(addr, size, csum);
+			kho_ro_unmap(addr);
+			continue;
+		}
 
 		folio = kho_restore_folio(phys);
 		if (!folio)
@@ -278,50 +295,65 @@ static int kho_test_restore_data(const void *fdt, int node)
 
 	vfree(folios_info);
 
-	if (csum != *old_csum)
+	if (i != *nr_folios || csum != *old_csum)
 		return -EINVAL;
 
 	return 0;
 }
 
-static int kho_test_restore(phys_addr_t fdt_phys)
+static int kho_test_restore(phys_addr_t fdt_phys, size_t fdt_size)
 {
-	void *fdt = phys_to_virt(fdt_phys);
 	const unsigned int *magic;
-	int node, len, err;
+	int node, len, err = -EINVAL;
+	void *fdt;
+
+	if (!fdt_size)
+		return -EINVAL;
+
+	if (kho_is_ro()) {
+		if (kho_ro_lookup_folio_order(fdt_phys) < get_order(fdt_size))
+			return -EINVAL;
+		fdt = kho_ro_map_folio(fdt_phys, PAGE_KERNEL_RO);
+		if (!fdt)
+			return -EINVAL;
+	} else {
+		fdt = phys_to_virt(fdt_phys);
+	}
 
 	node = fdt_path_offset(fdt, "/");
 	if (node < 0)
-		return -EINVAL;
+		goto out_unmap;
 
 	if (fdt_node_check_compatible(fdt, node, KHO_TEST_COMPAT))
-		return -EINVAL;
+		goto out_unmap;
 
 	magic = fdt_getprop(fdt, node, "magic", &len);
 	if (!magic || len != sizeof(*magic))
-		return -EINVAL;
+		goto out_unmap;
 
 	if (*magic != KHO_TEST_MAGIC)
-		return -EINVAL;
+		goto out_unmap;
 
 	err = kho_test_restore_data(fdt, node);
-	if (err)
-		return err;
 
-	return 0;
+out_unmap:
+	if (kho_is_ro())
+		kho_ro_unmap(fdt);
+	return err;
 }
 
 static int __init kho_test_init(void)
 {
 	phys_addr_t fdt_phys;
+	size_t fdt_size;
 	int err;
 
-	if (!kho_is_enabled())
+	if (!kho_is_enabled() && !kho_is_ro())
 		return 0;
 
-	err = kho_retrieve_subtree(KHO_TEST_FDT, &fdt_phys, NULL);
+	err = kho_retrieve_subtree(KHO_TEST_FDT, &fdt_phys, &fdt_size);
 	if (!err) {
-		err = kho_test_restore(fdt_phys);
+		err = kho_test_restore(fdt_phys, fdt_size);
 		if (err)
 			pr_err("KHO restore failed\n");
 		else
@@ -330,7 +362,7 @@ static int __init kho_test_init(void)
 		return err;
 	}
 
-	if (err != -ENOENT) {
+	if (err != -ENOENT || kho_is_ro()) {
 		pr_warn("failed to retrieve %s FDT: %d\n", KHO_TEST_FDT, err);
 		return err;
 	}
-- 
2.56.0.176.g3575e65682-goog


