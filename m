Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CDEC55173
	for <kexec@archiver.kernel.org>; Fri, 31 Jul 2026 21:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AKxRO57RwKQvgozbHnUQp+sB+wk0XehXYqNUOkWbMpk=; b=Rw2RC5dKjicxSilD6VV66KwfTL
	OcrOZSwb37rgvG88/ozqSIad3cCeSravSbUXIIaC3A295XWZjnmIn3qCiJkbCnrF9AFERzycvQcpA
	hyyDbCy8azZkvM44CShkYfN1lI+YkDk0OWPiL9MhmGXIKcbZCu66jDjSLmegY4wQk2B+x+D30svro
	bOOoUEkwNV5dmWcGeHh1kasdvfmMNPl1IZ+TDnScsmp6dhV0dIbpIX8uUrQ63O/8vIx8460zxdKRb
	ySQaGgJKhEY42kJrZuryJp/vjDd7BIB0TixbvA3X+0s1X2jlIOjIil+OVmq6pza2n+6q8/bPE1TSh
	V96Djl2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpvAV-0000000Ddu8-3rAv;
	Fri, 31 Jul 2026 21:53:27 +0000
Received: from mail-pj1-x1047.google.com ([2607:f8b0:4864:20::1047])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpvAT-0000000DdsR-02j1
	for kexec@lists.infradead.org;
	Fri, 31 Jul 2026 21:53:26 +0000
Received: by mail-pj1-x1047.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso1356613a91.2
        for <kexec@lists.infradead.org>; Fri, 31 Jul 2026 14:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785534804; x=1786139604; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AKxRO57RwKQvgozbHnUQp+sB+wk0XehXYqNUOkWbMpk=;
        b=JFFwbjk+csmYTaY5tK9Ie6sEd5Y9P1xaBF3ptGXu2GR31tD4o86jhZzmrT784Q384r
         hIs1kQvycuBLIFlO0Ul4bsovPll7TMAK1db28rOFCdwCylPdTCxoY6Ag7+nTCrfAttUK
         R0CQ5CIhDyPrsIvdjiwOGJuAjTu4wbU3bEVGtKWtqGSurVkB5M5zn17xg+NbfA49qnGW
         /wGIx/VJg513N149kYXkIoyWN2SWYkjY4QBEFKFw55a1f3PuN9ym+OM62vYlpRuGx8V5
         Cp0mrJ29l/4ns51p4AOmC88agDMEcohadeLYPkYi6pg+zKm0GMaCJcHqxbFSG/hoZ7GT
         51hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785534804; x=1786139604;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AKxRO57RwKQvgozbHnUQp+sB+wk0XehXYqNUOkWbMpk=;
        b=Kw/y90c030+IqixgpwUUO1rNKSCxNcHisxTEfVKaTznvhVUEK1UMuaxv5J203WPaPD
         xsYEBMftHgCxBK+v2/fL1Ll3PeI+46HgxJVmYCUeJT/fLPvstWaMlv8/1aeMZBdjR0pC
         s3fzJawLe+hqPDRVvK6RIX+fd045Tz0TVDMKB36aP/v7GkiA6cb3lmN9/+Lv0sbg57Pd
         aJXoPjRmYo8QTwis34HzKrFf+bWg9pA/CwJtU6czo54i5poCxXzyvPLV6V8ILtjhcu61
         foYssT/zLrAgm4Gr09YcD+9cjwcxtBxt0B+d99jw6QRrgn9Wny+3vbueml1nljNnCbDA
         qbVw==
X-Forwarded-Encrypted: i=1; AHgh+Rq+48ppYh2+WTiSILv/QnBTrKpN98l2M82Jgmw0UBBeANZ0unu6S2xzMMXG8FO8MwcSRyCWSg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwO9xmSkTuJSpD8xquGEnnmSs+wxTOA6yu2k+RYQy/YQ6Af5FMu
	3lc/fJaD9SGRGeRRcZGRWZrVyP7T2qz2PLXpKfZ4mR+1BIwJKJgX0c7fL6yeWhvmyrUEQ8CUfmI
	UTCceiDSNwuKv0Fwu8QU0SA==
