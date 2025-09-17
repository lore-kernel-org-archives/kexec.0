Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD09CAC5A0
	for <kexec@archiver.kernel.org>; Wed, 17 Sep 2025 17:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kyMiPACj5fwId4jIr03W23e+KjEOC5OIcVw+R/uLOwg=; b=ey10oxBmXS1cXUMWhAXv++MZq0
	REGj9S+GOK1XRufA6vKDYPUN3jTKEGBeQM17EXtitpQ7HZsCgZZNdcOT10gpFHQcYslIck5OhML3R
	xkr+4GKKcalrzYIVCw87Y84h/Dtykg4B58AVvt/qVnl2tmmnkcJeIDmJy0Hqj4lNFQszqBc6G8+yn
	yz9j8pCvyDTKim4QAWXNF8RJMW3UbSVZCbicqK2v/C6U7oXACslbOzHA2W818chnkFJBCEVoJHEty
	8FhKb8LqL3ZRQP/+zUIOHENlXOkNUqeppN+kyYV3rYGxu1+OM/as35xcjMBXPxsdeWO5zLr2cj0DV
	hPOlz5+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyw9J-0000000DfQ7-1v0j;
	Wed, 17 Sep 2025 17:40:57 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyw9I-0000000DfP4-24ov
	for kexec@lists.infradead.org;
	Wed, 17 Sep 2025 17:40:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E481E6024D;
	Wed, 17 Sep 2025 17:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E146C4CEFA;
	Wed, 17 Sep 2025 17:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758130855;
	bh=C/FWcnjtqXbXmArF2cJQxrpogJR0iVY010DR1LrFIwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iOltoQiY284U3hh2FAqR2YSLRiqan90fIeNrfxWEWrR29HIUddWKZ/avmPxyf4zyD
	 48SuIuMabx2PFhfGtKxw3xLX5yN5DEqSRLY46DPismYxhCr+uVHXdT9h6wZC73xizJ
	 2EccQO9M+RUx3o7svQ/39W44rBZFiTdpV+FOUQKTR4XmGqjI8B3m4HFfFOhU8jCI9W
	 U6dECIYw2T4DZvhsu7ot2HGYrYhT0HTxXaB3kbSYA5t4TAvDuAaUfh+9rcdHUvY7cR
	 0W9RdaJ1bnVhKXdiQ8D7OWCD48DIlzjcmC8dr3jhzyWngx+DLnlkD1R+QfW+UQ3Zp9
	 BqkAomc0Ys5BA==
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
Subject: [PATCH v4 4/4] lib/test_kho: use kho_preserve_vmalloc instead of storing addresses in fdt
Date: Wed, 17 Sep 2025 20:40:33 +0300
Message-ID: <20250917174033.3810435-5-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917174033.3810435-1-rppt@kernel.org>
References: <20250917174033.3810435-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index fe8504e3407b..60cd899ea745 100644
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
+	struct kho_vmalloc folios_info_phys;
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
 
@@ -209,8 +218,9 @@ static int kho_test_save(void)
 
 static int kho_test_restore_data(const void *fdt, int node)
 {
+	const struct kho_vmalloc *folios_info_phys;
 	const unsigned int *nr_folios;
-	const phys_addr_t *folios_info;
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
+	folios_info = kho_restore_vmalloc(folios_info_phys);
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


