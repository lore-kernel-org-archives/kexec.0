Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF72606A323
	for <kexec@archiver.kernel.org>; Sun, 25 Oct 2026 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GUYeoBq9;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=BxQOsXLt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=QeCPVU+TT7xZWsohIOPLxgTp4DXEQmJIT8fXCzhydds=; b=GUYeoBq99KFuHz
	ZG3EUQgu9KKGdbpQgNjICzQMS+y2v+WoWmB9pYVCHc9yyqIixfjEa7XXr4wYTFK0c6x0RqeiJkd7L
	y6gmzIP7xRN/GwvdJ3POjva6Z4EYr5OV8pA2zneeYHTEY4FLdlt8kCs74U4kla3dxUo0Q13y/JKvB
	onthe4PloWDiyH1kKKDpDBS7hbHNW4c8bSJTuye/5IaJWxQ3iS9szAjVff7twS9ElX9Ik5nRbKWWr
	0xMr8fWWQarGytlmlB/tIZdZ5VN+KaXQoQPNXS4mpqMC7InWwLGDpo+w2jVcijckQPLohEqRQQ8z7
	0D0VUGFtQfzVqAaOf+Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Cw-00000001F5N-3aQr;
	Sun, 25 Oct 2026 17:40:34 +0000
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Ct-00000001Eym-2C5e
	for kexec@lists.infradead.org;
	Sun, 25 Oct 2026 17:40:33 +0000
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-5eae1276409so845898e0c.3
        for <kexec@lists.infradead.org>; Sun, 25 Oct 2026 10:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792950030; x=1793554830; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QeCPVU+TT7xZWsohIOPLxgTp4DXEQmJIT8fXCzhydds=;
        b=BxQOsXLtEr4hfA7FYiabX1YyJvQtVSYML0FW2KhYSSDekAFIVXs4+fGNUVb1Segdpp
         HXA7t6f8jZrb+5/RjbgWIlYsn8kRz78ii8t7mkDbaRG3cvsqyrTlWfX3agSzdYu0FK1l
         +1fIN1X6Ie8qQeVayJlxZw8rWMTvpO5E9quBi+Y88jQ0EdeNhZCxFpBl+cApKh4YKu7O
         Mu6ceIKzeQiwDB37k4eKU5FESITZPP6JVfY2bPjoKulxfQDxaAe6Na++KUBw5FUjRFod
         +EHoF4cGYQCvmxc3jJPnMbtY9J+VCvVqT12un421dWaYrltOrxDqUMf7FwwsuPJ1Kim/
         8luA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792950030; x=1793554830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QeCPVU+TT7xZWsohIOPLxgTp4DXEQmJIT8fXCzhydds=;
        b=zoRA/tEMguRbJlcvtwshWIVagx0DQCYcgweIgAcbLIn3hJKzTBEnoZCXuYShHY6fNm
         vcxFYmwkHT04T/7yERu/PP6PFgVtfPNJd7+Xp7EeNnGFBjUVjB+ykLXVwJ1Yy3UI7SBZ
         weExtSNg2TsBazJe+y8hZh6dS7q55pFIj9r2tF+Y9PHIVzaLcHRN7JXKE5dOloGjkaMg
         PW1o7Kkn8QIAjkKZtUyOp7bHScrJcrbb5JBx+bzgDe/drLbyoYE9ERQ/q9w9+1xZg3oB
         WKEVDR4N4ZVfodffgBx1CJidMo/gqMwmxa1+qOWPX0KEmZYZRq9vIYE4FvIet0kIyosD
         GHjQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7TKrG9GCsSOnZjhpLcQLLbGAS8pRhPsQ0zAyCFUWL+qEqYNuc+FGeUqzeluxqSvGQKMOxvw==@lists.infradead.org
X-Gm-Message-State: AFq9FYLR3nCkb/TL2BF2boCR7G4hZljTcDSo8BwpqaVgkEzx8O2Dct42
	89VSLO8UY20F2gc0y52/RM4K/l4mFu0D73vAiS6JgAm4bxqX3DQQw5/ykaBo2u3/eP4=
X-Gm-Gg: AYBFou0QYaXTV8qh/zklpTtkKXR/0HXLe5PDgKs5dWl4yf91X1l7Jqkhfl2Wm4rFjwq
	R9m3r+6+Bis5fUFHqNP+6TpJtNfYJwzA57hc9qH0QP1fGqPkffmuUOT1R2fF3onQUIQoVDGKfZv
	OlvUZITHCm6js75I02MjSEmcpEdi3tFIw5vngoDpKuFG5atvjQWA/QXE5wMLI+LxTX47z/jN9pz
	trBZBeBQIcW0qa/51zgEkNBifIFcTbuNovsCGV2kkaCK63DdvDjzl58bCAXPuTLaXRtAWPB/TGI
	RL85l03k7+n0IfI+69wo/lXj9K6EuSm5IX9dWPV5+FVPNxKpbXJobrzE3cUxjx/7rzjM0oVTmuy
	91vf9EcdUZ1+2+XYAdIkEwUK+fGhncXVKOvW5pxYfC85Q5Ndl7PS+uut4FsMddqpedCH5TnpZf1
	TaXKlZWAd9IzXKwcLVdgs/Lvy9tGB5XBOl4csU11JfwyKVquAYNywBRjtI1z/r9E1Ftn+bxxHAt
	8tDq64HjlZoaVmMAvk4PkMQs4ZZ+G6OIAxDU1BPRm79HlTLDLmNRPNpddgtGP+37GZP63ewmAjb
	T3IhCinWppFHogFjUVEmcs1YNobcwss3nk10b1lt/TDTFNcRKS/uxHCPNAyQqMnOHtW+xWN1P/U
	S