X-Received: from dlan2-n1.prod.google.com ([2002:a05:7022:eb42:10b0:13b:9346:627a])
 (user=loganodell job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c41:b0:381:5a08:6291 with SMTP id 98e67ed59e1d1-38fbc4bc175mr1169108a91.20.1785534803987;
 Fri, 31 Jul 2026 14:53:23 -0700 (PDT)
Date: Fri, 31 Jul 2026 14:52:24 -0700
In-Reply-To: <20260731215224.831696-1-loganodell@google.com>
Mime-Version: 1.0
References: <20260731215224.831696-1-loganodell@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731215224.831696-5-loganodell@google.com>
Subject: [RFC PATCH 4/4] kho: Add test cases for versioned subtrees
From: Logan Odell <loganodell@google.com>
To: graf@amazon.com, rppt@kernel.org, pasha.tatashin@soleen.com
Cc: pratyush@kernel.org, akpm@linux-foundation.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Logan Odell <loganodell@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_145325_063459_3DE5E1CA 
X-CRM114-Status: GOOD (  17.99  )
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

Add new test cases to test_kho.c to verify saving and restoring
multiple versions of a subtree. The test preserves versions 1 and 2
of "kho_test_ver" and retrieves them, verifying their contents.
It also ensures no memory leaks occur during the restore process.

Signed-off-by: Logan Odell <loganodell@google.com>
---
 lib/test_kho.c | 266 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 245 insertions(+), 21 deletions(-)

diff --git a/lib/test_kho.c b/lib/test_kho.c
index 7ef9e4061869..db531da63576 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -310,52 +310,276 @@ static int kho_test_restore(phys_addr_t fdt_phys)
 	return 0;
 }
 
