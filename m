Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE60CA101F
	for <kexec@archiver.kernel.org>; Sun,  7 Sep 2025 07:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6qgDGmceY/oaPOGxDvJaE0QSmLhbdFfG6qh4SKtUo6k=; b=iIrSsukK7vSrq0EQvZi8PclEkl
	CD/RBeAnTtfuj8TXpaxcrascfIyM2KB9SzAhFbkrNBKfpVJa5AgoeZMBqjpllDLMf6oHIs4DjBiBb
	nDdC+GnZl1hJp6hDPvmo1lwnywY7DUll3RHqMzQgXQQp8I+HoboCBM3mjL7m26x9P03IMw7hs7J4K
	5KiiJT9qJtP3JGQEa/H0w40moWKP4By+szbgrzjS1XQoYU5kx6C747eO8jbla/ZOmMTy+KUf/zI2l
	ZCS6GTqise+h2EMNPIz+83PU2dQITpXfTOSmt12l4g1eSP82hmy/HzaKbmgbef5bBd7JvvwvtyK5U
	Q3I9bFsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uv9OL-00000009to4-2zUt;
	Sun, 07 Sep 2025 07:00:49 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uv9OJ-00000009tmF-1pPO
	for kexec@lists.infradead.org;
	Sun, 07 Sep 2025 07:00:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2D34643BFC;
	Sun,  7 Sep 2025 07:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2ADDC4CEFB;
	Sun,  7 Sep 2025 07:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757228447;
	bh=S6cq5Fd+Tt7edEdfLD7ze+ZKtAEEGtzWPj0q1zSXPO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HEZKwHsmg+QtBW5UFiuYs26fucUIr6wGXLeddggrTHC9Qgqatmc8T374QZ/+Eg7eN
	 3Cp2tnZpsbMiwBTqNfFboEAuvBqaFsEi2cwjiokLUKJf+eiR/hyZKhyERzjaRZiqKO
	 qWcUlZigxroFfPXhC2aRs9Liyf/KGq+idNdgxbi4uUL7csesh9HXkeB1uckoUz3h3N
	 oXUjzf1vww1oWvfB9l4KyHTe1abGjyAtQxaTXgFwnA3jM3KpdfipijBM6BFPCW5uo0
	 Asp36UxHGNj9ZisfH32xiFhzIDbj06EjDDQfURoMxacHCdyPXEaApf5f8glSSLDeCf
	 Lsnk/dTM0xRVg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Chris Li <chrisl@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] lib/test_kho: use kho_preserve_vmalloc instead of storing addresses in fdt
Date: Sun,  7 Sep 2025 10:00:22 +0300
Message-ID: <20250907070022.2177974-6-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250907070022.2177974-1-rppt@kernel.org>
References: <20250907070022.2177974-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250907_000047_519073_10AAEC6B 
X-CRM114-Status: GOOD (  13.65  )
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

KHO test stores physical addresses of the preserved folios directly in
fdt.
Use kho_preserve_vmalloc() instead of it and kho_restore_vmalloc() to
retrieve the addresses after kexec.

This makes the test more scalable from one side and adds tests coverage
for kho_preserve_vmalloc() from the other.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 lib/test_kho.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/lib/test_kho.c b/lib/test_kho.c
index fe8504e3407b..c46f577b6aee 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -32,6 +32,7 @@ module_param(max_mem, long, 0644);
 struct kho_test_state {
 	unsigned int nr_folios;
 	struct folio **folios;
+	phys_addr_t *folios_info;
 	struct folio *fdt;
 	__wsum csum;
 };
@@ -67,18 +68,15 @@ static struct notifier_block kho_test_nb = {
 
 static int kho_test_save_data(struct kho_test_state *state, void *fdt)
 {
-	phys_addr_t *folios_info;
+	phys_addr_t *folios_info __free(kvfree) = NULL;
+	phys_addr_t folios_info_phys;
 	int err = 0;
 
-	err |= fdt_begin_node(fdt, "data");
-	err |= fdt_property(fdt, "nr_folios", &state->nr_folios,
-			    sizeof(state->nr_folios));
-	err |= fdt_property_placeholder(fdt, "folios_info",
-					state->nr_folios * sizeof(*folios_info),
-					(void **)&folios_info);
-	err |= fdt_property(fdt, "csum", &state->csum, sizeof(state->csum));
-	err |= fdt_end_node(fdt);
+	folios_info = vmalloc_array(state->nr_folios, sizeof(*folios_info));
+	if (!folios_info)
+		return -ENOMEM;
 
+	err = kho_preserve_vmalloc(folios_info, &folios_info_phys);
 	if (err)
 		return err;
 
@@ -93,6 +91,17 @@ static int kho_test_save_data(struct kho_test_state *state, void *fdt)
 			break;
 	}
 
+	err |= fdt_begin_node(fdt, "data");
+	err |= fdt_property(fdt, "nr_folios", &state->nr_folios,
+			    sizeof(state->nr_folios));
+	err |= fdt_property(fdt, "folios_info", &folios_info_phys,
+			    sizeof(folios_info_phys));
+	err |= fdt_property(fdt, "csum", &state->csum, sizeof(state->csum));
+	err |= fdt_end_node(fdt);
+
+	if (!err)
+		state->folios_info = no_free_ptr(folios_info);
+
 	return err;
 }
 
@@ -210,7 +219,8 @@ static int kho_test_save(void)
 static int kho_test_restore_data(const void *fdt, int node)
 {
 	const unsigned int *nr_folios;
-	const phys_addr_t *folios_info;
+	const phys_addr_t *folios_info_phys;
+	phys_addr_t *folios_info;
 	const __wsum *old_csum;
 	__wsum csum = 0;
 	int len;
@@ -225,8 +235,12 @@ static int kho_test_restore_data(const void *fdt, int node)
 	if (!old_csum || len != sizeof(*old_csum))
 		return -EINVAL;
 
-	folios_info = fdt_getprop(fdt, node, "folios_info", &len);
-	if (!folios_info || len != sizeof(*folios_info) * *nr_folios)
+	folios_info_phys = fdt_getprop(fdt, node, "folios_info", &len);
+	if (!folios_info_phys || len != sizeof(*folios_info_phys))
+		return -EINVAL;
+
+	folios_info = kho_restore_vmalloc(*folios_info_phys);
+	if (!folios_info)
 		return -EINVAL;
 
 	for (int i = 0; i < *nr_folios; i++) {
@@ -246,6 +260,8 @@ static int kho_test_restore_data(const void *fdt, int node)
 		folio_put(folio);
 	}
 
+	vfree(folios_info);
+
 	if (csum != *old_csum)
 		return -EINVAL;
 
@@ -304,6 +320,7 @@ static void kho_test_cleanup(void)
 		folio_put(kho_test_state.folios[i]);
 
 	kvfree(kho_test_state.folios);
+	vfree(kho_test_state.folios_info);
 	folio_put(kho_test_state.fdt);
 }
 
-- 
2.50.1