X-Received: by 2002:a05:6122:3d06:b0:5ea:f1eb:b9e2 with SMTP id 71dfb90a1353d-5ec232a31a4mr1273841e0c.19.1792950030175;
        Sun, 25 Oct 2026 10:40:30 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec234673ebsm5783333e0c.13.2026.10.25.10.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 10:40:29 -0700 (PDT)
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
Subject: [PATCH v2 8/9] kho: test: support read-only KHO mode in test_kho
Date: Sun, 25 Oct 2026 13:40:15 -0400
Message-ID: <20261025174017.3870481-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
References: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261025_104031_621504_C1C70E29 
X-CRM114-Status: GOOD (  17.97  )
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

test_kho currently depends on CONFIG_KEXEC_HANDOVER and restores
preserved folios via phys_to_virt() and kho_restore_folio(), which
prevents testing preserved KHO state when booted in read-only KHO mode.

Allow CONFIG_TEST_KEXEC_HANDOVER to be enabled with
CONFIG_KEXEC_HANDOVER_READONLY and update test_kho to verify preserved
state when kho_is_ro() is active. In read-only mode, retrieve the test
FDT subtree, map the FDT folio via kho_ro_map_folio(...,
PAGE_KERNEL_RO), map the preserved vmalloc folio descriptor array via
kho_ro_map_vmalloc(), verify each folio's preserved order in the KHO
radix tree via kho_ro_lookup_folio_order(), map each folio via
kho_ro_map_folio(), and verify the checksum over all preserved pages.
Also guard kho_test_exit() when no outgoing test FDT was allocated.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 lib/Kconfig.debug |  2 +-
 lib/test_kho.c    | 71 ++++++++++++++++++++++++++++++++++-------------
 2 files changed, 53 insertions(+), 20 deletions(-)

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
index aa6a0956bb8b..29029dcf5815 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -236,10 +236,10 @@ static int kho_test_restore_data(const void *fdt, int node)
 {
 	const struct kho_vmalloc *folios_info_phys;
 	const unsigned int *nr_folios;
-	phys_addr_t *folios_info;
+	const phys_addr_t *folios_info;
 	const __wsum *old_csum;
 	__wsum csum = 0;
-	int len;
+	int len, i;
 
 	node = fdt_path_offset(fdt, "/data");
 
@@ -255,15 +255,34 @@ static int kho_test_restore_data(const void *fdt, int node)
 	if (!folios_info_phys || len != sizeof(*folios_info_phys))
 		return -EINVAL;
 
-	folios_info = kho_restore_vmalloc(folios_info_phys);
+	if (kho_is_ro())
+		folios_info = kho_ro_map_vmalloc(folios_info_phys);
+	else
+		folios_info = kho_restore_vmalloc(folios_info_phys);
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
+			continue;
+		}
 
 		folio = kho_restore_folio(phys);
 		if (!folio)
@@ -276,19 +295,33 @@ static int kho_test_restore_data(const void *fdt, int node)
 		folio_put(folio);
 	}
 
-	vfree(folios_info);
+	if (!kho_is_ro())
+		vfree(folios_info);
 
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
+	int node, len;
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
@@ -304,24 +337,21 @@ static int kho_test_restore(phys_addr_t fdt_phys)
 	if (*magic != KHO_TEST_MAGIC)
 		return -EINVAL;
 
-	err = kho_test_restore_data(fdt, node);
-	if (err)
-		return err;
-
-	return 0;
+	return kho_test_restore_data(fdt, node);
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
@@ -330,7 +360,7 @@ static int __init kho_test_init(void)
 		return err;
 	}
 
-	if (err != -ENOENT) {
+	if (err != -ENOENT || kho_is_ro()) {
 		pr_warn("failed to retrieve %s FDT: %d\n", KHO_TEST_FDT, err);
 		return err;
 	}
@@ -355,6 +385,9 @@ static void kho_test_cleanup(void)
 
 static void __exit kho_test_exit(void)
 {
+	if (!kho_test_state.fdt)
+		return;
+
 	kho_remove_subtree(folio_address(kho_test_state.fdt));
 	kho_test_cleanup();
 }
-- 
2.56.0.307.g5fe7bd680c-goog