+static void kho_test_cleanup(void)
+{
+	/* unpreserve and free the data stored in folios */
+	kho_test_unpreserve_data(&kho_test_state);
+	for (int i = 0; i < kho_test_state.nr_folios; i++)
+		folio_put(kho_test_state.folios[i]);
+
+	kvfree(kho_test_state.folios);
+
+	/* Unpreserve and release the FDT folio */
+	kho_unpreserve_folio(kho_test_state.fdt);
+	folio_put(kho_test_state.fdt);
+}
+
+#define KHO_TEST_VER_NAME	"kho_test_ver"
+#define KHO_TEST_VER_1		1
+#define KHO_TEST_VER_2		2
+#define KHO_TEST_VER_MAGIC_1	0x11111111
+#define KHO_TEST_VER_MAGIC_2	0x22222222
+
+struct kho_test_versioned_state {
+	struct folio *fdt1;
+	struct folio *fdt2;
+};
+
+static struct kho_test_versioned_state kho_test_ver_state;
+
+static int kho_test_prepare_ver_fdt(struct folio *folio, int version, unsigned int magic)
+{
+	void *fdt = folio_address(folio);
+	int err;
+
+	err = fdt_create(fdt, PAGE_SIZE);
+	err |= fdt_finish_reservemap(fdt);
+	err |= fdt_begin_node(fdt, "");
+	err |= fdt_property(fdt, "compatible", KHO_TEST_COMPAT, sizeof(KHO_TEST_COMPAT));
+	err |= fdt_property(fdt, "magic", &magic, sizeof(magic));
+	err |= fdt_property(fdt, "version", &version, sizeof(version));
+	err |= fdt_end_node(fdt);
+	err |= fdt_finish(fdt);
+
+	return err;
+}
+
+static int kho_test_ver_save(void)
+{
+	struct kho_test_versioned_state *state = &kho_test_ver_state;
+	int err;
+
+	state->fdt1 = folio_alloc(GFP_KERNEL, 0);
+	if (!state->fdt1)
+		return -ENOMEM;
+
+	state->fdt2 = folio_alloc(GFP_KERNEL, 0);
+	if (!state->fdt2) {
+		err = -ENOMEM;
+		goto err_free_fdt1;
+	}
+
+	err = kho_preserve_folio(state->fdt1);
+	if (err)
+		goto err_free_fdt2;
+
+	err = kho_preserve_folio(state->fdt2);
+	if (err)
+		goto err_unpreserve_fdt1;
+
+	err = kho_test_prepare_ver_fdt(state->fdt1, KHO_TEST_VER_1, KHO_TEST_VER_MAGIC_1);
+	if (err)
+		goto err_unpreserve_fdt2;
+
+	err = kho_test_prepare_ver_fdt(state->fdt2, KHO_TEST_VER_2, KHO_TEST_VER_MAGIC_2);
+	if (err)
+		goto err_unpreserve_fdt2;
+
+	err = kho_add_subtree_version(KHO_TEST_VER_NAME, KHO_TEST_VER_1,
+				      folio_address(state->fdt1));
+	if (err)
+		goto err_unpreserve_fdt2;
+
+	err = kho_add_subtree_version(KHO_TEST_VER_NAME, KHO_TEST_VER_2,
+				      folio_address(state->fdt2));
+	if (err)
+		goto err_remove_ver1;
+
+	pr_info("KHO versioned test save succeeded\n");
+	return 0;
+
+err_remove_ver1:
+	kho_remove_subtree_version(KHO_TEST_VER_NAME, KHO_TEST_VER_1, folio_address(state->fdt1));
+err_unpreserve_fdt2:
+	kho_unpreserve_folio(state->fdt2);
+err_unpreserve_fdt1:
+	kho_unpreserve_folio(state->fdt1);
+err_free_fdt2:
+	folio_put(state->fdt2);
+	state->fdt2 = NULL;
+err_free_fdt1:
+	folio_put(state->fdt1);
+	state->fdt1 = NULL;
+	return err;
+}
+
+static int kho_test_ver_restore_one(phys_addr_t fdt_phys, int expected_version,
+				    unsigned int expected_magic)
+{
+	void *fdt = phys_to_virt(fdt_phys);
+	const unsigned int *magic;
+	const int *version;
+	int node, len;
+
+	node = fdt_path_offset(fdt, "/");
+	if (node < 0)
+		return -EINVAL;
+
+	if (fdt_node_check_compatible(fdt, node, KHO_TEST_COMPAT))
+		return -EINVAL;
+
+	magic = fdt_getprop(fdt, node, "magic", &len);
+	if (!magic || len != sizeof(*magic) || *magic != expected_magic)
+		return -EINVAL;
+
+	version = fdt_getprop(fdt, node, "version", &len);
+	if (!version || len != sizeof(*version) || *version != expected_version)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int kho_test_ver_restore(void)
+{
+	phys_addr_t fdt_phys1, fdt_phys2;
+	struct folio *fdt1 = NULL, *fdt2 = NULL;
+	int err;
+
+	err = kho_retrieve_subtree_version(KHO_TEST_VER_NAME, KHO_TEST_VER_1, &fdt_phys1);
+	if (err) {
+		if (err != -ENOENT)
+			pr_err("Failed to retrieve version 1: %d\n", err);
+		return err;
+	}
+
+	fdt1 = kho_restore_folio(fdt_phys1);
+	if (!fdt1) {
+		pr_err("Failed to restore FDT 1 folio\n");
+		return -EINVAL;
+	}
+
+	err = kho_retrieve_subtree_version(KHO_TEST_VER_NAME, KHO_TEST_VER_2, &fdt_phys2);
+	if (err) {
+		pr_err("Failed to retrieve version 2: %d\n", err);
+		goto out_put_fdt1;
+	}
+
+	fdt2 = kho_restore_folio(fdt_phys2);
+	if (!fdt2) {
+		pr_err("Failed to restore FDT 2 folio\n");
+		err = -EINVAL;
+		goto out_put_fdt1;
+	}
+
+	err = kho_test_ver_restore_one(fdt_phys1, KHO_TEST_VER_1, KHO_TEST_VER_MAGIC_1);
+	if (err) {
+		pr_err("Version 1 verification failed: %d\n", err);
+		goto out_put_fdt2;
+	}
+
+	err = kho_test_ver_restore_one(fdt_phys2, KHO_TEST_VER_2, KHO_TEST_VER_MAGIC_2);
+	if (err) {
+		pr_err("Version 2 verification failed: %d\n", err);
+		goto out_put_fdt2;
+	}
+
+	pr_info("KHO versioned test restore succeeded\n");
+
+out_put_fdt2:
+	folio_put(fdt2);
+out_put_fdt1:
+	folio_put(fdt1);
+	return err;
+}
+
+static void kho_test_ver_cleanup(void)
+{
+	struct kho_test_versioned_state *state = &kho_test_ver_state;
+
+	if (state->fdt1) {
+		kho_unpreserve_folio(state->fdt1);
+		folio_put(state->fdt1);
+		state->fdt1 = NULL;
+	}
+	if (state->fdt2) {
+		kho_unpreserve_folio(state->fdt2);
+		folio_put(state->fdt2);
+		state->fdt2 = NULL;
+	}
+}
+
+static void kho_test_ver_exit(void)
+{
+	struct kho_test_versioned_state *state = &kho_test_ver_state;
+
+	if (state->fdt1)
+		kho_remove_subtree_version(KHO_TEST_VER_NAME, KHO_TEST_VER_1,
+					   folio_address(state->fdt1));
+	if (state->fdt2)
+		kho_remove_subtree_version(KHO_TEST_VER_NAME, KHO_TEST_VER_2,
+					   folio_address(state->fdt2));
+	kho_test_ver_cleanup();
+}
+
 static int __init kho_test_init(void)
 {
 	phys_addr_t fdt_phys;
-	int err;
+	int err, ver_err;
+	bool restored = false;
 
 	if (!kho_is_enabled())
 		return 0;
 
+	// Try to restore non-versioned
 	err = kho_retrieve_subtree(KHO_TEST_FDT, &fdt_phys);
 	if (!err) {
 		err = kho_test_restore(fdt_phys);
-		if (err)
+		if (err) {
 			pr_err("KHO restore failed\n");
-		else
-			pr_info("KHO restore succeeded\n");
-
+			return err;
+		}
+		pr_info("KHO restore succeeded\n");
+		restored = true;
+	} else if (err != -ENOENT) {
+		pr_warn("failed to retrieve %s FDT: %d\n", KHO_TEST_FDT, err);
 		return err;
 	}
 
-	if (err != -ENOENT) {
-		pr_warn("failed to retrieve %s FDT: %d\n", KHO_TEST_FDT, err);
-		return err;
+	// Try to restore versioned
+	ver_err = kho_test_ver_restore();
+	if (!ver_err) {
+		restored = true;
+	} else if (ver_err != -ENOENT) {
+		pr_warn("KHO versioned restore failed: %d\n", ver_err);
+		return ver_err;
 	}
 
-	return kho_test_save();
-}
-module_init(kho_test_init);
+	if (restored)
+		return 0;
 
-static void kho_test_cleanup(void)
-{
-	/* unpreserve and free the data stored in folios */
-	kho_test_unpreserve_data(&kho_test_state);
-	for (int i = 0; i < kho_test_state.nr_folios; i++)
-		folio_put(kho_test_state.folios[i]);
+	// If we got here, it means both returned -ENOENT (first boot).
+	// So we save both.
 
-	kvfree(kho_test_state.folios);
+	err = kho_test_save();
+	if (err)
+		return err;
 
-	/* Unpreserve and release the FDT folio */
-	kho_unpreserve_folio(kho_test_state.fdt);
-	folio_put(kho_test_state.fdt);
+	ver_err = kho_test_ver_save();
+	if (ver_err) {
+		kho_remove_subtree(folio_address(kho_test_state.fdt));
+		kho_test_cleanup();
+		return ver_err;
+	}
+
+	return 0;
 }
+module_init(kho_test_init);
 
 static void __exit kho_test_exit(void)
 {
 	kho_remove_subtree(folio_address(kho_test_state.fdt));
 	kho_test_cleanup();
+	kho_test_ver_exit();
 }
 module_exit(kho_test_exit);
 
-- 
2.55.0.508.g3f0d502094-goog


